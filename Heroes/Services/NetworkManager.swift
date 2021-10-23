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
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
//            print("url: \(url)")
//            print("response url: \(response.url!)")
//            guard url == response.url else { return }
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}
