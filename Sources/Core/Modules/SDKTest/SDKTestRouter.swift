//
//  SDKTestRouter.swift
//  HotBoxKit
//
//  Created by Mark Evans on 6/21/19.
// Copyright © 2019 3Advance LLC. All rights reserved.
//

import Foundation
import UIKit

public class SDKTestRouter: SDKTestWireframe {
    public var viewController: UIViewController?

    public static func assembleModule(userId: String?) -> SDKTestViewController {
        let view = SDKTestViewController()
        view.userId = userId
        let presenter = SDKTestPresenter()
        let interactor = SDKTestInteractor()
        let router = SDKTestRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
