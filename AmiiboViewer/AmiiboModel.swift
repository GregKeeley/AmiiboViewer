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
