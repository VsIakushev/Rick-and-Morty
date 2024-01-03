//
//  TableViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 03.01.2024.
//

import UIKit

class CharacterDetailsView: UITableViewController {
    
    
    
    var characterData: [String: Any] = [:]
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView() // Remove empty cells
        
        // Set up image view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Set up name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ])
        
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Gender"
            cell.detailTextLabel?.text = characterData["gender"] as? String
        case 1:
            cell.textLabel?.text = "Status"
            cell.detailTextLabel?.text = characterData["status"] as? String
        case 2:
            cell.textLabel?.text = "Specie"
            cell.detailTextLabel?.text = characterData["species"] as? String
        case 3:
            cell.textLabel?.text = "Origin"
            if let origin = characterData["origin"] as? [String: Any],
               let originName = origin["name"] as? String {
                cell.detailTextLabel?.text = originName
            }
        case 4:
            cell.textLabel?.text = "Type"
            cell.detailTextLabel?.text = characterData["type"] as? String
        case 5:
            cell.textLabel?.text = "Location"
            if let location = characterData["location"] as? [String: Any],
               let locationName = location["name"] as? String {
                cell.detailTextLabel?.text = locationName
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


//class CharacterDetailsView: UITableViewController {
//
//    var episode: EpisodeData = EpisodeData(episodeName: "Pilot", episodeNumber: "S01E01", characterName: "Rick Sanchez", characterSpecies: "Human", characterImage: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//
//    /*
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    */
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
