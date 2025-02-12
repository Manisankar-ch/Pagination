//
//  InitialViewController.swift
//  Pagination
//
//

import UIKit
import Combine
import SwiftUI

class InitialViewController: UIViewController {
    
    private var viewModel = InitialViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    lazy var paginationtableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(InitialTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        Task {
            await viewModel.getUsers()
        }
        addConstraints()
        addObserver()
        navigationController?.topViewController?.view.backgroundColor = .white
    }
    
    deinit {
        print("\(self) deallocated")
    }
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            paginationtableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            paginationtableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            paginationtableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paginationtableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func addSubViews() {
        activityIndicator.center = view.center
        view.addSubview(paginationtableView)
        view.addSubview(activityIndicator)
    }
    
    func handleLoader(isShow: Bool) {
        DispatchQueue.main.async {
            if isShow {
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension InitialViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersAndPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InitialTableViewCell
        
        
        let data = viewModel.usersAndPosts[indexPath.row]
        cell.configure(title: data.user.name, subtitle: data.user.email)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.usersAndPosts[indexPath.row]
        let vc = PostsViewController(posts: data.posts)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
//            viewModel.getPosts()
        }
    }
}


//MARK: - Observers
extension InitialViewController {
    func addObserver() {
        viewModel.$isLoading.receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.handleLoader(isShow: isLoading)
            }
            .store(in: &cancellables)
        
        //For tableView
        viewModel.$usersAndPosts.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.paginationtableView.reloadData()
            }
            .store(in: &cancellables)
    }
}
