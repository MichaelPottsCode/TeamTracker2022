//
//  FormTypes.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/14/22.
//

import SwiftUI

enum PlayerFormType: Identifiable, View {
    
    case new
    case update(PlayerEntity)
    
    var id: String {
        switch self {
        case .new:
            return "New"
        case .update:
            return "Update"
        }
    }
    
    var body: some View {
        switch self {
        case .new:
            return PlayerFormView(playerFormVM: PlayerFormViewModel())
        case .update(let player):
            return PlayerFormView(playerFormVM: PlayerFormViewModel(player))
        }
    }
}
