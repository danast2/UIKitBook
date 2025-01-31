import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager() //Singleton
    
    private init(){} // закрытый инициализатор
    
    //MARK: - Запрос разрешения на уведомления
    func requestAuthorization() -> Void {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error{
                print("Ошибка при запросе разрешения \(error.localizedDescription)")
            } else if granted {
                print("Разрешение на уведомления получено.")
            } else {
                print("Разрешение на уведомления не получено.")
            }
        }
    }
    
    //MARK: - Создание уведомления о подписке
    func scheduleNotification(for subscription: Subscription) -> Void {
        let content = UNMutableNotificationContent()
        content.title = "Списание подписки"
        content.body = "Скоро будет списание за \(subscription.name) на сумму \(subscription.price) ₽"
        content.sound = UNNotificationSound.default
        
        //Вычисляем дату уведомления (например, за 1 день до списания) (можно добавить возможность выбора, за сколько дней до списания прислать уведомление)
        let triggerDate = Calendar.current.date(byAdding: .day, value: -1, to: subscription.renewalDate) ?? subscription.renewalDate
        let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: subscription.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при создании уведомления: \(error.localizedDescription)")
            } else {
                print("Уведомление для \(subscription.name) запланировано на \(triggerDate)")
            }
        }
    }
    
    //MARK: - Удаление уведомления
    func removeNotification(for id: UUID) -> Void {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        print("Уведомление для подписки \(id) удалено")
    }
    
    // MARK: - Обновление уведомления (удалить + создать новое)
        func updateNotification(for subscription: Subscription) {
            removeNotification(for: subscription.id)
            scheduleNotification(for: subscription)
        }
}
