//
//  CharacterViewModelTests.swift
//  YassirRnMUniverseTests
//
//  Created by Rotimi Joshua on 25/08/2024.
//

import XCTest
import Combine
@testable import YassirRnMUniverse

class CharacterViewModelTests: XCTestCase {
    var viewModel: CharacterViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let mockAPIService = MockAPIService()
        viewModel = CharacterViewModel(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testFilterCharactersByStatus() {
        // Given
        let characters = [
            Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", image: ""),
            Character(id: 2, name: "Morty Smith", status: "Dead", species: "Human", image: ""),
            Character(id: 3, name: "Summer Smith", status: "Alive", species: "Human", image: "")
        ]
        viewModel.allCharacters = characters
        viewModel.filterCharacters(by: 1) 

        // Then
        XCTAssertEqual(viewModel.characters.count, 2)
    }

    func testFetchCharacters() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch characters")

        // When
        viewModel.fetchCharacters()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.characters.count, 20)

            // Ensure that the first character is Rick Sanchez
            XCTAssertEqual(self.viewModel.characters.first?.name, "Rick Sanchez")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testDisplayAllCharacters() {
        // Given
        let characters = [
            Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", image: ""),
            Character(id: 2, name: "Morty Smith", status: "Dead", species: "Human", image: ""),
            Character(id: 3, name: "Summer Smith", status: "Alive", species: "Human", image: "")
        ]
        viewModel.allCharacters = characters
        viewModel.filterCharacters(by: 1)

        // When
        viewModel.displayAllCharacters()

        // Then
        XCTAssertEqual(viewModel.characters.count, 3)
    }
}

class MockAPIService: APIServiceProtocol {
    func fetchCharacters(page: Int) -> AnyPublisher<CharacterResponse, Error> {
        let characters = [
            Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        ]

        let response = CharacterResponse(results: characters)

        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
