import XCTest
@testable import FlashcardsApp

final class CardTests: XCTestCase {

    var card: Card!

    override func setUp() {
        super.setUp()
        card = Card(
            frontText: "Hello",
            backText: "Привет",
            reviewDate: Date(),
            difficulty: 1,
            createdAt: Date(),
            lastUpdated: Date(),
            imagePath: "path/to/image.png"
        )
    }

    override func tearDown() {
        card = nil
        super.tearDown()
    }

    //  Тест 1: Проверка инициализации карточки
    func testCardInitialization() {
        XCTAssertNotNil(card, "Карточка должна создаваться")
        XCTAssertEqual(card.frontText, "Hello", "Текст на лицевой стороне должен совпадать")
        XCTAssertEqual(card.backText, "Привет", "Текст на обратной стороне должен совпадать")
        XCTAssertEqual(card.difficulty, 1, "Сложность должна быть равна 1")
        XCTAssertEqual(card.imagePath, "path/to/image.png", "Путь к изображению должен совпадать")
    }

    // Тест 2: Проверка изменения текста карточки
    func testUpdatingCardText() {
        card.frontText = "Updated Front"
        card.backText = "Обновленный Текст"
        
        XCTAssertEqual(card.frontText, "Updated Front", "Текст на лицевой стороне должен обновиться")
        XCTAssertEqual(card.backText, "Обновленный Текст", "Текст на обратной стороне должен обновиться")
    }

    //  Тест 3: Проверка обновления даты последнего изменения
    func testUpdatingLastUpdatedDate() {
        let oldDate = card.lastUpdated
        sleep(1) // ждём 1 секунду, чтобы дата изменилась
        card.lastUpdated = Date()

        XCTAssertNotEqual(card.lastUpdated, oldDate, "Дата последнего обновления должна измениться")
    }

    // Тест 4: Проверка изменения сложности карточки
    func testDifficultyIncrement() {
        let oldDifficulty = card.difficulty
        card.difficulty += 1

        XCTAssertEqual(card.difficulty, oldDifficulty + 1, "Сложность карточки должна увеличиться")
    }

    // Тест 5: Проверка установки новой даты повторения
    func testReviewDateUpdate() {
        let newReviewDate = Calendar.current.date(byAdding: .day, value: 3, to: card.reviewDate)
        card.reviewDate = newReviewDate!

        XCTAssertEqual(card.reviewDate, newReviewDate, "Дата повторения должна обновляться")
    }
}
