//
//  SDKTestContract.swift
//  HotBoxKit
//
//  Created by Mark Evans on 6/21/19.
// Copyright © 2019 3Advance LLC. All rights reserved.
//

import Foundation
import UIKit

protocol SDKTestView: IndicatableView {
    var presenter: SDKTestPresentation? { get set }
}

protocol SDKTestPresentation: class {
    var view: SDKTestView? { get set }
    var router: SDKTestWireframe? { get set }
    func viewDidLoad(_ vc: SDKTestViewController)
}

protocol SDKTestUseCase: class {
    var output: SDKTestInteractorOutput? { get set }
}

protocol SDKTestInteractorOutput: class {
    
}

protocol SDKTestWireframe: class {
    var viewController: UIViewController? { get set }
    static func assembleModule(userId: String?) -> SDKTestViewController
}
