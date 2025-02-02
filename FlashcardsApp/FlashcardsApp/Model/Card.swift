// Модель карточки

import Foundation

struct Card: Identifiable, Codable {
    let id: UUID
    var frontText: String
    var backText: String
    var reviewDate: Date // дата последнего повторения
    var difficulty: Int // количество повторений (сложность)
    
    
    init(id: UUID = UUID(), frontText: String, backText: String, reviewDate: Date, difficulty: Int) {
            self.id = id
            self.frontText = frontText
            self.backText = backText
            self.reviewDate = reviewDate
            self.difficulty = difficulty
        }

}
