//
//  LaunchScreenViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 27.12.2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Добавляем логотип сверху
        let logoImageView = UIImageView(image: UIImage(named: "Logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Добавляем изображение "Loading" по центру
        let loadingImageView = UIImageView(image: UIImage(named: "Loading"))
        loadingImageView.contentMode = .scaleAspectFit
        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingImageView)
        
        NSLayoutConstraint.activate([
            loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingImageView.widthAnchor.constraint(equalToConstant: 100),
            loadingImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Анимация вращения для изображения "Loading"
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotationAnimation.duration = 1.5
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
        loadingImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        // Задаем таймер для перехода на основной экран
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss(animated: true, completion: nil)
            self.navigateToMainScreen()
        }
    }
    
    private func navigateToMainScreen() {
        let vc = EpisodesViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
}
