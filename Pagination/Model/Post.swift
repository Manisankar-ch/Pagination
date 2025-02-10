//
//  Post.swift
//  Pagination
//
//

import Foundation

struct Post: Codable, Identifiable {
    var title: String
    var body: String
    var id: Int
    var userId: Int
}
