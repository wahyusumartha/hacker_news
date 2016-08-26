//
//  FeedDataProviderProtocol.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation

let countPerPage = 10 // maximum 10 item each fetch

typealias FeedFetchCompletionHandler = ([Story]?, Error?) -> Void

protocol FeedDataProviderProtocol {
    func fetchLoad(startIndex: Int, completionHandler: FeedFetchCompletionHandler)
    func fetchReload(completionHandler: FeedFetchCompletionHandler) // startIndex = 0
}