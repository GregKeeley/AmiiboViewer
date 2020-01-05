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
        let sortedAmiibos = allAmiibos.sorted { $0.gameSeries < $1.gameSeries }
        var currentIndex = 0
        var currentGame = sortedAmiibos.first?.gameSeries
        if currentIndex < amiibosByGame.count {
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
    static func getAmiiboYears(amiibos: [AmiiboElement]) -> [String] {
            var uniqueYears = [String]()
            for amiibo in amiibos {
                
                let releaseYear = amiibo.release.na?.components(separatedBy: "-")
                if !uniqueYears.contains(String(releaseYear?[0] ?? "0000")) {
                    uniqueYears.append(releaseYear?[0] ?? "0000")
                }
            }
            return uniqueYears
        }
    static func sortByYear(allAmiibos: [AmiiboElement]) -> [[AmiiboElement]] {
        let allYears = getAmiiboYears(amiibos: allAmiibos).sorted { $0 > $1 }
        print(allYears)
        var amiibosByYear = Array(repeating: [AmiiboElement](), count: allYears.count)
        var currentIndex = 0
        let sortedAmiibos = allAmiibos
            .filter { $0.release.na != nil }
            .sorted { $0.release.na! > $1.release.na! }
        var currentYear = sortedAmiibos.first?.release.na?.components(separatedBy: "-")
        for amiiboElement in allAmiibos {
            if amiiboElement.release.na == nil {
                amiibosByYear[6].append(amiiboElement)
                dump(amiibosByYear[6].count)
            }
        }
        if currentIndex < amiibosByYear.count {
            for amiiboElement in sortedAmiibos {
                
                let amiiboYear = amiiboElement.release.na?.components(separatedBy: "-")
                if amiiboYear?[0] == currentYear?[0] {
                    amiibosByYear[currentIndex].append(amiiboElement)
                } else {
                    currentIndex += 1
                    print(currentIndex)
                    currentYear = amiiboYear
                    amiibosByYear[currentIndex].append(amiiboElement)
                }
            }
        }
        for year in amiibosByYear {
            print(year)
        }
        return amiibosByYear
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


