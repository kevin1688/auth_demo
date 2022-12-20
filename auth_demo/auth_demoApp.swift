//
//  auth_demoApp.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/11/1.
//

import SwiftUI

@main
struct auth_demoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var studentManager = StudentManager()
    
    init(){
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(studentManager)
        }
    }
}
