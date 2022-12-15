//
//  PlayerFormView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/14/22.
//

import SwiftUI

struct PlayerFormView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var playerFormVM = PlayerFormViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack {
                CustomTextField(textInput: $playerFormVM.newFirstName, label: "First Name")
                CustomTextField(textInput: $playerFormVM.newLastName, label: "Last Name")
                CustomTextField(textInput: $playerFormVM.newPosition, label: "Position")
                
                Button {
                    //
                    playerFormVM.addPlayer()
                    dismiss()
                } label: {
                    Text("Save Player")
                }
                .buttonStyle(.bordered)
                .padding(.top)

                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("New Player")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PlayerFormView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerFormView()
    }
}
