//
//  AppDelegate.swift
//  LuberProject
//
//  Created by Victor S Melo on 22/06/17.
//  Copyright © 2017 Victor S Melo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //set build version
        GameAnalytics.configureBuild("1.0.0")
        GameAnalytics.initialize(withGameKey: "b6a2ca1fd4eb67c1b0dc0ecddb3ef166", gameSecret: "7f31e4f8d2074556e02810f4713bd09b5dedfc26")
        
        return true
    }

}

