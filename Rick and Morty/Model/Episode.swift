//
//  Episode.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 02.01.2024.
//

import Foundation

struct EpisodeResponse: Decodable {
    let results: [EpisodeResult]
}

struct EpisodeResult: Decodable {
    let name: String
    let episode: String
    let characters: [String]
}

struct CharacterResponse: Decodable {
    let name: String
    let species: String
    let image: String
}
