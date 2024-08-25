//
//  APIService.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//
import Foundation
import Combine

protocol APIServiceProtocol {
    func fetchCharacters(page: Int) -> AnyPublisher<CharacterResponse, Error>
}

class APIService: APIServiceProtocol {
    func fetchCharacters(page: Int) -> AnyPublisher<CharacterResponse, Error> {
        var urlComponents = URLComponents(string: Constants.baseURL + Constants.characterEndpoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]

        guard let url = urlComponents?.url else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
