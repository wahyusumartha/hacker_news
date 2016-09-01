//
//  StoriesListViewModel_new.swift
//  HackerNews
//
//  Created by Viet Nguyen Tran on 9/1/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation
import RxSwift

protocol StoriesListViewModelProtocol {
    func refreshWanted()
    var stories: Observable<[Story]>! { get }
}

class StoriesListViewModel: ViewModelBaseClass, StoriesListViewModelProtocol {

    // MARK: Public
    func refreshWanted() {
        refreshDataStream.onNext()
    }
    var stories: Observable<[Story]>! {
        return _stories.asObservable()
    }

    override init() {
        super.init()

        setup() // initial setup

        loadDataAtBeginingStream.onNext() // load data on starting
    }

    // MARK: Private
    private var loadDataAtBeginingStream = PublishSubject<Void>()
    private var refreshDataStream = PublishSubject<Void>()
    private var reloadDataStream: Observable<Void> {
        return Observable.of(loadDataAtBeginingStream, refreshDataStream)
            .merge()

    }
    private var _stories = Variable<[Story]>([])
    private var disposeBag = DisposeBag()

    private func setup() {

        // reload data begin with `get all ids` first
        let allIdsRequestStream: Observable<[Int]> = reloadDataStream.flatMap { [unowned self] in
            self.dummyAllIdsRequest()
        }

        // get story one by one
        let storiesDataRequestStream: Observable<Story> = allIdsRequestStream.flatMap { (ids) in
            ids.toObservable()
        }.flatMap { [unowned self] id in
            self.dummyStoryRequest(id)
        }.takeUntil(refreshDataStream)

        // get a bunch of stories at a time, as we use `buffer`, we want to stop it when there no more stories to load
        let bunchRequestStream: Observable<[Story]> = storiesDataRequestStream.buffer(timeSpan: 1.5, count: 10, scheduler: MainScheduler.instance)
            .takeWhile { (stories) -> Bool in
                stories.count > 0
        }

        // need a timer to run `bunchRequestStream`
        let timer: Observable<Int> = Observable<Int>.interval(1.5, scheduler: MainScheduler.instance)
            .startWith(-1)
            .takeUntil(refreshDataStream)

        // build the loadmore stream
        let loadmoreRequestStream: Observable<[Story]> = Observable.zip(bunchRequestStream, timer) { (stories, _) -> [Story] in
            stories
        }

        // subscribe and update the date to `_stories`
        loadmoreRequestStream.subscribeNext { [unowned self](loadedMoreStories) in
            self._stories.value.appendContentsOf(loadedMoreStories)
        }.addDisposableTo(disposeBag)
    }

    // MARK: dummy data
    private func dummyAllIdsRequest() -> Observable<[Int]> {
        return Observable.create { observer in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                // dummy data
                var dummy = [Int]()
                for index in 0..<100 {
                    dummy.append(index)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    // emit (RxSwift)
                    observer.onNext(dummy)
                    observer.onCompleted()
                })
            })
            return NopDisposable.instance
        }
    }
    private func dummyStoryRequest(storyId: Int) -> Observable<Story> {
        return Observable.create({ (observer) -> Disposable in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                // dummy data
                let story = Story(title: "Title \(storyId)",
                    dateTime: "Jan20,2017",
                    previewImageURLAddress: "http://www.public.asu.edu/~camartin/plants/Plant%20html%20files/Cosmos%20magenta.JPG",
                    storyContentURLAddress: "https://github.com/DTVD/The-introduction-to-RxSwift-you-have-been-missing")
                dispatch_async(dispatch_get_main_queue(), {
                    // emit (RxSwift)
                    observer.onNext(story)
                    observer.onCompleted()
                })
            })
            return NopDisposable.instance
        })
    }
}