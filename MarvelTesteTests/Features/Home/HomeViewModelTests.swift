//
//  HomeViewModelTests.swift
//  MarvelTesteTests
//
//  Created by Pedro Ernersto on 1/24/24.
//

import XCTest
@testable import MarvelTeste

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockCharactersService: MockCharactersService!
    var mockFavoriteCharacterManager: MockFavoriteCharacterManager!
    var mockDelegate: MockHomeViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockCharactersService = MockCharactersService()
        mockFavoriteCharacterManager = MockFavoriteCharacterManager()
        viewModel = HomeViewModel(service: mockCharactersService, favoriteCharacterManager: mockFavoriteCharacterManager)
        mockDelegate = MockHomeViewModelDelegate()
        viewModel.delegate = mockDelegate
    }

    func testGetCharactersSuccess() {
        let expectation = XCTestExpectation(description: "Characters fetched")
        mockCharactersService.mockResult = .success([CharacterApiResponse.Character.mock()])
        viewModel.getCharacters()
        
        DispatchQueue.main.async {
            // Assertions go here
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetCharactersFailure() {
        let expectation = XCTestExpectation(description: "Characters fetch failed")
        mockCharactersService.mockResult = .failure(NSError(domain: "", code: 0, userInfo: nil))
        viewModel.getCharacters()
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.characters.count, 0, "Characters should be empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testToggleFavorite() {
        let mockCharacter = Character.mock()
        viewModel.characters = [mockCharacter]
        viewModel.currentCharacters = viewModel.characters
        
        XCTAssertFalse(viewModel.currentCharacters[0].isFavorite, "Favorite should be false initially")
        
        viewModel.toggleFavorite(for: viewModel.currentCharacters[0])
        
        XCTAssertTrue(viewModel.currentCharacters[0].isFavorite, "Favorite status should be toggled to true")
    }
    
    func testSearchCharacters() {
        let mockCharacter1 = Character.mock(name: "aranha")
        let mockCharacter2 = Character.mock(name: "capitao america")
        viewModel.characters = [mockCharacter1, mockCharacter2]
        viewModel.currentCharacters = viewModel.characters
        viewModel.searchCharacters(with: "Spider")
        
        XCTAssertEqual(viewModel.currentCharacters.count, 0, "There should be no results after search")
        
        viewModel.searchCharacters(with: "")
        
        XCTAssertEqual(viewModel.currentCharacters.count, 2, "There should be initial characters present")
        
        viewModel.searchCharacters(with: "aranha")
        
        XCTAssertEqual(viewModel.currentCharacters[0].character.name, "aranha", "There should be one character, aranha")
    }
    
    func testDelegateCalledOnSuccess() {
        let expectation = XCTestExpectation(description: "Delegate called on success")
        mockCharactersService.mockResult = .success([CharacterApiResponse.Character.mock()])
        viewModel.getCharacters()
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockDelegate.didCallHandleUpdatedCharacters, "Delegate method should be called after getting characters")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

}

class MockHomeViewModelDelegate: HomeViewModelDelegate {
    var didCallHandleUpdatedCharacters = false

    func handleUpdatedCharacters() {
        didCallHandleUpdatedCharacters = true
    }
}
