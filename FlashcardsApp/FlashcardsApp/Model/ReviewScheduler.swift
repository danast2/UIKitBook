//Логика интервального повторения

import Foundation

class ReviewScheduler {
    static func getNextReviewDate(forDifficulty difficulty: Int) -> Date {
        let calendar = Calendar.current
        switch difficulty {
        case 0: return calendar.date(byAdding: .day, value: 10, to: Date())!  // Запомнено (реже показывать)
        case 1: return calendar.date(byAdding: .day, value: 5, to: Date())! // Средне
        case 2: return calendar.date(byAdding: .day, value: 2, to: Date())! // Сложно
        case 3: return calendar.date(byAdding: .day, value: 1, to: Date())! // Очень сложно (почти сразу)
        default: return Date()
        }
    }
}
