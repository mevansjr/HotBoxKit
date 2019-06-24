//
//  ViewController.swift
//  Example
//
//  Created by Mark Evans on Jun 21, 2019.
//  Copyright © 2019 3Advance LLC. All rights reserved.
//

import UIKit
import HotBoxKit

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {

    // MARK: Properties

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("🚀\nHotBoxKit\nExample", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: View-Lifecycle
    
    /// View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupView()
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    /// LoadView
    override func loadView() {
        self.view = self.button
    }

    func setupView() {
        self.loadData()
    }

    func loadData() {
        HotBoxService.shared.getMe { (success, error) in
            if let err = error {
                print("Error: \(err.domain)")
                return
            }
            else if let user = success as? UserApi, let json = user.toJSONString(prettyPrint: true) {
                print("User: \(json)")
                let vc = SDKTestRouter.assembleModule(userId: user.id)
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

    @objc func buttonAction() {
        self.loadData()
    }
}
