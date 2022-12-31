//
//  CustomNumberField.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/28/22.
//

import SwiftUI

struct CustomNumberField: View {
    @Binding var textInput: String
    let label: String
    let commitFunction: () -> Void
    let includesDecimal: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            
            Text(label.uppercased())
                .fontWeight(.semibold)
                .font(.caption2)
                .foregroundColor(.secondary)
            TextField("", text: $textInput, onCommit: commitFunction)
                .textFieldStyle(.roundedBorder)
                .numbersOnly($textInput, includeDecimal: includesDecimal)
        }
    }
}

struct CustomNumberField_Previews: PreviewProvider {
    static func test() {
        
    }
    
    static var previews: some View {
        CustomNumberField(textInput: .constant("12"), label: "Jersey Number", commitFunction: test, includesDecimal: false)
    }
}
