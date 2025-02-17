import XCTest
@testable import FlashcardsApp

final class LocalStorageServiceTests: XCTestCase {
    
    var storage: LocalStorageService!

    override func setUp() {
        super.setUp()
        storage = LocalStorageService()
    }

    override func tearDown() {
        storage = nil
        super.tearDown()
    }

    func testSavingAndLoadingDecks() {
        let deck = Deck(id: UUID(), name: "Sample Deck", cards: [])
        
        // Сохраняем массив колод
        storage.saveDecks([deck])

        // Загружаем массив колод
        let loadedDecks = storage.loadDecks()

        XCTAssertFalse(loadedDecks.isEmpty, "Список загруженных колод не должен быть пустым")
        XCTAssertEqual(loadedDecks.first?.name, "Sample Deck", "Название загруженной колоды должно совпадать")
    }
}
