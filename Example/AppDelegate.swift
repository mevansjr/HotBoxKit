//
//  AppDelegate.swift
//  Example
//
//  Created by Mark Evans on Jun 21, 2019.
//  Copyright © 2019 3Advance LLC. All rights reserved.
//

import UIKit
import HotBoxKit
import FirebaseCore

// MARK: - AppDelegate

/// The AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// The UIWindow
    var window: UIWindow?

    /// The RootViewController
    var rootViewController: UIViewController {
        return ViewController()
    }

    /// Application did finish launching with options
    ///
    /// - Parameters:
    ///   - application: The UIApplication
    ///   - launchOptions: The LaunchOptions
    /// - Returns: The launch result
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


//        let firebasePlistFileName = "GoogleService-Info"
//        let firebaseOptions = FirebaseOptions(contentsOfFile: Bundle.main.path(forResource: firebasePlistFileName, ofType: "plist")!)!
//        FirebaseApp.configure(options: firebaseOptions)

        FirebaseApp.configure()

        // Intialize HotBoxKit
        let config =
            HotBoxConfig(
                accessToken: Secure.shared.FirebaseAcessToken,
                senderId: Secure.shared.FirebaseSenderID,
                apiEndpoint: Secure.shared.FirebaseApiEndpoint
            )
        HotBoxKit.init(withConfig: config)

        // Initialize UIWindow
        self.window = .init(frame: UIScreen.main.bounds)
        // Set RootViewController
        self.window?.rootViewController = self.rootViewController
        // Make Key and Visible
        self.window?.makeKeyAndVisible()
        // Return positive launch
        return true
    }

}
