//
//  PlayerFormView2.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/19/22.
//

import PhotosUI
import SwiftUI
import UIKit

struct PlayerFormView2: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var playerFormVM: PlayerFormViewModel
    @StateObject private var imagePicker = ImagePicker()
    @FocusState private var focus: AnyKeyPath?
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                
                TextField("First Name", text: $playerFormVM.newFirstName, onCommit: setNextFocus)
                    .focused($focus, equals: \PlayerFormViewModel.newFirstName)
                    .withCustomTextField()
                TextField("Last Name", text: $playerFormVM.newLastName, onCommit: setNextFocus)
                    .focused($focus, equals: \PlayerFormViewModel.newLastName)
                    .withCustomTextField()
                TextField("Position", text: $playerFormVM.newPosition, onCommit: setNextFocus)
                    .textInputAutocapitalization(.words)
                    .focused($focus, equals: \PlayerFormViewModel.newPosition)
                    .withCustomTextField()
                
            }
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
                ToolbarItem(placement: .keyboard) {
                    Button {
                        focus = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
        .task {
            if !playerFormVM.updating {
                try? await Task.sleep(nanoseconds: 500_000_000)
                focus = \PlayerFormViewModel.newFirstName
            }
        }
    }
    
    func setNextFocus() {
        switch focus {
        case \PlayerFormViewModel.newFirstName:
            focus = \PlayerFormViewModel.newLastName
        case \PlayerFormViewModel.newLastName:
            focus = \PlayerFormViewModel.newPosition
        case \PlayerFormViewModel.newPosition:
            focus = \PlayerFormViewModel.newFirstName
        default:
            break
        }
    }
}

struct PlayerFormView2_Previews: PreviewProvider {
    static var previews: some View {
        PlayerFormView2(playerFormVM: PlayerFormViewModel())
    }
}
