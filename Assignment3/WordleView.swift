//
//  WordleView.swift
//  FinalAssignment
//
//  Created by user225812 on 4/04/23.
//

import SwiftUI

struct WordleView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter a 5-letter word", text: $viewModel.inputWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .disabled(viewModel.gameState != .ongoing)
                    .multilineTextAlignment(.center)

                VStack {
                    ForEach(viewModel.wordList) { word in
                        HStack {
                            ForEach(0..<word.value.count, id: \.self) { index in
                                let character = word.value[word.value.index(word.value.startIndex, offsetBy: index)]
                                Text(String(character))
                                    .frame(width: 40, height: 40)
                                    .background(characterBackground(characterStatus: word.characterStatus[index]))
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                
                Text("Attempts left: \(viewModel.attemptsLeft)")
                    .font(.title2)
                    .padding(.bottom)

                Button(action: viewModel.processInput) {
                    Text("Submit")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(viewModel.inputWord.count != 5 || viewModel.gameState != .ongoing)

                switch viewModel.gameState {
                case .won:
                    Text("You won!")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                case .lost:
                    VStack {
                        Text("You lost!")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        Text("Correct word: \(viewModel.targetWord)")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                default:
                    EmptyView()
                }

                if viewModel.gameState != .ongoing {
                    Button(action: viewModel.resetGame) {
                        Text("Play Again")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
            .navigationBarTitle("Wordle", displayMode: .inline)
        }
    }

    func characterBackground(characterStatus: CharacterStatus) -> Color {
        switch characterStatus {
        case .correct:
            return .green
        case .incorrect:
            return .red
        case .unguessed:
            return .gray
        }
    }
}
