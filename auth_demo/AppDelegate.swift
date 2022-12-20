//
//  AppDelegate.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/12/14.
//

import Foundation
import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //code here
        FirebaseApp.configure()
        return true
    }
}
