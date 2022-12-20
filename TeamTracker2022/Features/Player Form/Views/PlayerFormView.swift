//
//  PlayerFormView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/14/22.
//

import PhotosUI
import SwiftUI
import UIKit

struct PlayerFormView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var playerFormVM: PlayerFormViewModel
    @StateObject private var imagePicker = ImagePicker()
//    @FocusState private var focus
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack {
                    Image(uiImage: playerFormVM.playerImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding(.bottom)
                    PhotosPicker(selection: $imagePicker.imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared(),
                                 label: {
                        Text(playerFormVM.updating ? "Change Player Image" : "Add Player Image")
                    })
                    .buttonStyle(.bordered)
                    .padding(.bottom)
                    .onChange(of: imagePicker.uiImage) { newImage in
                        playerFormVM.imageID = UUID().uuidString
                        playerFormVM.playerImage = imagePicker.uiImage!
                    }
                    
                    CustomTextField(textInput: $playerFormVM.newFirstName, label: "First Name")
                    CustomTextField(textInput: $playerFormVM.newLastName, label: "Last Name")
                    CustomTextField(textInput: $playerFormVM.newPosition, label: "Position")
                                        
                    Spacer()
                }
            }
            .padding(.top)
            .navigationTitle(playerFormVM.updating ? "Update Player" : "New Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button {
                        playerFormVM.updating ? playerFormVM.updatePlayer() : playerFormVM.addPlayer()
                        dismiss()
                    } label: {
                        Text(playerFormVM.updating ? "Update" : "Add")
                    }
                    .disabled(playerFormVM.incomplete)
                }
            }
        }
    }
}

struct PlayerFormView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerFormView(playerFormVM: PlayerFormViewModel())
    }
}
