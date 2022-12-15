//
//  PlayerListViewModel.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/13/22.
//

import CoreData
import Foundation

final class PlayerListViewModel: ObservableObject {
    
    @Published var players: [PlayerEntity] = []
    
    init() {
        
        loadPlayers()
    }
    
    func loadPlayers() {
        
        let fetchRequest = NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
        
        do {
            players = try DataManager.shared.container.viewContext.fetch(fetchRequest)
        } catch {
            print("ERROR FETCHING TEAM DATA \(error.localizedDescription)")
        }
    }
    
    func addPlayer() {
        let newPlayer = PlayerEntity(context: DataManager.shared.container.viewContext)
        newPlayer.firstName_ = "Mike"
        newPlayer.lastName_ = "Potts"
        newPlayer.position_ = "Goalie"
        saveTeam()
        loadPlayers()
    }
    
    func saveTeam() {
        do {
            try DataManager.shared.container.viewContext.save()
        } catch {
            print("ERROR SAVING DATA \(error.localizedDescription)")
        }
    }
    
    func deletePlayer(offsets: IndexSet) {
        offsets.map { players[$0] }.forEach(DataManager.shared.container.viewContext.delete)
        saveTeam()
        loadPlayers()
    }
}
