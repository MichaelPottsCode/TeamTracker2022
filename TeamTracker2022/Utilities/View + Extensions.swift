//
//  View + Extensions.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/21/22.
//

import Foundation
import SwiftUI

struct customTextField: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .frame(height: 35)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.gray).opacity(0.5)
            })
            .padding(.horizontal)
    }
    
}

extension View {
    func withCustomTextField() -> some View {
        self
            .modifier(customTextField())
    }
}
