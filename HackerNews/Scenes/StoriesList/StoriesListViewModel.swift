//
//  StoriesListViewModel.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol StoriesListViewModelProtocol {
    var numberOfStories: Int { get }
    func storyDataViewModelAtIndexPath(indexPath: NSIndexPath) -> StoryViewModel
}

class StoriesListViewModel: ViewModelBaseClass {

//    // public: data source
//    var numberOfStories: Int {
//        return storiesData.value.count
//    }
//    func storyDataViewModelAtIndexPath(indexPath: NSIndexPath) -> StoryViewModel {
//        return storiesData.value[indexPath.row].viewModel
//    }

    // For Observing
    var storiesData = Variable<[Story]>([])

    // Internal Data
    private var allRemoteStoriesIds = Variable<[Int]>([])
    private let countPerLoad: Int! = 10
    private var lastLoadedIndex: Int! = -1

    private let loadmoreInterval: NSTimeInterval = 3

    private let backgroundScheduler = SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Default)

    private let disposeBag = DisposeBag()
    private var timerDisposeBag: DisposeBag?

    override init() {
        super.init()

        setup()
    }

    private func setup() {
        // load the list of all stories ids first
        retrieveAllRemoteStoriesIds()
            .subscribeOn(backgroundScheduler)
            .bindTo(allRemoteStoriesIds)
            .addDisposableTo(disposeBag)

        // after having the list of ids, start loading data
        allRemoteStoriesIds.asObservable()
            .subscribeNext { [weak self] _ in
                self?.startRepeatingLoadDataRequest()
        }
            .addDisposableTo(disposeBag)
    }

    // load all stories ids
    private func retrieveAllRemoteStoriesIds() -> Observable<[Int]> {
        return Observable.create { observer in

            // TODO: make request by FeedDataProvider / Alamofire / Moya

            // dummy data
            var dummy = [Int]()
            for index in 0..<100 {
                dummy.append(index)
            }

            // emit (RxSwift)
            observer.onNext(dummy)
            observer.onCompleted()
            return AnonymousDisposable {
                // TODO: cancel request
            }
        }
    }

    private func startRepeatingLoadDataRequest() {

        func stopTimer() {
            self.timerDisposeBag = nil
        }
        timerDisposeBag = DisposeBag()

        // start timer
        let timer = Observable<Int>.interval(loadmoreInterval, scheduler: MainScheduler.instance)

        timer
//            .subscribeOn(MainScheduler.instance)
        .observeOn(backgroundScheduler)
            .startWith(-1) // to start timer immediately
        .flatMap { [weak self] _ -> Observable<[Story]> in

            let startIndex = (self?.lastLoadedIndex)! + 1

            if startIndex >= self?.allRemoteStoriesIds.value.count { // no more data, then stop timer
                stopTimer()
                return Observable.empty()
            }
            else { // load more
                self?.lastLoadedIndex = (self?.lastLoadedIndex)! + (self?.countPerLoad)!
                return self?.retrieveStoriesRequest(startIndex: startIndex, count: (self?.countPerLoad)!) ?? Observable.empty()
            }
        }
            .observeOn(MainScheduler.instance)
            .subscribeNext { [weak self] newStories in
                self?.storiesData.value.appendContentsOf(newStories) // bind data to storiesData
        }
            .addDisposableTo(timerDisposeBag!)
    }

    // load stories data
    private func retrieveStoriesRequest(startIndex startIndex: Int, count: Int) -> Observable<[Story]> {
        return Observable.create { observer in
            // TODO: call FeedDataProviderProtocol.fetchLoad(...) / Alamofire/ Moya

            // dummy data
            var dummy = [Story]()
            for index in startIndex...(startIndex + count - 1) {
                let story = Story(title: "Title \(index)",
                    dateTime: "Jan20,2017",
                    previewImageURLAddress: "http://www.public.asu.edu/~camartin/plants/Plant%20html%20files/Cosmos%20magenta.JPG",
                    storyContentURLAddress: "http://google.com")
                dummy.append(story)
            }

            // emit (RxSwift)
            observer.onNext(dummy)
            observer.onCompleted()
            return AnonymousDisposable {
                // TODO: cancelRequest
            }
        }
    }

}

