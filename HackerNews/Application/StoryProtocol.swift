//
//  StoryDataProtocol.swift
//  HackerNews
//
//  Created by Viet Nguyen Tran on 8/29/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation

protocol StoryProtocol {
    var title: String { get }
    var dateTime: String { get }
    var previewImageURLAddress: String { get }
    var storyContentURLAddress: String { get }
}