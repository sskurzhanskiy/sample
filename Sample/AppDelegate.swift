//
//  AppDelegate.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 24.09.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        let authService = MockAuthService()
        let authService = BackendAuthService()
        let authenticationViewController = AuthenticationViewController()
        authenticationViewController.onAuthenticationRequest = { [weak authenticationViewController] in
            authenticationViewController?.processingState = .processing
            authService.authentication { (isSuccess) in
                if isSuccess {
                    UIApplication.shared.windows.first?.rootViewController = TwitterListViewController()
                } else {
                    authenticationViewController?.processingState = .error
                }
            }
        }

        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.rootViewController = authenticationViewController
        
        self.window = window

        window.makeKeyAndVisible()

        return true
    }
}

