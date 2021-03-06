//
//  NewStoriesViewController.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import UIKit

struct NewStoriesDataProvider {
    func fetchLoad(startIndex: Int, completionHandler: FeedFetchCompletionHandler) {
        // TODO: data layer
    }
    func fetchReload(completionHandler: FeedFetchCompletionHandler) {
        // TODO: data layer
    }
}

class NewStoriesViewController: StoriesListViewController {

    override var debug_id: String // just for debug purpose
    {
        return "New"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

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

    @IBAction func dumpgotoStoryView(sender: AnyObject) {
        print("New Stories - go to Story View")
    }

}
