//
//  Task.swift
//  To-Do Manager
//
//  Created by Даниил Асташов on 18.12.2024.
//

import Foundation
    // тип задачи
enum TaskPriority {
    // текущая
    case normal
    // важная
    case important
}
    // состояние задачи
enum TaskStatus: Int {
    // запланированная
    case planned
    // завершенная
    case completed
}

// требования к типу, описывающему сущность "Задача"
protocol TaskProtocol {
    // название
    var title: String { get set }
    // тип
    var type: TaskPriority { get set }
    // статус
    var status: TaskStatus { get set }
}
// сущность "Задача"
struct Task: TaskProtocol {
    var title: String
    var type: TaskPriority
    var status: TaskStatus
}
