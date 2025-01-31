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
        
        //добавления уведомления
        //..................................
    }

    
    func removeSubscription(at index: Int) -> Void {
        let subscription = subscriptions.remove(at: index)
        saveSubscriptions()
        
        //удаление уведомления
        //..................................
    }
    
    //обновление подписки
    func updateSubscription(_ updatedSubscription: Subscription) -> Void {
        if let index = subscriptions.firstIndex(where: {$0.id == updatedSubscription.id}){
            subscriptions[index] = updatedSubscription
            saveSubscriptions()
        }
    }
    
    //удаление подписки по id
    func removeSubscriptionByID(_ id: UUID) -> Void {
        subscriptions.removeAll {$0.id == id}
        saveSubscriptions()
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
