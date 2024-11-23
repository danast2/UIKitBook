//
//  Game.swift
//  right_on_target
//
//  Created by Даниил Асташов on 16.11.2024.
//

import Foundation

protocol GeneratorProtocol{
    // Загадать и вернуть новое случайное значение
    func getRandomValue(_ minV: Int, _ maxV: Int)->Int
}

class Generator: GeneratorProtocol{
    func getRandomValue(_ minSecretValue: Int, _ maxSecretValue: Int) -> Int {
        return (minSecretValue...maxSecretValue).randomElement()!
    }
}

protocol GameRoundProtocol{
    var score:Int { get set }
    var currentSecretValue: Int! { get set }
    
    func calculateScore(with value: Int)
}

class GameRound: GameRoundProtocol{
    var score: Int = 0
    var currentSecretValue:Int! = 0
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
}

protocol GameProtocol{
        var score: Int { get set }
        var secretValueGenerator: GeneratorProtocol { get set }
        var currentRound: GameRoundProtocol! { get  set}
        var isGameEnded: Bool { get  }
    
        func restartGame()
        func startNewRound()
}

class Game: GameProtocol{
    private var minSecretValue:Int
    private var maxSecretValue:Int
    private var lastRound: Int
    private var curRou: Int = 1
    
    var score: Int = 0
    var secretValueGenerator:  GeneratorProtocol
    var currentRound: GameRoundProtocol!
    var isGameEnded: Bool{
        return curRou >= lastRound
    }
    init?(startValue: Int, endValue:Int , rounds: Int, generator: GeneratorProtocol, round: GameRoundProtocol){
        guard startValue <= endValue else {
            return nil
        }
        self.secretValueGenerator = generator
        self.currentRound = round
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = rounds
        currentRound.currentSecretValue = secretValueGenerator.getRandomValue(minSecretValue, maxSecretValue)
    }
    func restartGame() {
        curRou = 0
        score = 0
        currentRound.score = 0
        startNewRound()
    }
    func startNewRound() {
        currentRound.currentSecretValue = secretValueGenerator.getRandomValue(minSecretValue, maxSecretValue)
        currentRound.score = 0
        curRou += 1
    }
}

// MARK new realisation
enum GeneratorType {
    case int(range: ClosedRange<Int>)
    case hexColor
}

protocol NewGeneratorProtocol{
    associatedtype Value
    func newGenerateRandomValue() -> Value
}

protocol NewGameRoundProtocol{
    associatedtype Value
    var score: Int { get set }
    var secretValue: Value { get set }
    func calculateScore(with value: Value)
}

protocol NewGameProtocol {
    associatedtype Value: Equatable
    var score: Int { get set }
    var generator: NewGenerator<Value> { get set } // Указываем конкретный класс
    var currentRound: NewGameRound<Value>! { get set } // Указываем конкретный класс
    var isGameEnded: Bool { get }

    func restartGame()
    func startNewRound()
}

class NewGenerator<T>: NewGeneratorProtocol {
    typealias Value = T
    private let generateBlock: () -> T

    init(generateBlock: @escaping () -> T) {
        self.generateBlock = generateBlock
    }

    func newGenerateRandomValue() -> T {
        return generateBlock()
    }
}

class NewGameRound<T: Equatable>: NewGameRoundProtocol {
    typealias Value = T
    
    var score: Int = 0
    var secretValue: T
    
    init(secretValue: T) {
        self.secretValue = secretValue
    }
    
    func calculateScore(with value: T) {
        fatalError("This method should be overridden in a type-specific extension")
    }
}
extension NewGameRound where T == Int {
    func calculateScore(with value: Int) {
        let difference = abs(secretValue - value)
        score = max(0, 50 - difference)
    }
}
extension NewGameRound where T == String {
    func calculateScore(with value: String) {
        if value == secretValue {
            score = 50  // Correct answer
        } else {
            score = 0   // Incorrect answer
        }
    }
}


class NewGame<T: Equatable>: NewGameProtocol {
    typealias Value = T

    private var totalRounds: Int
    private var currentRoundNumber: Int = 1
    var score: Int = 0
    var generator: NewGenerator<T> // Используем конкретный класс
    var currentRound: NewGameRound<T>! // Используем конкретный класс
    var isGameEnded: Bool {
        return currentRoundNumber >= totalRounds
    }

    init(rounds: Int, generator: NewGenerator<T>) {
        self.totalRounds = rounds
        self.generator = generator
    }

    func restartGame() {
        score = 0
        currentRoundNumber = 0
        startNewRound()
    }

    func startNewRound() {
        let secretValue = generator.newGenerateRandomValue()
        currentRound = NewGameRound(secretValue: secretValue)
        currentRoundNumber += 1
    }
}

