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
    
    func fetchData(completion: @escaping(Result<[Superhero], NetworkError>) -> Void) {
        guard let url = URL(string: "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let superheroes = try JSONDecoder().decode([Superhero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(superheroes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImageData(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url.lastPathComponent == response.url?.lastPathComponent else { return }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}
