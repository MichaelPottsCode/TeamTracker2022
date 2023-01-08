//
//  GameListViewModel.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 1/8/23.
//

import Foundation

class GameListViewModel: ObservableObject {
    
    @Published var games: [GameEntity]
    @Published var playerName: String
    
    init(for player: PlayerEntity) {
        
        self.games = []
        self.playerName = player.firstName
//        self.games = player.games
        
    }
}
