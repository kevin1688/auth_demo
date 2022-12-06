//
//  auth_demoApp.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/11/1.
//

import SwiftUI
import Firebase

@main
struct auth_demoApp: App {
    @StateObject var studentManager = StudentManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(studentManager)
        }
    }
}
