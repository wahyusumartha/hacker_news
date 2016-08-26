//
//  Story.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation

struct Story {
    let title: String
    let datetime: String
    let urlAddress: String
    let previewImageAddress: String
}

// TODO:
// consider: should I write 'action' here?
struct StoryAction {
    func share(story: Story) {

    }
}
