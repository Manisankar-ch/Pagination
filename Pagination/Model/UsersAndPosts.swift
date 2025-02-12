//
//  UsersAndPosts.swift
//  Pagination
//
//  Created by Softsuave-iOS dev on 12/02/25.
//
import Foundation

struct UsersAndPosts: Codable, Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var numberOfposts: Int {
        posts.count }
}
