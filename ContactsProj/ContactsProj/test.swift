
//messenger.statisticDelegate = messenger.self
//messenger.send(message: Message(text: "Привет!", sendDate: Date(),
//senderID: 1))
//messenger.messages.count // 1
//(messenger.statisticDelegate as! Messenger).messages.count // 1

import Foundation

protocol MessengerDataSourceProtocol: AnyObject {
    func getMessages() -> [MessageProtocol]
}

protocol MessageProtocol {
    // текст сообщения
    var text: String? { get set }
    // прикрепленное изображение
    var image: Data? { get set }
    // прикрепленный аудиофайл
    var audio: Data? { get set }
    // прикрепленный видеофайл
    var video: Data? { get set }
    // дата отправки
    var sendDate: Date { get set }
    // отправитель
    var senderID: UInt { get set }
}

struct Message: MessageProtocol {
    var text: String?
    var image: Data?
    var audio: Data?
    var video: Data?
    var sendDate: Date
    var senderID: UInt
}

protocol StatisticDelegate: AnyObject {
    func handle(message: MessageProtocol)
}

protocol MessengerProtocol {
    // массив всех сообщений
    var messages: [MessageProtocol] { get set }
    
    var dataSource: MessengerDataSourceProtocol? { get set }
    
    // делегат для ведения статистики
    var statisticDelegate: StatisticDelegate? { get set }
    
    // инициализатор
    init()
    
    // принять сообщение
    mutating func receive(message: MessageProtocol)
    
    // отправить сообщение
    mutating func send(message: MessageProtocol)
}

class Messenger: MessengerProtocol {
    weak var dataSource: MessengerDataSourceProtocol? {
        didSet {
            if let source = dataSource {
                messages = source.getMessages()
            }
        }
    }
    var messages: [MessageProtocol]
    weak var statisticDelegate: StatisticDelegate?
    
    required init() {
        messages = []
    }
    
    func receive(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
    }
    
    func send(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
    }
}

extension Messenger: StatisticDelegate {
    func handle(message: MessageProtocol) {
        print("Обработка сообщения от User #\(message.senderID) завершена")
    }
}

// Пример использования:
class TestDataSource: MessengerDataSourceProtocol {
    func getMessages() -> [MessageProtocol] {
        return [Message(text: "Как дела?", sendDate: Date(), senderID: 2)]
    }
}

let testDataSource = TestDataSource()
var messenger = Messenger()
//messenger.dataSource = testDataSource
//messenger.statisticDelegate = messenger
//
//let newMessage = Message(text: "Привет!", sendDate: Date(), senderID: 1)
//messenger.send(message: newMessage)
//
//print("Количество сообщений: \(messenger.messages.count)")
