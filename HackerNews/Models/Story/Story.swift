//
//  Story.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation

protocol StoryProtocol {
    var title: String { get }
    var dateTime: String { get }
    var previewImageURLAddress: String { get }
    var storyContentURLAddress: String { get }
}

struct Story: StoryProtocol {
    let title: String
    let dateTime: String
    let previewImageURLAddress: String
    let storyContentURLAddress: String

    var viewModel: StoryViewModel {
        return StoryViewModel(storyData: self)
    }
}

// TODO:
// consider: should I write 'action' here?
struct StoryAction {
    func share(story: StoryProtocol) {

    }
}
