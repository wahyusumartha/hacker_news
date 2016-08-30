//
//  FeedDataProviderProtocol.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation

typealias FeedFetchCompletionHandler = ([StoryProtocol]?, Error?) -> Void

protocol FeedDataProviderProtocol {
    func fetchLoad(startIndex: Int, count: Int, completionHandler: FeedFetchCompletionHandler)
    func fetchReload(count: Int, completionHandler: FeedFetchCompletionHandler) // startIndex = 0
}