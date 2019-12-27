//
//  AppDelegate.swift
//  test_ui
//
//  Created by Dimas on 26.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		self.window = UIWindow()
		
		self.window?.rootViewController = UINavigationController(rootViewController: MainViewController())
		
		self.window?.makeKeyAndVisible()
		
		return true
	}

	


}

