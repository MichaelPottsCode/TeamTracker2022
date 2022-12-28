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
    
}
