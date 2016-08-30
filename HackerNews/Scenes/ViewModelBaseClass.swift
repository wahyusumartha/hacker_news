//
//  ViewModelBaseClass.swift
//  Boilerplate
//
//  Created by Viet Nguyen Tran on 8/26/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import Foundation
import UIKit

protocol MoveScreenDelegate: class {
    func viewModel(viewModel: ViewModelBaseClass, moveScreen: MoveScreenEvent)
}

enum MoveScreenEvent {
    // Navigation
    case Push(UIViewController)
    case Pop

    // Modal view
    case Present(UIViewController)
    case Dismiss
}

// ViewModelBaseClass

class ViewModelBaseClass {
    // utility: move screen
    private weak var moveScreenDelegate: MoveScreenDelegate?
    func pushTo(nextViewController: UIViewController) {
        moveScreenDelegate?.viewModel(self, moveScreen: .Push(nextViewController))
    }
    func pop() {
        moveScreenDelegate?.viewModel(self, moveScreen: .Pop)
    }
    func present(nextViewController: UIViewController) {
        moveScreenDelegate?.viewModel(self, moveScreen: .Present(nextViewController))
    }
    func dismiss() {
        moveScreenDelegate?.viewModel(self, moveScreen: .Dismiss)
    }
}

// for draft
//protocol ViewModelBaseProtocol {
//
//}