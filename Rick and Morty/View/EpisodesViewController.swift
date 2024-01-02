//
//  EpisodesViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 27.12.2023.
//

import UIKit

//class EpisodesViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        let label = UILabel()
//        label.text = "This is Episodes screen"
//        label.font = UIFont.systemFont(ofSize: 24)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}

class EpisodesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    
    var episodesData: [EpisodeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchData()
        
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
    
    func fetchData() {
        let episodeURL = URL(string: "https://rickandmortyapi.com/api/episode")!
        
        URLSession.shared.dataTask(with: episodeURL) { (data, _, error) in
            if let data = data, error == nil {
                do {
                    let episodeResponse = try JSONDecoder().decode(EpisodeResponse.self, from: data)
                    
                    for result in episodeResponse.results {
                        if let characterURL = result.characters.first {
                            self.fetchCharacterData(from: characterURL, episodeName: result.name, episodeNumber: result.episode)
                        }
                    }
                } catch {
                    print("Error decoding episode data: \(error)")
                }
            }
        }.resume()
    }
    
    
    func fetchCharacterData(from characterURL: String, episodeName: String, episodeNumber: String) {
        guard let url = URL(string: characterURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data, error == nil {
                do {
                    let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    
                    let episodeData = EpisodeData(
                        episodeName: episodeName,
                        episodeNumber: episodeNumber,
                        characterName: characterResponse.name,
                        characterSpecies: characterResponse.species,
                        characterImage: characterResponse.image
                    )
                    
                    self.episodesData.append(episodeData)
                    
                } catch {
                    print("Error decoding character data: \(error)")
                }
            }
        }.resume()
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
