//
//  CharacterStatus.swift
//  FinalAssignment
//
//  Created by user225812 on 4/04/23.
//

import Foundation

struct Word: Identifiable {
    let id = UUID()
    let value: String
    var guessed: Bool
    var characterStatus: [CharacterStatus]
}

enum CharacterStatus {
    case correct
    case incorrect
    case unguessed
}

enum GameState {
    case ongoing
    case won
    case lost
}
