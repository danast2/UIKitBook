import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // Создаём контроллеры
        let firstVC = ViewController()
        firstVC.title = "First"
        firstVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "house"), tag: 0)
        
        let secondVC = SecondViewController()
        secondVC.title = "Second"
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "gear"), tag: 1)

        // Добавляем навигационные контроллеры
        let firstNavController = UINavigationController(rootViewController: firstVC)
        let secondNavController = UINavigationController(rootViewController: secondVC)

        // Создаём UITabBarController
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([firstNavController, secondNavController], animated: true)

        // Устанавливаем корневой контроллер
        window.rootViewController = tabBarVC
        window.backgroundColor = .white
        UITabBar.appearance().isTranslucent = false

        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

