//
//  GameEntity + Extensions.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 1/7/23.
//

import Foundation
import SwiftUI

enum GameType {
    case club
    case highSchool
}

extension GameEntity {
    
    // convenience accessors
    var opponent: String {
        opponent_ ?? "No name"
    }
    
    var gameDuration: Int {
        get {
            Int(gameDuration_)
        }
        set {
            gameDuration_ = Int32(newValue)
        }
    }
    
    var ourScore: Int {
        get {
            Int(ourScore_)
        }
        set {
            ourScore_ = Int32(newValue)
        }
    }
    
    var opponentScore: Int {
        get {
            Int(opponentScore_)
        }
        set {
            opponentScore_ = Int32(newValue)
        }
    }
    
    var dateOfGame: Date {
        dateOfGame_ ?? Date()
    }
    
    // computed properties
    var gameResult: some View {
        if ourScore > opponentScore {
            return Text("W \(ourScore)-\(opponentScore)")
                .foregroundColor(.green)
        } else if ourScore < opponentScore {
            return Text("L \(ourScore)-\(opponentScore)")
                .foregroundColor(.red)
        } else {
            return Text("D \(ourScore)-\(opponentScore)")
                .foregroundColor(.secondary)
        }
    }
    
    var dateOfGameAsString: String {
        dateOfGame.formatted(date: .complete, time: .omitted)
    }
}
