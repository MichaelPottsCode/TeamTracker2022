//
//  CustomTextField.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/14/22.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var textInput: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            
            Text(label.uppercased())
                .fontWeight(.semibold)
                .font(.caption)
                .foregroundColor(.secondary)
            TextField("", text: $textInput)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.horizontal)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(textInput: .constant("First"), label: "First name")
    }
}
