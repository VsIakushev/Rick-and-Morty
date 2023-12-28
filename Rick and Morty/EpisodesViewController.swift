//
//  EpisodesViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 27.12.2023.
//

import UIKit

class EpisodesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Создаем надпись "This is main screen"
        let label = UILabel()
        label.text = "This is Episodes screen"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем надпись на экран
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
