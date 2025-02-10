//
//  InitialViewModel.swift
//  Pagination
//
//
import Foundation

@MainActor
class InitialViewModel: ObservableObject {
    private var networkManager = NetworkManager()
    @Published var isLoading: Bool = false
    @Published var postsList: [Post] = []
    private var currentPage: Int = 1
    private var postsPerPage: Int = 20
    
    func fetchPosts() async {
        guard !isLoading,  postsList.count < 100 else { return }
        isLoading = true
        
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(postsPerPage)"
        guard let url = URL(string: urlString) else { return }
        
        do {
            let newPosts: [Post] = try await networkManager.fetchData(from: url, model: [Post].self)
            postsList.append(contentsOf: newPosts)
            currentPage += 1
            
            
        } catch {
            print("Error fetching posts: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func getPosts() {
        if postsList.count < 100 {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_limit=\(postsPerPage)&_page=\(currentPage)") else {
                return
            }
            isLoading = true
            //            callAsyncAwait(url: url)
            callCompletionHandler(url: url)
            
        }
    }
    
    func callCompletionHandler(url: URL) {
        self.networkManager.fetchData(from: url, model: [Post].self) { result in
            self.isLoading = false
            switch result {
            case .success(let posts):
                self.currentPage += 1
                
                
                self.postsList += posts
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    func callAsyncAwait(url: URL) {
        
        Task {
            do {
                let posts: [Post] = try await self.networkManager.fetchData(from: url, model: [Post].self)
                self.isLoading = false
                self.currentPage += 1
                self.postsList += posts
            } catch {
                self.isLoading = false
                print("Error fetching posts: \(error.localizedDescription)")
            }
        }
    }
}
