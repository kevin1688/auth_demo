//
//  NewStudent.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/11/22.
//

import SwiftUI

struct NewStudent: View {
    @EnvironmentObject var studentManager: StudentManager
    @State private var name = ""
    @Binding var showPopup:Bool
    
    var body: some View {
        VStack{
            TextField("名稱", text: $name)
            
            Button {
                studentManager.addStudent(name: name)
                showPopup.toggle()
            } label: {
                Text("儲存")
            }

        }
    }
}

struct NewStudent_Previews: PreviewProvider {
    static var previews: some View {
        NewStudent(showPopup: .constant(false)).environmentObject(StudentManager())
    }
}
