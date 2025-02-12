//
//  Post.swift
//  Pagination
//
//

import Foundation

struct Post: Codable, Identifiable {
    let title: String
    let body: String
    let id: Int
    let userId: Int
}
