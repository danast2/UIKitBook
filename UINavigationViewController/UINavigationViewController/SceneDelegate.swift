import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Убедимся, что текущая сцена — это UIWindowScene
        guard let windowScene = scene as? UIWindowScene else { return }
        
        // Создаем UIWindow с привязкой к текущему сценарию
        let window = UIWindow(windowScene: windowScene)
        
        // Устанавливаем rootViewController
        let viewController = ViewController() // Ваш главный ViewController
        let navController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navController
        
        // Настраиваем окно
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        
        // Сохраняем ссылку на окно
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Вызывается, когда сцена отключается системой.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Вызывается, когда сцена переходит из неактивного состояния в активное.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Вызывается, когда сцена переходит из активного состояния в неактивное.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Вызывается, когда сцена переходит из фона на передний план.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Вызывается, когда сцена переходит из переднего плана в фон.
    }
}

