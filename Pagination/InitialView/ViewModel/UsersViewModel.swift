//
//  UsersViewModel.swift
//  Pagination
//
//  Created by Softsuave-iOS dev on 12/02/25.
//

import Foundation

@Observable
class UsersViewModel {
    var usersAndPosts: [UsersAndPosts] = []
    var isLoading: Bool = false
    
    private var networkManager = NetworkManager()
    
    @MainActor
    func getUsers() async {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        let postsString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString), let postsUrl = URL(string: postsString) else { return }
        
        defer {
            isLoading = false
        }
        isLoading = true
        do {
            async let allUsers:[User] = try await networkManager.fetchData(from: url)
            async let allPosts: [Post] = try await networkManager.fetchData(from: postsUrl)
            let (users, posts) = await(try allUsers, try allPosts)
            for user in users {
                let userPosts = posts.filter({$0.userId == user.id})
                let newUserAndPost = UsersAndPosts(user: user, posts: userPosts)
                usersAndPosts.append(newUserAndPost)
            }
            
        } catch {
            print("Error fetching posts: \(error.localizedDescription)")
        }
    }
}
