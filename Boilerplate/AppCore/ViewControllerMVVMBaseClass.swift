//
//  ViewControllerBaseClass.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import UIKit

// TODO: why generics result in error???? http://stackoverflow.com/questions/36636719/uiviewcontroller-class-with-generic-gives-error-unknown-class-in-interface-bu
//class ViewControllerMVVMBaseClass <T: ViewModelBaseClass>: UIViewController {
//
//    var mvvmViewModel: T?
//
//    init(viewModel: T, nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        self.mvvmViewModel = viewModel
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    convenience init(viewModel: T) {
//        self.init(viewModel: viewModel, nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}

class ViewControllerMVVMBaseClass: UIViewController {

    var mvvmViewModel: ViewModelBaseClass?

    init(viewModel: ViewModelBaseClass, nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.mvvmViewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    convenience init(viewModel: ViewModelBaseClass) {
        self.init(viewModel: viewModel, nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}