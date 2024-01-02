////
////  ViewController.swift
////  Rick and Morty
////
////  Created by Vitaliy Iakushev on 27.12.2023.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    
//    var transitionCompletion: (() -> Void)?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        
//        // Добавляем логотип сверху
//        let logoImageView = UIImageView(image: UIImage(named: "Logo"))
//        logoImageView.contentMode = .scaleAspectFit
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(logoImageView)
//        
//        NSLayoutConstraint.activate([
//            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
//            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoImageView.widthAnchor.constraint(equalToConstant: 100),
//            logoImageView.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        
//        // Добавляем изображение "Loading" по центру
//        let loadingImageView = UIImageView(image: UIImage(named: "Loading"))
//        loadingImageView.contentMode = .scaleAspectFit
//        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(loadingImageView)
//        
//        NSLayoutConstraint.activate([
//            loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            loadingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            loadingImageView.widthAnchor.constraint(equalToConstant: 100),
//            loadingImageView.heightAnchor.constraint(equalToConstant: 100)
//        ])
//        
//        // Анимация вращения для изображения "Loading"
//        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
//        rotationAnimation.duration = 1.5
//        rotationAnimation.isCumulative = true
//        rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
//        loadingImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
//        
//        // Задержка перед переходом на основной экран
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.navigateToEpisodesScreen()
//        }
//    }
//    
//    private func navigateToEpisodesScreen() {
//        let episodesViewController = EpisodesViewController()
//        let navigationController = UINavigationController(rootViewController: episodesViewController)
//        navigationController.navigationBar.isHidden = true
//        navigationController.modalTransitionStyle = .crossDissolve
//        navigationController.modalPresentationStyle = .fullScreen
//        // Запускаем замыкание перед переходом
//        self.transitionCompletion?()
//        
//        // Показываем EpisodesViewController после закрытия AnimatedLaunchScreenViewController
//        self.present(navigationController, animated: true, completion: nil)
//    }
//    
//}
//
