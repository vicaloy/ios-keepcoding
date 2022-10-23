//
//  CharacterDetailView.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
        ZStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            self.isNavigationBarHidden = true
        }
        
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    
    static var isNavigationBarHidden: Binding<Bool> = .constant(true)
    
    static var previews: some View {
        
        CharacterDetailView(isNavigationBarHidden: isNavigationBarHidden)
    }
}
