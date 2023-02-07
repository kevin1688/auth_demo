//
//  IndexDemo.swift
//  auth_demo
//
//  Created by kai wen chen on 2023/2/7.
//

import SwiftUI

struct IndexDemo: View {
    
    @State var index = 0
    
    var body: some View {
        VStack {
            Text("\(dataDemo[index])")
                .padding(50)
            
            HStack {
                Text("上一題").onTapGesture {
                    if (0 < index){
                        index = index - 1
                    }
                }
                Text("下一題").onTapGesture {
                    if (index < 2){
                        index = index + 1
                    }
                }
            }
        }
    }
}

struct IndexDemo_Previews: PreviewProvider {
    static var previews: some View {
        IndexDemo()
    }
}

let dataDemo = [
    "One",
    "Two",
    "Three"
]
