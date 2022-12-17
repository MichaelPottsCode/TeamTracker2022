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
    @StateObject private var playerFormVM = PlayerFormViewModel()
    @StateObject private var imagePicker = ImagePicker()
    let fileManager = FileManager()
    
    var body: some View {
        NavigationStack {
            
            VStack {
                if let playerImage = imagePicker.image {
                    playerImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding(.bottom)
                    // need to add an overlay with a button to choose a new image
                } else {
                    PhotosPicker(selection: $imagePicker.imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared(),
                                 label: {
                        Text("Choose a Player Image")
                    })
                    .buttonStyle(.bordered)
                    .padding(.bottom)
                    .onChange(of: imagePicker.imageSelection) { newImage in
                        print("NEW IMAGE READY TO SAVE")
                        playerFormVM.imageID = UUID().uuidString
                        print(playerFormVM.imageID ?? "No ID")
                        print(imagePicker.uiImage == nil)
                        if let imageID = playerFormVM.imageID {
                            print(imageID)
                            if let uiImage = imagePicker.uiImage {
                                print("CALLING SAVE FUNCTION")
                                fileManager.saveImage(with: imageID, image: uiImage)
                            }
                        }
                    }
                }
                
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
