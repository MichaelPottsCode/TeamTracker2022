//
//  TeamTracker2022App.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/13/22.
//

import SwiftUI

@main
struct TeamTracker2022App: App {
    let dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            PlayerListView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
        }
    }
}
