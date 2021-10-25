//
//  NetworkManager.swift
//  Heroes
//
//  Created by Alexey Efimov on 22.10.2021.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData() async throws -> [Superhero] {
        guard let url = URL(string: "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let superheroes = try? JSONDecoder().decode([Superhero].self, from: data) else {
            throw NetworkError.decodingError
        }
        return superheroes
    }
    
    func fetchImageData(from url: URL) async throws -> Data {
        let task = Task { () -> Data in
//            try Task.checkCancellation()
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
//        task.cancel()
        let imageData = try await task.value
        return imageData
    }
}
