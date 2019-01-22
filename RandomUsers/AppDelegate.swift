//
//  AppDelegate.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/21/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        return true
    }

    // MARK: - Appearance Customization
    
    private func setupAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.peachTint
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey(rawValue:NSAttributedStringKey.foregroundColor.rawValue):UIColor.white]
    }

}

