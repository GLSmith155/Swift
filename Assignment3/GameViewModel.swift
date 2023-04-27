//
//  GameViewModel.swift
//  FinalAssignment
//
//  Created by user225812 on 4/04/23.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var targetWord: String = ""
    @Published var inputWord: String = ""
    @Published var wordList: [Word] = []
    @Published var gameState: GameState = .ongoing
    @Published var attemptsLeft: Int = 6
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchWord()
    }
    
    func fetchWord() {
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=1&length=5") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                try JSONDecoder().decode([String].self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching word: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] words in
                self?.targetWord = words.first?.lowercased() ?? ""
            })
            .store(in: &cancellables)
    }
    
    func processInput() {
        if inputWord.lowercased() == targetWord.lowercased() {
            gameState = .won
            return
        }
        
        if attemptsLeft <= 1 {
            gameState = .lost
            return
        }
        
        var characterStatus: [CharacterStatus] = []
        for (index, character) in inputWord.enumerated() {
            let targetCharacter = targetWord[targetWord.index(targetWord.startIndex, offsetBy: index)]
            if targetCharacter == character {
                characterStatus.append(.correct)
            } else if targetWord.contains(character) {
                characterStatus.append(.incorrect)
            } else {
                characterStatus.append(.unguessed)
            }
        }
        
        let newWord = Word(value: inputWord, guessed: false, characterStatus: characterStatus)
        wordList.append(newWord)
        
        inputWord = ""
        attemptsLeft -= 1
    }
    
    func resetGame() {
        targetWord = ""
        inputWord = ""
        wordList = []
        gameState = .ongoing
        attemptsLeft = 6
        fetchWord()
    }
}
