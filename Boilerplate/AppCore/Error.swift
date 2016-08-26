//
//  Error.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation

enum Error: Int {
    case URLError                 = -6000
    case NetworkRequestFailed     = -6001
    case JSONSerializationFailed  = -6002
    case JSONParsingFailed        = -6003
}