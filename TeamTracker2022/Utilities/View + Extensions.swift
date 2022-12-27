//
//  View + Extensions.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/21/22.
//

import Combine
import Foundation
import SwiftUI

// MARK: - Custom View Modifier for capturing numerical values as Strings
// Reference: Stewart Lynch YouTube video
struct NumbersOnlyViewModifier: ViewModifier {
    @Binding var text: String
    var includeDecimal: Bool
    
    func body(content: Content) -> some View {
        content
            .keyboardType(includeDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in // this code runs every time a key is pressed in the textfield
                var numbers = "0123456789"
                let decimalSeperator: String = Locale.current.decimalSeparator ?? "."
                if includeDecimal {
                    numbers += decimalSeperator
                }
                // check to see if text input character is a second separator
                if newValue.components(separatedBy: decimalSeperator).count - 1 > 1 {
                    // if it is, then drop the character and set the text to the value without the 2nd separator
                    let filtered = newValue
                    self.text = String(filtered.dropLast())
                } else {
                    // if the character is not a 2nd separator, then filter out all non-numeric values,
                    // and set the textfield value to the filtered string
                    let filtered = newValue.filter { numbers.contains($0) }
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
            }
    }
    
}

extension View {
    
    func numbersOnly(_ text: Binding<String>, includeDecimal: Bool = false) -> some View {
        self.modifier(NumbersOnlyViewModifier(text: text, includeDecimal: includeDecimal))
    }
    
}


// MARK: - Custom View Modifier for TextFields
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
