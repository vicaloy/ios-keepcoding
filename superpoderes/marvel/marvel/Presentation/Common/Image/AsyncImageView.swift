//
//  AsyncImageView.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import SwiftUI

struct AsyncImageView<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: String?,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        if url != nil && URL(string: url!) != nil{
            _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: url!)!, cache: Environment(\.imageCache).wrappedValue))
        }else{
            _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: "https://www.google.com")!))
        }
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}
