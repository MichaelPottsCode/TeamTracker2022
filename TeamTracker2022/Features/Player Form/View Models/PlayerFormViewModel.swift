//
//  PlayerFormViewModel.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/14/22.
//

import CoreData
import Foundation
import UIKit

final class PlayerFormViewModel: ObservableObject {
    
    let viewContext = DataManager.shared.container.viewContext
    
    @Published var newFirstName: String = ""
    @Published var newLastName: String = ""
    @Published var newPosition: String = ""
    @Published var newPlayerHeight: String = ""
    @Published var newJerseyNumber: String = ""
    @Published var newEmail: String = ""
    @Published var newCellPhone: String = ""
    @Published var newClubName: String = ""
    @Published var newHighSchoolName: String = ""
    @Published var newDateOfBirth: Date = Date()
    @Published var imageID: String?
    @Published var playerImage: UIImage = UIImage(named: "placeholder")!
    
    @Published var id: NSManagedObjectID?
    
    var updating: Bool { id != nil }
    
    init() {
        
    }
    
    init(_ player: PlayerEntity) {
        newFirstName = player.firstName
        newLastName = player.lastName
        newPosition = player.position
        newPlayerHeight = player.playerHeight
        newJerseyNumber = player.jerseyNumber
        newEmail = player.email
        newCellPhone = player.cellPhone
        newClubName = player.clubName
        newHighSchoolName = player.highSchoolName
        newDateOfBirth = player.dateOfBirth
        imageID = player.imageID
        playerImage = player.uiImage
        id = player.objectID
    }
    
    // Require a new player to have a first name, last name, and an image before being saved
    var incomplete: Bool {
        newFirstName.isEmpty || newLastName.isEmpty || imageID == nil
    }
    
    func addPlayer() {
        
        let newPlayer = PlayerEntity(context: viewContext)
        newPlayer.firstName_ = newFirstName
        newPlayer.lastName_ = newLastName
        newPlayer.position_ = newPosition
        newPlayer.playerHeight_ = newPlayerHeight
        newPlayer.jerseyNumber_ = newJerseyNumber
        newPlayer.email_ = newEmail
        newPlayer.cellPhone_ = newCellPhone
        newPlayer.clubName_ = newClubName
        newPlayer.highSchoolName_ = newHighSchoolName
        newPlayer.dateOfBirth_ = newDateOfBirth
        newPlayer.imageID_ = imageID
        
        FileManager().saveImage(with: imageID!, image: playerImage)
        
        do {
            try viewContext.save()
        } catch {
            print("ERROR SAVING DATA \(error.localizedDescription)")
        }
    }
    
    func updatePlayer() {
        // find contact with the object ID from the player being edited
        if let playerToUpdate = viewContext.object(with: self.id!) as? PlayerEntity {
                        
            // Delete the current image
            FileManager().deleteImage(with: playerToUpdate.imageID)
            
            viewContext.delete(playerToUpdate)
            
            addPlayer()
            
            // Update all properties based on what was entered (newXXX)
//            playerToUpdate.firstName_ = newFirstName
//            playerToUpdate.lastName_ = newLastName
//            playerToUpdate.position_ = newPosition
//            playerToUpdate.playerHeight_ = newPlayerHeight
//            playerToUpdate.jerseyNumber_ = newJerseyNumber
//            playerToUpdate.email_ = newEmail
//            playerToUpdate.cellPhone_ = newCellPhone
//            playerToUpdate.clubName_ = newClubName
//            playerToUpdate.highSchoolName_ = newHighSchoolName
//            playerToUpdate.dateOfBirth_ = newDateOfBirth
//            playerToUpdate.imageID_ = imageID
//
//            FileManager().saveImage(with: imageID!, image: playerImage)
//
//            do {
//                try viewContext.save()
//            } catch {
//                print("ERROR SAVING DATA \(error.localizedDescription)")
//            }
        }
    }
}
