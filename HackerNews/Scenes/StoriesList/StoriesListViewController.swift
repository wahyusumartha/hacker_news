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
    typealias Item = StoryViewModel

    init(original: SectionOfStory, items: [Item]) {
        self = original
        self.items = items
    }
}

/// StoriesListViewController
class StoriesListViewController: ViewControllerMVVMBaseClass {

    private let tableDataSourceLogic = RxTableViewSectionedReloadDataSource<SectionOfStory>()
    private var sections = [SectionOfStory(items: [StoryViewModel]())] // start with empty data
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

            cell.previewImageView.kf_setImageWithURL(NSURL(string: item.previewImageURLAddress)!, placeholderImage: UIImage(named: "image_preview_placeholder")) // lazy load using Kingfisher

            cell.titleLabel.text = item.title
            cell.dateTimeLabel.text = item.dateTimeFriendly

            return cell
        }

        // update data
        let viewModel = mvvmViewModel as! StoriesListViewModel
        let updateSectionsStream = viewModel.stories.map { [unowned self](storyVMs) -> [SectionOfStory] in
            print(NSDate())
            print("receive data, count \(storyVMs.count)")
            let origionalSection = self.sections[0]
            self.sections[0] = SectionOfStory(original: origionalSection, items: storyVMs)
            return self.sections
        }
        // bind data to tableview
        updateSectionsStream.bindTo(tableView.rx_itemsWithDataSource(tableDataSourceLogic))
            .addDisposableTo(disposeBag)
    }
}
