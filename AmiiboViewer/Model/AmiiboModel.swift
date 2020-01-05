//
//  AmiiboModel.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/3/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation

struct AmiiboInfo: Codable {
    let amiibo: [AmiiboElement]
    
    static func getGameSeries(amiibos: [AmiiboElement]) -> [String] {
        var uniqueGames = [String]()
        for amiibo in amiibos {
            if !uniqueGames.contains(amiibo.gameSeries) {
                uniqueGames.append(amiibo.gameSeries)
            }
        }
        return uniqueGames
    }
    static func sortByGame(allAmiibos: [AmiiboElement]) -> [[AmiiboElement]] {
        let allGames = getGameSeries(amiibos: allAmiibos)
        var amiibosByGame = Array(repeating: [AmiiboElement](), count: allGames.count)
        print(allAmiibos.count)
        let sortedAmiibos = allAmiibos.sorted { $0.gameSeries < $1.gameSeries }
        print(amiibosByGame.count)
        print(amiibosByGame)
        var currentIndex = 0
        var currentGame = sortedAmiibos.first?.gameSeries
        print(currentGame)
        if currentIndex <= amiibosByGame.count {
            for amiiboElement in sortedAmiibos {
                if amiiboElement.gameSeries == currentGame {
                    amiibosByGame[currentIndex].append(amiiboElement)
                } else {
                    currentIndex += 1
                    print(currentIndex)
                    currentGame = amiiboElement.gameSeries
                    amiibosByGame[currentIndex].append(amiiboElement)
                }
            }
        }
        return amiibosByGame
    }
}
struct AmiiboElement: Codable {
    let amiiboSeries, character, gameSeries, head: String
    let image: String
    let name: String
    let release: Release
    let tail: String
    let type: String
}
struct Release: Codable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}


