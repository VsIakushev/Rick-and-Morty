//
//  LaunchScreenViewController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 27.12.2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    let logoImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(named: "Logo")
           imageView.contentMode = .scaleAspectFit
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()

       let loadingImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(named: "Loading")
           imageView.contentMode = .scaleAspectFit
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

               // Добавляем логотип сверху
               view.addSubview(logoImageView)
               NSLayoutConstraint.activate([
                   logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
                   logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 0.2) // Высота логотипа - 20% от ширины
               ])

               // Добавляем изображение "Loading" по центру
               view.addSubview(loadingImageView)
               NSLayoutConstraint.activate([
                   loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   loadingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                   loadingImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5), // Ширина изображения - 50% от ширины экрана
                   loadingImageView.heightAnchor.constraint(equalTo: loadingImageView.widthAnchor) // Высота равна ширине для сохранения пропорций
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
