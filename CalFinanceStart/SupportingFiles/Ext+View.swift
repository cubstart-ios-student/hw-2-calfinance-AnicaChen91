//
//  Ext+View.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// NOT NEEDED IN HW
/// -  Just a custom view modifier to add a bottom shadow to our credit cards!
struct CreditCardBottomShadowViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
            //Trick to apply shadow just to the most outer view
            RoundedRectangle(cornerRadius: 10)
            .fill(.white)
           .shadow(color: Color.gray, radius: 10, x: 0, y: 10)
         )
    }
}

struct IndigoElementViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .foregroundStyle(.white)
            .padding(10)
            .background(.indigo.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func applyCreditCardBottomShadow() -> some View {
        modifier(CreditCardBottomShadowViewModifier())
    }
    
    func applyIndigoBackground() -> some View {
        modifier(IndigoElementViewModifier())
    }
}
