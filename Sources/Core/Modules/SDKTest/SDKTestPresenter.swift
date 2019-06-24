//
//  SDKTestPresenter.swift
//  HotBoxKit
//
//  Created by Mark Evans on 6/21/19.
// Copyright © 2019 3Advance LLC. All rights reserved.
//

import Foundation
import UIKit

class SDKTestPresenter: SDKTestPresentation {
    weak var view: SDKTestView?
    var interactor: SDKTestUseCase?
    var router: SDKTestWireframe?

    func viewDidLoad(_ vc: SDKTestViewController) {

    }
}

extension SDKTestPresenter: SDKTestInteractorOutput {

}
