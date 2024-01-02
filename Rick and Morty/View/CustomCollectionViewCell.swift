//
//  CustomCollectionViewCell.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 02.01.2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    // переменные для сохранения в избранное
    
    var episodeName: String = ""
    var episodeNumber: String = ""
    var characterName: String = ""
    var characterSpecies: String = ""
    var characterImage: String = ""
    
    
    var isFavorite: Bool = false {
            didSet {
                // Изменяем цвет кнопки в зависимости от isFavorite
                let heartImageName = isFavorite ? "heart.fill" : "heart"
                heartButton.setImage(UIImage(systemName: heartImageName), for: .normal)

                // Изменяем цвета кнопки
                let buttonColor: UIColor = isFavorite ? .red : .systemBlue
                heartButton.tintColor = buttonColor

                // Выводим сообщение в зависимости от isFavorite
                if isFavorite {
                    addToFavorites()
                } else {
                    removeFromFavorites()
                }
            }
        }
    
    let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
            view.layer.shadowOpacity = 0.2
            view.layer.shadowRadius = 4
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    let grayContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.layer.opacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let episodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        // Добавляем обработчик события для кнопки
                heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(speciesLabel)
        
        containerView.addSubview(grayContainerView)
        
        containerView.addSubview(episodeLabel)
        containerView.addSubview(heartButton)
        
        NSLayoutConstraint.activate([
                    containerView.topAnchor.constraint(equalTo: topAnchor),
                    containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    
                    imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                    imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 2/3),
                    
                    nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
                    nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                    
                    speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
                    speciesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                    
                    grayContainerView.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 5),
                    grayContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                    grayContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                    grayContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                    
                    episodeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 15),
                    episodeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                    
                    heartButton.centerYAnchor.constraint(equalTo: episodeLabel.centerYAnchor),
                    heartButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                ])
    }
    
    // Метод для конфигурации ячейки данными
    func configure(with episode: EpisodeData) {
        // Используем URLSession для асинхронной загрузки изображения
        if let imageURL = URL(string: episode.characterImage) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    // Обновляем UI на главном потоке
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
        
        // Устанавливаем текст в label
        nameLabel.text = "\(episode.characterName)"
        speciesLabel.text = "\(episode.characterSpecies)"
        episodeLabel.text = "\(episode.episodeName) | \(episode.episodeNumber)"
        
        // сохраняем данные в переменные, на случай добавления в избранное
        self.episodeName = episode.episodeName
        self.episodeNumber = episode.episodeNumber
        self.characterName = episode.characterName
        self.characterSpecies = episode.characterSpecies
        self.characterImage = episode.characterImage
       
    }
    
    @objc private func heartButtonTapped() {
           // Инвертируем значение isFavorite при каждом нажатии на кнопку
           isFavorite.toggle()
       }
    
    private func addToFavorites() {
        // Получаем словарь из UserDefaults
        var favorites: [String: Data]
        if let savedFavorites = UserDefaults.standard.dictionary(forKey: "favorites") as? [String: Data] {
            favorites = savedFavorites
        } else {
            favorites = [:]
        }

        if let jsonData = try? JSONEncoder().encode(EpisodeData(episodeName: episodeName, episodeNumber: episodeNumber, characterName: characterName, characterSpecies: characterSpecies, characterImage: characterImage)) {
               // Добавляем ячейку в избранное
               favorites[episodeName] = jsonData

               // Сохраняем обновленный словарь в UserDefaults
               UserDefaults.standard.set(favorites, forKey: "favorites")

               // Выводим сообщение
               print("added to fav")
            print(favorites)
           }
        
        
        // Добавляем ячейку в избранное
//        favorites[episodeName] = EpisodeData(episodeName: episodeName, episodeNumber: episodeNumber, characterName: characterName, characterSpecies: characterSpecies, characterImage: characterImage)

        // Сохраняем обновленный словарь в UserDefaults
//        UserDefaults.standard.set(favorites, forKey: "favorites")
//
//        // Выводим сообщение
//        print("added to fav")
//        print(favorites)
    }
    
    private func removeFromFavorites() {
        // Получаем словарь из UserDefaults
        var favorites: [String: Data]
        if let savedFavorites = UserDefaults.standard.dictionary(forKey: "favorites") as? [String: Data] {
            favorites = savedFavorites
        } else {
            favorites = [:]
        }

        // Удаляем ячейку из избранного
        favorites.removeValue(forKey: episodeName)

        // Сохраняем обновленный словарь в UserDefaults
        UserDefaults.standard.set(favorites, forKey: "favorites")

        // Выводим сообщение
        print("deleted from fav")
        print(favorites)
    }
    
    // Перенести на экран Favourites для загрузки
    func loadFavorites() -> [String: EpisodeData]? {
        guard let favoritesData = UserDefaults.standard.dictionary(forKey: "favorites") as? [String: Data] else {
            return [:]
        }

        var favorites: [String: EpisodeData] = [:]

        for (key, data) in favoritesData {
            if let episode = try? JSONDecoder().decode(EpisodeData.self, from: data) {
                favorites[key] = episode
            }
        }

        return favorites.isEmpty ? [:] : favorites
    }
    
}

