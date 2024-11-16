//
//  Game.swift
//  right_on_target
//
//  Created by Даниил Асташов on 16.11.2024.
//

import Foundation

protocol GameProtocol{
    var score: Int { get }
    var currentSecretValue: Int { get }
    var isGameEnded: Bool { get }
    func restartGame()
    func startNewRound()
    func calculateScore(with value: Int)
}


class Game: GameProtocol{
    var score: Int = 0
    private var minSecretValue:Int
    private var maxSecretValue:Int
    var currentSecretValue:Int = 0
    private var lastRound: Int
    private var currentRound: Int = 1
    var isGameEnded: Bool{
        if currentRound >= lastRound {
            return true
         } else {
             return false
         }
    }
    init?(startValue: Int, endValue: Int, rounds: Int) {
     // Стартовое значение для выбора случайного числа не может быть
    //больше конечного
         guard startValue <= endValue else {
             return nil
         }
             minSecretValue = startValue
             maxSecretValue = endValue
             lastRound = rounds
             currentSecretValue = self.getNewSecretValue()
         }

         func restartGame() {
             currentRound = 0
             score = 0
             startNewRound()
         }
        func startNewRound() {
             currentSecretValue = self.getNewSecretValue()
             currentRound += 1
         }
        // Загадать и вернуть новое случайное значение
         private func getNewSecretValue() -> Int {
             (minSecretValue...maxSecretValue).randomElement()!
         }

         // Подсчитывает количество очков
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

