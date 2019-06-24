//
//  SDKTestViewController.swift
//  HotBoxKit
//
//  Created by Mark Evans on 6/21/19.
// Copyright © 2019 3Advance LLC. All rights reserved.
//

import Foundation
import UIKit

public class SDKTestViewController: BaseViewController {

    // MARK: Properties

    var presenter: SDKTestPresentation?
    var userId: String?

    // MARK: Initialization

    public init(nibFile nib: String = "SDKTestViewController") {
        super.init(nibName: nib, bundle: Bundle(for: SDKTestViewController.self))
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addPoolListener(userId: userId ?? "")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter?.viewDidLoad(self)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removePoolListener()
    }

    public override var shouldAutorotate: Bool {
        return true
    }

    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    public override var prefersStatusBarHidden: Bool {
        return false
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        self.removePoolListener()
    }

    override func syncPools(pool: Pool) {
        DispatchQueue.main.async {
            print("pool firebase :: start")
            self.poolItems.forEach({print("pool: \($0.id ?? "nil")")})
            print("pool firebase :: end")
        }
    }

    // MARK: Custom Methods

    func setupView() {
        
    }

    @IBAction func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SDKTestViewController: SDKTestView {
    func showActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func hideActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
