//
//  AmiiboModel.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/3/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

struct AmiiboInfo: Codable {
    let amiibo: [AmiiboElement]
    //MARK: GetRidOfCards
    static func getRidOfCards(allAmiibos: [AmiiboElement]) -> [AmiiboElement] {
        var allAmiibosNoCards = [AmiiboElement]()
        for amiibo in allAmiibos {
            if amiibo.type != "Card" {
                allAmiibosNoCards.append(amiibo)
            }
        }
        return allAmiibosNoCards
    }
    //MARK: SortByGame
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
                    currentGame = amiiboElement.gameSeries
                    amiibosByGame[currentIndex].append(amiiboElement)
                }
            }
        }
        let filteredAmiibosByGame = amiibosByGame.filter { !$0.isEmpty }
        return filteredAmiibosByGame
    }
    // MARK: SortByYear
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
        var amiibosByYear = Array(repeating: [AmiiboElement](), count: allYears.count)
        var currentIndex = 0
        let sortedAmiibos = allAmiibos
            .filter { $0.release.na != nil }
            .sorted { $0.release.na! > $1.release.na! }
        var currentYear = sortedAmiibos.first?.release.na?.components(separatedBy: "-")
        for amiiboElement in allAmiibos {
            if amiiboElement.release.na == nil {
                amiibosByYear[(amiibosByYear.count - 1)].append(amiiboElement)
            }
        }
        if currentIndex < amiibosByYear.count {
            for amiiboElement in sortedAmiibos {
                let amiiboYear = amiiboElement.release.na?.components(separatedBy: "-")
                if amiiboYear?[0] == currentYear?[0] {
                    amiibosByYear[currentIndex].append(amiiboElement)
                } else {
                    currentIndex += 1
                    currentYear = amiiboYear
                    amiibosByYear[currentIndex].append(amiiboElement)
                }
            }
        }
        return amiibosByYear
    }
    //MARK: SortByAlpha
    static func getAlphaSections(amiibos: [AmiiboElement]) -> [String] {
        var uniqueSections = [String]()
        for amiibo in amiibos {
            let firstChar = amiibo.name.components(separatedBy: "")
            if !uniqueSections.contains(String(firstChar[0])) {
                uniqueSections.append(firstChar[0])
            }
        }
        return uniqueSections
    }
    static func sortByAlpha(allAmiibos: [AmiiboElement]) -> [[AmiiboElement]] {
        let allAlphaSections = getAlphaSections(amiibos: allAmiibos).sorted { $0 < $1 }
        var amiibosByAlpha = Array(repeating: [AmiiboElement](), count: allAlphaSections.count)
        let sortedAmiibos = allAmiibos.sorted { $0.name < $1.name }
        var currentIndex = 0
        var currentSection = sortedAmiibos.first?.name.components(separatedBy: "")
        for amiiboElement in sortedAmiibos {
            let amiiboSection = amiiboElement.name.components(separatedBy: "")
            if amiiboSection[0] == currentSection?[0] {
                amiibosByAlpha[currentIndex].append(amiiboElement)
            } else {
                currentIndex += 1
                currentSection = amiiboSection
                amiibosByAlpha[currentIndex].append(amiiboElement)
            }
        }
        return amiibosByAlpha
    }
    //MARK: sortByAmiiboSeries
    static func getAmiiboSeries(amiibos: [AmiiboElement]) -> [String] {
        var uniqueSeries = [String]()
        for amiibo in amiibos {
            if !uniqueSeries.contains(amiibo.amiiboSeries) {
                uniqueSeries.append(amiibo.amiiboSeries)
            }
        }
        return uniqueSeries
    }
    static func sortByAmiiboSeries(allAmiibos: [AmiiboElement]) -> [[AmiiboElement]] {
        let allAmiiboSeries = getAmiiboSeries(amiibos: allAmiibos).sorted { $0 > $1 }
        var amiibosBySeries = Array(repeating: [AmiiboElement](), count: allAmiiboSeries.count)
        var currentIndex = 0
        let sortedAmiibos = allAmiibos
            .sorted { $0.amiiboSeries > $1.amiiboSeries }
        var currentSeries = sortedAmiibos.first?.amiiboSeries
            for amiiboElement in sortedAmiibos {
                let amiiboSeries = amiiboElement.amiiboSeries
                if amiiboSeries == currentSeries {
                    amiibosBySeries[currentIndex].append(amiiboElement)
                } else {
                    currentIndex += 1
                    currentSeries = amiiboSeries
                    amiibosBySeries[currentIndex].append(amiiboElement)
                }
            }
        return amiibosBySeries
    }
    
    //MARK: FilterAmiibos
    static func filterAmiibos(for method: Int, allAmiibos: [AmiiboElement], viewController: UIViewController) -> [[AmiiboElement]] {
        if allAmiibos.isEmpty {
            viewController.showAlert(title: "No Results", message: "")
        }
        let noCardsAmiibos = getRidOfCards(allAmiibos: allAmiibos)
        var filteredAmiibos = [[AmiiboElement]]()
        switch method {
        case 0:
            filteredAmiibos = AmiiboInfo.sortByGame(allAmiibos: noCardsAmiibos)
        case 1:
            filteredAmiibos = AmiiboInfo.sortByYear(allAmiibos: noCardsAmiibos)
        case 2:
            filteredAmiibos = AmiiboInfo.sortByAmiiboSeries(allAmiibos: noCardsAmiibos)
        case 3:
            filteredAmiibos = AmiiboInfo.sortByAlpha(allAmiibos: noCardsAmiibos)
        default:
            break
        }
        
        return filteredAmiibos
    }
    static func searchAmiibos(method: Int,searchQuery: String, allAmiibos: [[AmiiboElement]], viewController: UIViewController)-> [[AmiiboElement]] {
        var searchResults = [AmiiboElement]()
        var filteredResults = [[AmiiboElement]]()
        if !searchQuery.isEmpty {
            for section in allAmiibos {
                for amiibo in section {
                    if amiibo.name.lowercased().contains(searchQuery) {
                        searchResults.append(amiibo)
                    }
                }
                filteredResults = AmiiboInfo.filterAmiibos(for: method, allAmiibos: searchResults, viewController: viewController)
            }
        } else {
            filteredResults = allAmiibos
        }
        return filteredResults
    }
}
// MARK: AmiiboElement / Release
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


