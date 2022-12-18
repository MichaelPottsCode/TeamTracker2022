//
//  ModalTypes.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/14/22.
//

import Foundation
import SwiftUI

enum PlayerModalType: Identifiable {
    
    case new
    case update
    
    var id: String {
        switch self {
        case .new:
            return "New"
        case .update:
            return "Update"
        }
    }
}
