//
//  StudentManager.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/11/15.
//

import SwiftUI
import Firebase

class StudentManager: ObservableObject {
    @Published var students:[Student] = []
    
    init(){
        fetechStudents()
    }
    
    //FireBase CRUD
    
    func fetechStudents(){ //Read
        
        students.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("Student")
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    
                    let dID = document.documentID
                    
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    
                    let student = Student(id: id,name: name, dID: dID)
                    
                    self.students.append(student)
                }
            }
        }
    }
    
    func addStudent(name:String){ //Create
        let db = Firestore.firestore()
        let ref = db.collection("Student").document()
        
        ref.setData(["name":name,"id":UUID().uuidString]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        fetechStudents()
    }
    
    func editStudent(id:String,name:String){ //Update
        let db = Firestore.firestore()
        let ref = db.collection("Student").document(id)
        
        ref.updateData(["name":name]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        fetechStudents()
    }
    
    func removeStudent(id:String){ //Delete
        let db = Firestore.firestore()
        db.collection("Student").document(id).delete()
        fetechStudents()
    }
    
    func findStudent(name:String){ //Search
        
        students.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("Student")
        
        ref.whereField("name", isEqualTo: name).getDocuments(){ snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for ducument in snapshot.documents {
                    let data = ducument.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let dID = data["dID"] as? String ?? ""

                    
                    let student = Student(id: id,name: name, dID: dID)
                    
                    self.students.append(student)
                }
            }
        }
    }
}
