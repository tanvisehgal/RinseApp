import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // Creating UI Programmatically 
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("DEBUG: scenedelegate")
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        if AuthManager.shared.isSignedIn {
//        if false {
            // signed in UI - show tab bar view controller
            print("DEBUG: signed in")
            AuthManager.shared.setDefaults()
            window.rootViewController = TabBarViewController()
        }
        else {
            // sign in ui displayed if not signed in
            print("DEBUG: NOT signed in")
            let vc = SignInViewController()
            let navVC = UINavigationController(rootViewController: vc)
            window.rootViewController = navVC
        }

        window.makeKeyAndVisible()
        self.window = window
        print("DEBUG: scenedelegate end")
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

