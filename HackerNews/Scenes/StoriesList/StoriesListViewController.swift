//
//  StoriesListViewController.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher

struct SectionOfStory {
    var items: [Item]
}

extension SectionOfStory: SectionModelType {
//    typealias Item = StoryProtocol // TODO: why this fail?
    typealias Item = Story

    init(original: SectionOfStory, items: [Item]) {
        self = original
        self.items = items
    }
}

/// StoriesListViewController
class StoriesListViewController: ViewControllerMVVMBaseClass {

    private let tableDataSourceLogic = RxTableViewSectionedReloadDataSource<SectionOfStory>()
    private var sections: [SectionOfStory]! = []
    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mvvmViewModel = StoriesListViewModel()
        setupRxDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}

extension StoriesListViewController { // RxDataSource
    func setupRxDataSource() {

        // datasource logic
        tableView.registerNib(UINib(nibName: "StoryTableCell", bundle: nil), forCellReuseIdentifier: "StoryTableCell")
        tableDataSourceLogic.configureCell = { (dataSource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCellWithIdentifier("StoryTableCell", forIndexPath: indexPath) as! StoryTableCell
            print("show cell")

            cell.previewImageView.kf_setImageWithURL(NSURL(string: item.previewImageURLAddress)!, placeholderImage: UIImage(named: "image_preview_placeholder")) // lazy load using Kingfisher

            cell.titleLabel.text = item.title
            cell.dateTimeLabel.text = item.dateTime

            return cell
        }

        // update data
        let viewModel = mvvmViewModel as! StoriesListViewModel
        sections = [SectionOfStory(items: [Story]())] // start with empty data
        viewModel.storiesData.asObservable()
            .map { [weak self] stories -> [SectionOfStory] in
                print("data ok")
                print("count: \(stories.count)")
                let origionalSection = self?.sections[0]
                self?.sections[0] = SectionOfStory(original: origionalSection!, items: stories)
                return (self?.sections)!
        }
            .bindTo(tableView.rx_itemsWithDataSource(tableDataSourceLogic))
            .addDisposableTo(disposeBag)
    }
}

//extension StoriesListViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        return nil
//    }
//
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
//    }
//
//}
