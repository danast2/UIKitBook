import Foundation

class SubscriptionViewModel {
    
    //список подписок
    private(set) var subscriptions: [Subscription] = []
    
    //хранилище подписок
    private let storage = SubscriptionStorage()
    
    init() {
        loadSubscription()
    }
    
    func loadSubscription() -> Void {
        subscriptions = storage.load()
    }
    
    func saveSubscriptions() -> Void {
        storage.save(subscriptions)
    }
    
    func addSubscription(_ subscription: Subscription) {
        subscriptions.append(subscription)
        saveSubscriptions()
        
        //добавление уведомления
        NotificationManager.shared.scheduleNotification(for: subscription) //Запланировать уведомление
    }

    //тут происходит все равно удаление по id
    func removeSubscription(at index: Int) {
        let subscription = subscriptions[index]
        removeSubscriptionByID(subscription.id) //  Теперь вызываем удаление по `UUID`
    }

    
    //обновление подписки
    func updateSubscription(_ updatedSubscription: Subscription) -> Void {
        if let index = subscriptions.firstIndex(where: {$0.id == updatedSubscription.id}){
            subscriptions[index] = updatedSubscription
            saveSubscriptions()
            NotificationManager.shared.updateNotification(for: updatedSubscription) // Обновить уведомление
        }
    }
    
    //удаление подписки по id
    func removeSubscriptionByID(_ id: UUID) -> Void {
        subscriptions.removeAll {$0.id == id}
        saveSubscriptions()
        NotificationManager.shared.removeNotification(for: id) //удалить уведомление
    }
    
    //метод для изменения порядка подписок, нужен, так как private(set) var subscriptions
    func moveSubscription(from sourceIndex: Int, to destinationIndex: Int) -> Void {
        let movedSubscriptions = subscriptions.remove(at: sourceIndex)// Удаляем подписку из старого места
        subscriptions.insert(movedSubscriptions, at: destinationIndex) // Вставляем в новое место
        saveSubscriptions() //сохраняем порядок подписок
    }
    
    //подсчет стоимости подписок за месяц
    //можно добавить рассчет на год / пол месяца / неделю и тд
    func calculateMonthlyCost() -> Double {
        var totalCost: Double = 0
        
        for subscription in subscriptions {
            switch subscription.cycle {
            case .monthly:
                totalCost += subscription.price
            case .yearly:
                totalCost += subscription.price / 12
            case .weekly:
                totalCost += subscription.price * 4
            case .halfOfMonth:
                totalCost += subscription.price * 2
            case .halfOfYear:
                totalCost += subscription.price / 6
            }
        }
        return totalCost
    }
}
