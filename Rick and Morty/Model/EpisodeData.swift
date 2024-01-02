//
//  EpisodeData.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 02.01.2024.
//

import Foundation

struct EpisodeData: Codable {
    let episodeName: String
    let episodeNumber: String
    let characterName: String
    let characterSpecies: String
    let characterImage: String
}
