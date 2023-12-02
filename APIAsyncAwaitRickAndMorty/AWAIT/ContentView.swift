//
//  ContentView.swift
//  AWAIT
//
//  Created by Sarah dos Santos Silva on 01/12/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.characters, id: \.id) { character in
                        HomeViewCell(character: character)
                    }
                }
                .padding()
                .task {
                    await viewModel.fetchCharacters()
                }
                .alert("", isPresented: $viewModel.hasError) {} message: {
                    Text(viewModel.errorMessage)
                }
            }
            .navigationTitle("Rick & Morty API")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct HomeViewCell: View {
    var character: Character
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.cyan)
                .opacity(0.9)
                .frame(height: 120)
            
            HStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 3, height: 120)
                        .clipped()
                        .cornerRadius(25)
                } placeholder: {
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width / 3, height: 120)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(character.name)
                        .font(.system(size: 16, weight: .semibold))
                    HStack(spacing: 8) {
                        Text("Status:")
                        Text(character.status)
                            .bold()
                    }
                    HStack(spacing: 8) {
                        Text("Gender:")
                        Text(character.gender)
                            .bold()
                    }
                    HStack(spacing: 8) {
                        Text("Species:")
                        Text(character.species)
                            .bold()
                    }
                }
                .font(.system(size: 14))
                .padding()
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .leading
                )
                Spacer()
            }
            .frame(height: 120)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeView()
}
