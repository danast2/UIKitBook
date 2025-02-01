// Модель карточки

import Foundation

struct Card: Identifiable {
    let id: UUID
    var frontText: String
    var backText: String
    var reviewDate: Date
    var difficulty: Int
}
