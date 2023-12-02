//
//  HomeViewModel.swift
//  AWAIT
//
//  Created by Sarah dos Santos Silva on 01/12/23.
//

import Foundation

let BASE_URL = "https://rickandmortyapi.com/api"

@MainActor
final class HomeViewModel: ObservableObject {
    private let client = Client()
    @Published private(set) var characters: [Character] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    var request: URLRequest = {
        let urlString = "\(BASE_URL)/character"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    func fetchCharacters() async {
        do {
            let response = try await client.fetch(type: Characters.self, with: request)
            characters = response.results.compactMap { $0 }
        } catch {
            errorMessage = "\((error as! ApiError).customDescription)"
            hasError = true
        }
    }
}
