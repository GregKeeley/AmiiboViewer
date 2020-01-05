//
//  AmiiboTableViewCell.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/3/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class AmiiboTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amiiboNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var amiiboImageView: UIImageView!
    
    func configureCell(amiibo: AmiiboElement) {
        amiiboNameLabel.text = amiibo.name
        releaseDateLabel.text = amiibo.release.na
        amiiboImageView.getImage(with: amiibo.image) { [weak self] (results) in
            switch results {
            case .failure(let appError):
                print("Failed to load image: \(appError)")
                DispatchQueue.main.async {
                    self?.amiiboImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.amiiboImageView.image = image
                }
            }
        }
    }
    
    
    static func getNumberOfYears(amiibos: [AmiiboElement]) -> Int {
        var uniqueYears = [String]()
        for amiibo in amiibos {
            
            let releaseYear = amiibo.release.na?.components(separatedBy: "-")
            if !uniqueYears.contains(String(releaseYear?[0] ?? "0000")) {
                uniqueYears.append(releaseYear?[0] ?? "0000")
                
            }
        }
        return uniqueYears.count
    }
    
    static func getGameSeries(amiibos: [AmiiboElement]) -> [String] {
        var uniqueGames = [String]()
        for amiibo in amiibos {
            if !uniqueGames.contains(amiibo.gameSeries) {
                uniqueGames.append(amiibo.gameSeries)
            }
        }
        return uniqueGames
    }
    
    
    static func getSectionsByGame(amiibos: [AmiiboElement]) -> [[AmiiboElement]] {
        var sortedAmiibos = [[AmiiboElement]]()
        let uniqueGames = getGameSeries(amiibos: amiibos)
       
        var currentIndex = 0
        let currentGame = "\(amiibos[currentIndex].gameSeries)"

            for game in uniqueGames {
                for amiibo in amiibos {
                    if amiibo.gameSeries == game {
                        sortedAmiibos[currentIndex].append(amiibo)
                    } else {
                        currentIndex += 1
                    }
                }
            
        }
        dump(sortedAmiibos)
        return sortedAmiibos
    }
    
    //    static func getSectionsByAlpha(amiibos: [AmiiboElement]) -> [[AmiiboElement]] {
    //        var alphaSections = [[AmiiboElement]]()
    //        //var uniqueSections =
    //        for amiibo in amiibos {
    //            let charName = [amiibo.name.components(separatedBy: "")]
    //        }
    //        return alphaSections
    //    }
    
    
    static func getSectionsByYear(amiibos: [AmiiboElement]) -> [[AmiiboElement]] {
        var uniqueYears = [String]()
        print(amiibos.count)
        for amiibo in amiibos {
            let releaseYear = amiibo.release.na?.components(separatedBy: "-")
            if !uniqueYears.contains(String(releaseYear?[0] ?? "0000")) {
                uniqueYears.append(releaseYear?[0] ?? "0000")
            }
        }
        
        uniqueYears = uniqueYears.sorted()
        
        var amiibosByYear = Array(repeating: [AmiiboElement](), count: uniqueYears.count)

    
        
        for amiibo in amiibos {
            let amiiboReleaseYear = amiibo.release.na?.components(separatedBy: "-")
            print(amiiboReleaseYear?[0])
            switch amiiboReleaseYear?[0] {
            case "2014":
                amiibosByYear[1].append(amiibo)
            case "2015":
                amiibosByYear[2].append(amiibo)
            case "2016":
                amiibosByYear[3].append(amiibo)
            case "2017":
                amiibosByYear[4].append(amiibo)
            case "2018":
                amiibosByYear[5].append(amiibo)
            case "2019":
                amiibosByYear[6].append(amiibo)
            case "2020":
                amiibosByYear[7].append(amiibo)
            default:
                amiibosByYear[0].append(amiibo)
            }
        }
        return amiibosByYear
    }
    
}

