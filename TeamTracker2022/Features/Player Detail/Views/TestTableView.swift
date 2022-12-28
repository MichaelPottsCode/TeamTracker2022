//
//  TestTableView.swift
//  TeamTracker2022
//
//  Created by Michael Potts on 12/23/22.
//

import SwiftUI

struct Game: Identifiable {
    let id = UUID()
    let opponent: String
    let dateOfGame: Date
    let gameResult: String
    
    var gameDate: String {
        return self.dateOfGame.formatted(date: .numeric, time: .omitted)
    }
}

struct TableRowView: View {
    var game: Game
    var body: some View {
        HStack {
            Text(game.gameDate)
            Text(game.opponent)
            Spacer()
            Text(game.gameResult)
        }
    }
}

struct TestTableView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let games = [
        Game(opponent: "Arlington Blue 2007", dateOfGame: Date(), gameResult: "W 3-1"),
        Game(opponent: "LMVSC White 07", dateOfGame: Date(), gameResult: "L 0-1"),
        Game(opponent: "SYC White 07B", dateOfGame: Date(), gameResult: "D 1-1"),
        Game(opponent: "SYC Blue 07B", dateOfGame: Date(), gameResult: "W 4-1"),
        Game(opponent: "SYC Orange 07B", dateOfGame: Date(), gameResult: "L 1-2"),
        Game(opponent: "SYC Green 07B", dateOfGame: Date(), gameResult: "W 1-0")
    ]
    
    var body: some View {
        VStack {
            Text("Recent Games".uppercased())
                .font(.headline)
            Table(games) {
                TableColumn("Date") { game in
                    if horizontalSizeClass == .compact {
                        TableRowView(game: game)
                    } else {
                        Text(game.gameDate)
                    }
                }
                TableColumn("Opponent", value: \.opponent)
                TableColumn("Result", value: \.gameResult)
            }
            .font(.subheadline)
            .frame(height: 135)
        }
    }
}

struct TestTableView_Previews: PreviewProvider {
    static var previews: some View {
        TestTableView()
    }
}
