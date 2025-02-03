
import Foundation

import Foundation

struct UnsplashImage: Decodable {
    struct URLS: Decodable {
        let regular: String
    }
    let urls: URLS
}

class UnsplashService {
    private var accessKey = "FSWsSgTcKIT1VeeO9TaAo_MCxTEjVa67iOPPNK1hsc0"
    private let baseURL = "https://api.unsplash.com/photos/random"
    
    func fetchImage(for query: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "\(baseURL)?query=\(query)&client_id=\(accessKey)") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Ошибка загрузки: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(UnsplashImage.self, from: data)
                completion(decodedResponse.urls.regular)
            } catch {
                print("Ошибка парсинга JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
