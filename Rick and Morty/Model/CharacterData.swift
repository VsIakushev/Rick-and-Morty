//
//  CharacterData.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 02.01.2024.
//

import Foundation

struct CharacterData: Codable {
    let characterName: String
    let characterSpecies: String
    let characterImage: String
    
    let gender: String
    let status: String
    let origin: String
}
