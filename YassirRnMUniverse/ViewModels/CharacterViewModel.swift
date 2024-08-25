//
//  CharacterViewModel.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//
import Foundation
import Combine

protocol CharacterViewModelProtocol {
    var charactersPublisher: Published<[Character]>.Publisher { get }
    func fetchCharacters()
    func filterCharacters(by index: Int)
    func displayAllCharacters()
}

class CharacterViewModel: CharacterViewModelProtocol {
    @Published var characters = [Character]()
    var allCharacters = [Character]()
    private var cancellables: Set<AnyCancellable> = []
    private var apiService: APIServiceProtocol
    private var currentPage = 1
    private var isFetching = false
    private var currentFilterIndex: Int = 0

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    var charactersPublisher: Published<[Character]>.Publisher { $characters }

    func fetchCharacters() {
        guard !isFetching else { return }
        isFetching = true

        var charactersFetched = 0
        var results = [Character]()

        func fetchNextPage() {
            apiService.fetchCharacters(page: currentPage)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.isFetching = false
                    if case .failure(let error) = completion {
                        print("Error: \(error)")
                    }
                }, receiveValue: { [weak self] characterResponse in
                    guard let self = self else { return }
                    results.append(contentsOf: characterResponse.results)
                    charactersFetched += characterResponse.results.count
                    if charactersFetched < 20 {
                        // Fetch more pages if we haven't reached 20 characters
                        self.currentPage += 1
                        fetchNextPage()
                    } else {
                        self.allCharacters.append(contentsOf: results.prefix(20))
                        self.applyCurrentFilter()
                        self.isFetching = false
                    }
                })
                .store(in: &cancellables)
        }

        fetchNextPage()
    }

    func displayAllCharacters() {
        characters = allCharacters
    }

    func filterCharacters(by index: Int) {
        currentFilterIndex = index
        applyCurrentFilter()
    }

    private func applyCurrentFilter() {
        switch currentFilterIndex {
        case 1: // Alive
            characters = allCharacters.filter { $0.status == "Alive" }
        case 2: // Dead
            characters = allCharacters.filter { $0.status == "Dead" }
        case 3: // Unknown
            characters = allCharacters.filter { $0.status == "unknown" }
        default: // All or any other case
            characters = allCharacters
        }
    }
}
