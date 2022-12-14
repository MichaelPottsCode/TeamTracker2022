//
//  PlayerEntity+Extensions.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/13/22.
//

import Foundation

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
    
    // computed properties
    var fullName: String {
        firstName + " " + lastName
    }
    
}
