//
//  Nav.swift
//  marvel
//
//  Created by Victoria Aloy on 23/10/22.
//

import SwiftUI

struct Nav: View {
    
    init(){
        setAppearance()
    }
        var body: some View {
            NavigationView {
                Text("Middle")
                .navigationTitle("MARVEL")
                
            }
            
        }
}

func setAppearance(){
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = MarvelColor.red
    
    let attrs: [NSAttributedString.Key: Any] = [
        .foregroundColor: MarvelColor.white,
        .font: UIFont(name: "Marvel-Regular", size: 100) ?? UIFont.monospacedSystemFont(ofSize: 100, weight: .black)
    ]

    appearance.largeTitleTextAttributes = attrs

    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}

struct Nav_Previews: PreviewProvider {
    static var previews: some View {
        Nav()
    }
}
