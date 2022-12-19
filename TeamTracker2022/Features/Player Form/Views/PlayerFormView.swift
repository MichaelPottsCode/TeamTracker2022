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
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack {
                    Image(uiImage: playerFormVM.playerImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
//                        .padding(.top, 25)
                        .padding(.bottom)
                    //                if let playerImage = imagePicker.uiImage {
                    ////                    PlayerImageView(size: 225, color: .primary, playerImageID: playerFormVM.imageID)
                    //                    Image(uiImage: playerImage)
                    //                        .resizable()
                    ////                        .scaledToFill()
                    //                        .frame(width: 200, height: 200)
                    //                        .clipShape(Circle())
                    //                        .padding(.bottom)
                    //                    // need to add an overlay with a button to choose a new image
                    //                } else {
                    PhotosPicker(selection: $imagePicker.imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared(),
                                 label: {
                        Text(playerFormVM.updating ? "Change Player Image" : "Add Player Image")
                    })
                    .buttonStyle(.bordered)
                    .padding(.bottom)
                    .onChange(of: imagePicker.uiImage) { newImage in
                        //                        print("NEW IMAGE READY TO SAVE")
                        playerFormVM.imageID = UUID().uuidString
                        //                        print(playerFormVM.imageID ?? "No ID")
                        //                        print(imagePicker.uiImage == nil)
                        playerFormVM.playerImage = imagePicker.uiImage!
                        //                        if let imageID = playerFormVM.imageID {
                        //                            print(imageID)
                        //                            if let uiImage = imagePicker.uiImage {
                        //                                print("CALLING SAVE FUNCTION")
                        //                                fileManager.saveImage(with: imageID, image: uiImage)
                        //                            }
                        //                        }
                    }
                    //                }
                    
                    CustomTextField(textInput: $playerFormVM.newFirstName, label: "First Name")
                    CustomTextField(textInput: $playerFormVM.newLastName, label: "Last Name")
                    CustomTextField(textInput: $playerFormVM.newPosition, label: "Position")
                    
                    //                Button {
                    //                    //
                    //                    if let playerImage = imagePicker.uiImage {
                    //                        playerFormVM.imageID = UUID().uuidString
                    //                        FileManager().saveImage(with: playerFormVM.imageID!, image: playerImage)
                    //                    }
                    //                    playerFormVM.addPlayer()
                    //                    dismiss()
                    //                } label: {
                    //                    Text("Save Player")
                    //                }
                    //                .buttonStyle(.bordered)
                    //                .padding(.top)
                    
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
