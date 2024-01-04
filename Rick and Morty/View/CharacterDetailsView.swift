//
//  TableViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 03.01.2024.
//

import UIKit

class CharacterDetailsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var characterData: [String: Any] = [:]
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        
//        imageView.layer.shadowColor = UIColor.black.cgColor
//        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
//        imageView.layer.shadowOpacity = 0.8
//        imageView.layer.shadowRadius = 14
        return imageView
    }()

    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let tableView: UITableView = {
           let tableView = UITableView()
           tableView.translatesAutoresizingMaskIntoConstraints = false
           return tableView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchData()
        setupTableView()
    }
    
   
    
    func setupUI() {
        tableView.tableFooterView = UIView() // Remove empty cells
        
        // Set up image view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // Set up name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        
        // Настройка informationLabel
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(informationLabel)
        informationLabel.text = "Informations"
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        
    }
    
    func setupTableView() {
           tableView.frame = CGRect(x: 30, y: 350, width: view.frame.width - 60, height: view.frame.height - 100)
           tableView.dataSource = self
           tableView.delegate = self
           view.addSubview(tableView)
       }
    
    func fetchData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/1") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                self.characterData = json
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }.resume()
    }
    
    func updateUI() {
        // Update image view
        if let imageUrlString = characterData["image"] as? String,
           let imageUrl = URL(string: imageUrlString) {
            imageView.load(url: imageUrl)
        }
        
        // Update name label
        if let name = characterData["name"] as? String {
            nameLabel.text = name
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell(style: .value1, reuseIdentifier: nil)
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Gender"
            cell.subtitleLabel.text = characterData["gender"] as? String
        case 1:
            cell.titleLabel.text = "Status"
            cell.subtitleLabel.text = characterData["status"] as? String
        case 2:
            cell.titleLabel.text = "Specie"
            cell.subtitleLabel.text = characterData["species"] as? String
        case 3:
            cell.titleLabel.text = "Origin"
            if let origin = characterData["origin"] as? [String: Any],
               let originName = origin["name"] as? String {
                cell.subtitleLabel.text = originName
            }
        case 4:
            cell.titleLabel.text = "Type"
            cell.subtitleLabel.text = "Unknown"
//            characterData["type"] as? String
        case 5:
            cell.titleLabel.text = "Location"
            if let location = characterData["location"] as? [String: Any],
               let locationName = location["name"] as? String {
                cell.subtitleLabel.text = locationName
            }
        default:
            break
        }
        
        
        return cell
    }
}

// Extension to load image from URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
