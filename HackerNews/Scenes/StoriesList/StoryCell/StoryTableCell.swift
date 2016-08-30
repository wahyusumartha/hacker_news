//
//  StoryTableCell.swift
//  HackerNews
//
//  Created by Viet Nguyen Tran on 8/29/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import UIKit

class StoryTableCell: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
