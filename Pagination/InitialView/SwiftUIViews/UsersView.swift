//
//  UsersView.swift
//  Pagination
//
//  Created by Softsuave-iOS dev on 12/02/25.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel()
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.usersAndPosts) { user in
                        NavigationLink(destination: InitialView(postsList: user.posts)) {
                            VStack(alignment: .leading) {
                                Text(user.user.name)
                                    .font(.title3)
                                
                                Text(user.user.email)
                                    .font(.title2)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Users")
        .listStyle(.plain)
        .task {
           if viewModel.usersAndPosts.isEmpty {
                await viewModel.getUsers()
            }
        }
    }
}

#Preview {
    UsersView()
}
