//
//  ViewController.swift
//  Pagination

import UIKit
import Combine
import SwiftUI

class ViewController: UIViewController {
    
    lazy var swiftUIButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Swift UI", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.tag = 1
        button.addTarget(self, action: #selector(actionOnButton), for: .touchUpInside)
        return button
    }()
    
    lazy var swiftButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Swift", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(actionOnButton), for: .touchUpInside)
        return button
    }()
    
    lazy var hStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [swiftButton, swiftUIButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        return stackView
    }()
    
    
    @objc func actionOnButton(_ sender: UIButton) {
        switch(sender.tag) {
        case 0:
            handleSwiftPaginationView()
        case 1:
            handleSWiftUIPaginationView()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(hStackView)
        addConstraints()
        
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            hStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            hStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    private func handleSwiftPaginationView() {
        let viewController = InitialViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func handleSWiftUIPaginationView() {
        let swiftUIView = UsersView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.pushViewController(hostingController, animated: true)
//        addChild(hostingController)
//        view.addSubview(hostingController.view)
//        hostingController.didMove(toParent: self)
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            hostingController.view.widthAnchor.constraint(equalToConstant: view.frame.width),
//            hostingController.view.heightAnchor.constraint(equalToConstant: view.frame.height)
//        ])
    }
}
