//
//  StoriesListViewModel.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation
import RxSwift

class StoriesListViewModel: ViewModelBaseClass {
    var stories: Observable<[Story]>!
}