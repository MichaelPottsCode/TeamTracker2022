//
//  PlayerFormView-2.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/27/22.
//

import PhotosUI
import SwiftUI

struct PlayerFormView2: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var playerFormVM: PlayerFormViewModel
    @StateObject private var imagePicker = ImagePicker()
    @FocusState private var focus: AnyKeyPath?
    
    var body: some View {
        NavigationStack {
            VStack {
                
                imagePickerView
                
                dataFields
                
                Spacer()
                
            }
            .navigationTitle(playerFormVM.updating ? "Update Player" : "Add Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
                ToolbarItem(placement: .keyboard) {
                    keyboardDismissButton
                }
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
            .task {
                if !playerFormVM.updating {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    focus = \PlayerFormViewModel.newFirstName
                }
            }
        }
    }
    
    var imagePickerView: some View {
        PhotosPicker(selection: $imagePicker.imageSelection,
                     matching: .images,
                     photoLibrary: .shared(),
                     label: {
            Image(uiImage: playerFormVM.playerImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            
        })
        .padding(.vertical)
        .onChange(of: imagePicker.uiImage) { newImage in
            playerFormVM.imageID = UUID().uuidString
            playerFormVM.playerImage = imagePicker.uiImage!
        }
    }
    
    var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
        }
    }
    
    var dataFields: some View {
        VStack {
            TextField("First Name", text: $playerFormVM.newFirstName, onCommit: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newFirstName)
            TextField("Last Name", text: $playerFormVM.newLastName, onCommit: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newLastName)
            TextField("Position", text: $playerFormVM.newPosition, onCommit: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newPosition)
                .textInputAutocapitalization(.words)
            TextField("Height(cm)", text: $playerFormVM.newPlayerHeight, onCommit: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newPlayerHeight)
                .numbersOnly($playerFormVM.newPlayerHeight, includeDecimal: false)
        }
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal)
    }
    
    var addButton: some View {
        Button {
            playerFormVM.updating ? playerFormVM.updatePlayer() : playerFormVM.addPlayer()
            dismiss()
        } label: {
            Text(playerFormVM.updating ? "Update" : "Add")
        }
    }
    
    var keyboardDismissButton: some View {
        Button {
            focus = nil
        } label: {
            HStack {
                Spacer()
                Image(systemName: "keyboard.chevron.compact.down")
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
            focus = \PlayerFormViewModel.newPlayerHeight
        case \PlayerFormViewModel.newPlayerHeight:
            focus = \PlayerFormViewModel.newFirstName
        default:
            break
        }
    }
}

struct PlayerFormView_2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlayerFormView2(playerFormVM: PlayerFormViewModel())
        }
    }
}
