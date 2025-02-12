//
//  InitialView.swift
//  Pagination
//
//

import SwiftUI

struct InitialView: View {
    
      var postsList: [Post]
       var body: some View {
           NavigationView {
               VStack {
                       List {
                           ForEach(postsList) { post in
                               VStack(alignment: .leading, spacing: 8) {
                                   Text(post.title)
                                       .font(.headline)
                                   Text(post.body)
                                       .font(.subheadline)
                                       .foregroundColor(.gray)
                               }
                               .padding(.vertical, 8)
                           }
                       }
                       .listStyle(PlainListStyle())
                   }
               }
               .navigationTitle("Posts")
       }
}

//#Preview {
//    InitialView()
//}
