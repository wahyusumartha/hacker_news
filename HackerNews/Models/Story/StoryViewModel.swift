//
//  StoryDataViewModel.swift
//  HackerNews
//
//  Created by Viet Nguyen Tran on 8/30/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation

// TODO: consider to use Rx with MVVM architecture

class StoryViewModel {
    private let storyData: Story

    init(storyData: Story) {
        self.storyData = storyData
    }
}

extension StoryViewModel {

    var title: String {
        return storyData.title
    }

    var dateTimeFriendly: String {
        return storyData.dateTime // TODO: format
    }

    var previewImageURLAddress: String {
        return storyData.previewImageURLAddress
    }

    var storyContentURLAddress: String {
        return storyData.storyContentURLAddress
    }

}