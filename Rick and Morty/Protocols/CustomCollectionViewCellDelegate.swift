//
//  CustomCollectionViewCellDelegate.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 03.01.2024.
//

import Foundation

protocol CustomCollectionViewCellDelegate: AnyObject {
    func didTapImageView(with episode: EpisodeData)
}
