//
//  FavouritesViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 31.12.2023.
//

import UIKit


class FavouritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    
    var favouriteEpisodesData: [EpisodeData] = []
    var favouriteEpisodes: Set<String> = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        favouriteEpisodesData = loadFavorites()
        favouriteEpisodes = loadFavoritesSet()
        print(favouriteEpisodes)
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: 330, height: 330)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 50
            
            // Инициализируем UICollectionView с использованием UICollectionViewFlowLayout
            self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            
            // Добавляем UICollectionView на главный экран
            self.view.addSubview(self.collectionView)
            
            // Обновляем данные в коллекции
            self.collectionView.reloadData()
            
        }
        
        
    }
    
    // все функции потом перенести в Controller
    
    func loadFavorites() -> [EpisodeData] {
        guard let favoritesData = UserDefaults.standard.dictionary(forKey: "favorites") as? [String: Data] else {
            return []
        }
        
        var favorites: [EpisodeData] = []
        
        for (key, data) in favoritesData {
            if let episodeData = try? JSONDecoder().decode(EpisodeData.self, from: data) {
                favorites.append(episodeData)
                print(episodeData)
            }
        }
        print(favorites)
        return favorites.isEmpty ? [] : favorites
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteEpisodesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        // Заполняем ячейку данными из episodesData
        let episode = favouriteEpisodesData[indexPath.item]
        cell.configure(with: episode)
        
        // проверяем есть ли уже в избранном
        if favouriteEpisodes.contains(episode.episodeNumber) {
            cell.isFavorite = true
        }
        
        return cell
    }
    
    func loadFavoritesSet() -> Set<String> {
        guard let favoritesData = UserDefaults.standard.dictionary(forKey: "favorites") as? [String: Data] else {
            return []
        }
        
        var favorites: Set<String> = Set<String>()
        
        for (key, data) in favoritesData {
            if let episodeData = try? JSONDecoder().decode(EpisodeData.self, from: data) {
                favorites.insert(key)
                print(key)
            }
        }
        print(favorites)
        return favorites.isEmpty ? [] : favorites
    }
    
}
