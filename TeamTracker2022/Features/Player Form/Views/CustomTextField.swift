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
    let commitFunction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            
            Text(label.uppercased())
                .fontWeight(.semibold)
                .font(.caption2)
                .foregroundColor(.secondary)
//                .padding(.leading)
            TextField("", text: $textInput, onCommit: commitFunction)
                .textFieldStyle(.roundedBorder)
        }
//        .padding(.horizontal)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static func test() {
        
    }
    
    static var previews: some View {
        CustomTextField(textInput: .constant("First"), label: "First name", commitFunction: test)
    }
}
