//
//  FavouritesViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 31.12.2023.
//

import UIKit


class FavouritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    
    var episodesData: [EpisodeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        episodesData = loadFavorites()
        
  
        
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
            
            print(self.episodesData[0].episodeName)
            print(self.episodesData[0].episodeNumber)
            print(self.episodesData[0].characterName)
            print(self.episodesData[0].characterSpecies)
            print(self.episodesData[0].characterImage)
        }
        
        
    }
    
    // все функции потом перенести в Controller
    
    func loadFavorites() -> [EpisodeData] {
        guard let favoritesData = UserDefaults.standard.dictionary(forKey: "favorites") as? [String: Data] else {
            return []
        }

        var favorites: [EpisodeData] = []

        for (_, data) in favoritesData {
            if let episodeData = try? JSONDecoder().decode(EpisodeData.self, from: data) {
                favorites.append(episodeData)
                print(episodeData)
            }
        }
        print(favorites)
        return favorites.isEmpty ? [] : favorites
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        // Заполняем ячейку данными из episodesData
        let episode = episodesData[indexPath.item]
        cell.configure(with: episode)
        
        return cell
    }
    
    
    
}
