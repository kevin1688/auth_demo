//
//  ImageView.swift
//  auth_demo
//
//  Created by kai wen chen on 2022/12/28.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:FImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = FImageLoader(urlString:url)
    }

    var body: some View {
        
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
                .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
