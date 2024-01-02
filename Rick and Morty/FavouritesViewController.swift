//
//  FavouritesViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 31.12.2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "This is Favourites Screen"
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 30)
        view.addSubview(label)
    }
    
}
