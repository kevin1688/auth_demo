//
//  Student.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/11/15.
//

import SwiftUI

struct Student: Identifiable,Encodable{
    
    var id:String
    var name:String
    var dID:String
    var pencils:[String]
}
