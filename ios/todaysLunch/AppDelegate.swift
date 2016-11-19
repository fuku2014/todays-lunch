import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let viewController: MainViewController = MainViewController()
        navigationController               = UINavigationController(rootViewController: viewController)
        self.window                        = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController    = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}

