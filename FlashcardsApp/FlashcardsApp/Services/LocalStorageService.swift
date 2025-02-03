import Foundation
import UIKit

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
    
    // Сохранение изображения в файл и возврат пути
        func saveImage(_ image: UIImage) -> String? {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }
            let fileName = UUID().uuidString + ".jpg"
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

            do {
                try imageData.write(to: fileURL)
                return fileName
            } catch {
                print("Ошибка сохранения изображения: \(error)")
                return nil
            }
        }
    
    // Загрузка изображения по пути
        func loadImage(from path: String) -> UIImage? {
            let fileURL = getDocumentsDirectory().appendingPathComponent(path)
            guard let data = try? Data(contentsOf: fileURL) else { return nil }
            return UIImage(data: data)
        }
    
    static func loadImage(from path: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(path)
        if let imageData = try? Data(contentsOf: fileURL) {
            return UIImage(data: imageData)
        }
        return nil
    }


        // Удаление изображения
        func deleteImage(at path: String) {
            let fileURL = getDocumentsDirectory().appendingPathComponent(path)
            try? FileManager.default.removeItem(at: fileURL)
        }

        // Получение пути к каталогу документов
        private func getDocumentsDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    
        private static func getDocumentsDirectory() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }

}
