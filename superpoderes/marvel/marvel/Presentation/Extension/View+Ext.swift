//
//  View+Ext.swift
//  marvel
//
//  Created by Victoria Aloy on 21/10/22.
//

import SwiftUI

extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}

extension UICollectionReusableView {
    override open var backgroundColor: UIColor? {
        get { .clear }
        set { }
    }
}



