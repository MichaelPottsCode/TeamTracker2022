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
            ScrollView {
                VStack {
                    
                    imagePickerView
                    
                    dataFields
                    
                    Spacer()
                    
                }
            }
            .navigationTitle(playerFormVM.updating ? "Update Player" : "Add Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                        .disabled(playerFormVM.incomplete)
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
            PlayerImageView(size: 175, color: .black, image: playerFormVM.playerImage)
            
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
            CustomTextField(textInput: $playerFormVM.newFirstName, label: "First Name", commitFunction: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newFirstName)
            CustomTextField(textInput: $playerFormVM.newLastName, label: "Last Name", commitFunction: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newLastName)
            // add date of bitrth here
            CustomNumberField(textInput: $playerFormVM.newPlayerHeight, label: "Height(cm)", commitFunction: setNextFocus, includesDecimal: false)
                .focused($focus, equals: \PlayerFormViewModel.newPlayerHeight)
            CustomTextField(textInput: $playerFormVM.newPosition, label: "Position", commitFunction: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newPosition)
                .textInputAutocapitalization(.words)
            CustomNumberField(textInput: $playerFormVM.newJerseyNumber, label: "Jersey Number", commitFunction: setNextFocus, includesDecimal: false)
                .focused($focus, equals: \PlayerFormViewModel.newJerseyNumber)
            CustomTextField(textInput: $playerFormVM.newClubName, label: "Club Name", commitFunction: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newClubName)
                .textInputAutocapitalization(.words)
            CustomTextField(textInput: $playerFormVM.newHighSchoolName, label: "High School", commitFunction: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newHighSchoolName)
                .textInputAutocapitalization(.words)
            CustomTextField(textInput: $playerFormVM.newEmail, label: "Email", commitFunction: setNextFocus)
                .focused($focus, equals: \PlayerFormViewModel.newEmail)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            CustomNumberField(textInput: $playerFormVM.newCellPhone, label: "Cell Phone (numbers only, i.e. xxxxxxxxxx)", commitFunction: setNextFocus, includesDecimal: false)
                .focused($focus, equals: \PlayerFormViewModel.newCellPhone)
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
//            HStack {
//                Spacer()
                Image(systemName: "keyboard.chevron.compact.down")
//            }
        }
    }
    
    func setNextFocus() {
        switch focus {
        case \PlayerFormViewModel.newFirstName:
            focus = \PlayerFormViewModel.newLastName
        case \PlayerFormViewModel.newLastName:
            focus = \PlayerFormViewModel.newPlayerHeight
        case \PlayerFormViewModel.newPlayerHeight:
            focus = \PlayerFormViewModel.newPosition
        case \PlayerFormViewModel.newPosition:
            focus = \PlayerFormViewModel.newJerseyNumber
        case \PlayerFormViewModel.newJerseyNumber:
            focus = \PlayerFormViewModel.newClubName
        case \PlayerFormViewModel.newClubName:
            focus = \PlayerFormViewModel.newHighSchoolName
        case \PlayerFormViewModel.newHighSchoolName:
            focus = \PlayerFormViewModel.newEmail
        case \PlayerFormViewModel.newEmail:
            focus = \PlayerFormViewModel.newCellPhone
        case \PlayerFormViewModel.newCellPhone:
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
