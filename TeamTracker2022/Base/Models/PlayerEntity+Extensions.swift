//
//  PlayerEntity+Extensions.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/13/22.
//

import Foundation
import UIKit

extension PlayerEntity {
    
    // accessors
    var firstName: String {
        firstName_ ?? "First"
    }
    
    var lastName: String {
        lastName_ ?? "Last"
    }
    
    var position: String {
        position_ ?? "No position"
    }
    
    var playerHeight: String {
        playerHeight_ ?? ""
    }
    
    var imageID: String {
        imageID_ ?? ""
    }
    
    var jerseyNumber: String {
        jerseyNumber_ ?? ""
    }
    
    var clubName: String {
        clubName_ ?? ""
    }
    
    var highSchoolName: String {
        highSchoolName_ ?? ""
    }
    
    var email: String {
        email_ ?? "No email"
    }
    
    var cellPhone: String {
        cellPhone_ ?? "No cell"
    }
    
    var dateOfBirth: Date {
        dateOfBirth_ ?? Date()
    }
    
    // computed properties
    var fullName: String {
        firstName + " " + lastName
    }
    
    var uiImage: UIImage {
        if !imageID.isEmpty,
           let image = FileManager().retrieveImage(with: imageID) {
            return image
        } else {
            return UIImage(named: "placeholder")!
        }
    }
    
    var dateOfBirthAsString: String {
        dateOfBirth.formatted(date: .abbreviated, time: .omitted)
    }
    
//    var cellPhone: String {
//        if var cellPhone = cellPhone_ {
//            cellPhone.insert("-", at: String.Index(utf16Offset: 6, in: cellPhone))
//            cellPhone.insert("-", at: String.Index.init(utf16Offset: 3, in: cellPhone))
//            return cellPhone
//        } else {
//            return "No cell"
//        }
//    }
    
}
