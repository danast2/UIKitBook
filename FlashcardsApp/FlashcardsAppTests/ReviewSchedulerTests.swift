import XCTest
@testable import FlashcardsApp

final class ReviewSchedulerTests: XCTestCase {

    func testNextReviewDateForDifficulty() {
        let calendar = Calendar.current
        let today = Date()

        let easyDate = ReviewScheduler.getNextReviewDate(forDifficulty: 0)
        let mediumDate = ReviewScheduler.getNextReviewDate(forDifficulty: 1)
        let hardDate = ReviewScheduler.getNextReviewDate(forDifficulty: 2)
        let veryHardDate = ReviewScheduler.getNextReviewDate(forDifficulty: 3)
        let unknownDate = ReviewScheduler.getNextReviewDate(forDifficulty: 99)

        XCTAssertEqual(calendar.date(byAdding: .day, value: 10, to: today)!.timeIntervalSinceReferenceDate, easyDate.timeIntervalSinceReferenceDate, accuracy: 1, "Дата для 'Запомнено' должна быть через 10 дней")
        XCTAssertEqual(calendar.date(byAdding: .day, value: 5, to: today)!.timeIntervalSinceReferenceDate, mediumDate.timeIntervalSinceReferenceDate, accuracy: 1, "Дата для 'Средне' должна быть через 5 дней")
        XCTAssertEqual(calendar.date(byAdding: .day, value: 2, to: today)!.timeIntervalSinceReferenceDate, hardDate.timeIntervalSinceReferenceDate, accuracy: 1, "Дата для 'Сложно' должна быть через 2 дня")
        XCTAssertEqual(calendar.date(byAdding: .day, value: 1, to: today)!.timeIntervalSinceReferenceDate, veryHardDate.timeIntervalSinceReferenceDate, accuracy: 1, "Дата для 'Очень сложно' должна быть завтра")
        XCTAssertEqual(unknownDate.timeIntervalSinceReferenceDate, today.timeIntervalSinceReferenceDate, accuracy: 1, "Для неизвестной сложности дата должна быть текущей")
    }
}
