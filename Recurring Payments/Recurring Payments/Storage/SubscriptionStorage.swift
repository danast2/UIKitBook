import Foundation


class SubscriptionStorage {
    private let storageKey = "subscriptions"

    //сохранение подписок в user defaults (можно улучшить до Core Data)
    func save(_ subscriptions: [Subscription]){
        let encoder = JSONEncoder()
        
        if let encoderData = try? encoder.encode(subscriptions){
            UserDefaults.standard.set(encoderData, forKey: storageKey)
        }
    }
    
    //загрузка подписок
    func load() -> [Subscription] {
        let decoder = JSONDecoder()
        
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let subscriptions = try? decoder.decode([Subscription].self, from: savedData){
            return subscriptions
        }
        return [] // если ничего нет, то возвращаем пустой массив
    }
    
    //очистка всех подписок (не обязательно)
    func clear() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}
