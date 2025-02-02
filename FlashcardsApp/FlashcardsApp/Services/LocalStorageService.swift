import Foundation

class LocalStorageService {
    private let decksKey = "decks_storage"

    // Метод сохранения всех колод (включая карточки внутри них)
    func saveDecks(_ decks: [Deck]) {
        if let encoded = try? JSONEncoder().encode(decks) {
            UserDefaults.standard.set(encoded, forKey: decksKey)
        }
    }

    // Метод загрузки всех колод
    func loadDecks() -> [Deck] {
        if let savedData = UserDefaults.standard.data(forKey: decksKey),
           let decodedDecks = try? JSONDecoder().decode([Deck].self, from: savedData) {
            return decodedDecks
        }
        return []
    }
}
