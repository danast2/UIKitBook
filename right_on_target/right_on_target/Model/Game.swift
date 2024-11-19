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

// MARK
