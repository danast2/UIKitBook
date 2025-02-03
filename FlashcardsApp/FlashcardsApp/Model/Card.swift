// Модель карточки

import Foundation

struct Card: Identifiable, Codable {
    let id: UUID
    var frontText: String
    var backText: String
    var reviewDate: Date // дата последнего повторения
    var difficulty: Int // количество повторений (сложность)
    let createdAt: Date //дата создания
    var lastUpdated: Date //дата последнего обновления
    
    
    init(id: UUID = UUID(), frontText: String, backText: String, reviewDate: Date, difficulty: Int, createdAt: Date, lastUpdated: Date) {
        self.id = id
        self.frontText = frontText
        self.backText = backText
        self.reviewDate = reviewDate
        self.difficulty = difficulty
        self.createdAt = createdAt
        self.lastUpdated = lastUpdated
    }

}
