//
//  Student.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/11/15.
//

import SwiftUI

struct Student:Identifiable,Codable{
    
    var id:String
    var name:String
    var dID:String
    var pencils:[String]
    var des:[detail]
}

struct detail:Codable{
    var name:String
    var number:Int
}
