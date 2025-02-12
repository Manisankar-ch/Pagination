//
//  InitialViewModel.swift
//  Pagination
//
//
import Foundation


class InitialViewModel: ObservableObject {
    private var networkManager = NetworkManager()
    @Published var isLoading: Bool = false
    @Published var usersAndPosts: [UsersAndPosts] = []
    
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
