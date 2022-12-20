//
//  ContentView.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/11/1.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var studentManager:StudentManager
    
    @State var email = ""
    @State var password = ""
    
    @State var message = ""
    
    @State var statusIsLogin = true
    
    @State var showPopup = false
    
    @State var isSecured:Bool = true
    
    @State var searchName = ""
    
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if statusIsLogin {
            
            VStack {
                HStack{
                    TextField("輸入尋找名字", text: $searchName)
                    Button {
                        studentManager.findStudent(name: searchName)
                        
                    } label: {
                        Text("尋找")
                    }

                }.padding(.horizontal, 20)
                
                List{
                    ForEach(0..<studentManager.students.count, id:\.self){ index in
                        HStack {
                            VStack(alignment:.center) {
                                Text(studentManager.students[index].id)
                                Text(studentManager.students[index].name)
                                Text(studentManager.students[index].dID)
                                Text(studentManager.students[index].pencils[0])
                            }
                            Button {
                                var pens = studentManager.students[index].pencils
                                pens[0] = "black"
                                studentManager.otherEditStudent(id: studentManager.students[index].dID, pencils: pens)
                                self.time.upstream.connect().cancel()
                                
                            } label: {
                                Text("編輯")
                            }

                        }
                    }
                }
                NavigationView{
                    List{
                        ForEach(studentManager.students){ std in
                            HStack {
                                VStack(alignment:.center) {
                                    Text(std.id)
                                    Text(std.name)
                                    Text(std.dID)
                                    Text(std.pencils[0])
                                }
                                Button {
                                    var pens = std.pencils
                                    pens[0] = "black"
                                    studentManager.otherEditStudent(id: std.dID, pencils: pens)
                                } label: {
                                    Text("編輯")
                                }

                            }
                        }.onDelete { index in
                            studentManager.removeStudent(id: studentManager.students[index.first ?? 0].dID)
                        }.onSubmit {
                            
                        }
                        
                    }
                    .navigationTitle("Students")
                    .navigationBarItems(trailing: Button(action: {
                        showPopup.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }))
                    .sheet(isPresented: $showPopup) {
                        NewStudent(showPopup: $showPopup)
                    }
                }
            }
        }else{
            VStack {
                Text("提示訊息\n\(message)")
                    .frame(width: 300, height: 100)
                    .bold()
                
                TextField("Email", text: $email)
                ZStack(alignment: .trailing) {
                            Group {
                                if isSecured {
                                    SecureField("Password", text: $password)
                                } else {
                                    TextField("Password", text: $password)
                                }
                            }.padding(.trailing, 32)

                            Button(action: {
                                isSecured.toggle()
                            }) {
                                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                    .accentColor(.gray)
                            }
                        }
                Button(action: {
                    /*creatAccount(emailValue: email, passwordValue: password)*/
                    login()
                }) {
                    Text("Sign in")
                }
            }
            .padding()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            statusIsLogin = false
        }catch {
        }
    }
    
    func creatAccount(emailValue:String, passwordValue:String){
        Auth.auth().createUser(withEmail: emailValue, password: passwordValue){ reslut, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                message = error?.localizedDescription ?? ""
            }else{
                print(reslut?.debugDescription ?? "")
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                message = error?.localizedDescription ?? ""
            } else {
                print("success")
                statusIsLogin = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(StudentManager())
    }
}
