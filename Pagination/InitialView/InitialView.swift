//
//  InitialView.swift
//  Pagination
//
//

import SwiftUI

struct InitialView: View {
    @StateObject private var viewModel = InitialViewModel()
       
       var body: some View {
           NavigationView {
               VStack {
                   if viewModel.isLoading && viewModel.postsList.isEmpty {
                       ProgressView("Loading...")
                   } else {
                       List {
                           ForEach(viewModel.postsList) { post in
                               VStack(alignment: .leading, spacing: 8) {
                                   Text(post.title)
                                       .font(.headline)
                                   Text(post.body)
                                       .font(.subheadline)
                                       .foregroundColor(.gray)
                               }
                               .padding(.vertical, 8)
                           }
                           
                           if viewModel.isLoading {
                               HStack {
                                   Spacer()
                                   ProgressView()
                                   Spacer()
                               }
                           } else if viewModel.postsList.count < 100 {
                               HStack {
                                   Spacer()
                                   Button("Load More") {
                                       Task {
                                           await viewModel.fetchPosts()
                                       }
                                   }
                                   Spacer()
                               }
                           }
                       }
                       .listStyle(PlainListStyle())
                   }
               }
               .navigationTitle("Posts")
               .onAppear {
                   Task {
                       await viewModel.fetchPosts()
                   }
               }
           }
       }
}

#Preview {
    InitialView()
}
