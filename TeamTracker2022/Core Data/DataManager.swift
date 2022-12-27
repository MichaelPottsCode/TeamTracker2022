//
//  DataManager.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/13/22.
//

import CoreData
import Foundation

final class DataManager {
    
    static let shared = DataManager(inMemory: true)
    
    static var preview: DataManager = {
        let result = DataManager(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0..<4 {
            let newPlayer = PlayerEntity(context: viewContext)
            newPlayer.firstName_ = "Mike \(index)"
            newPlayer.lastName_ = "Potts"
            newPlayer.position_ = "CDM"
            newPlayer.playerHeight_ = "172"
        }
        do {
            try viewContext.save()
            print("Savings preview data")
        } catch {
            print("ERROR CREATING PREVIEW DATA \(error.localizedDescription)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TeamModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error {
                print("ERROR LOADING PERSISTENCE STORES \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
}
