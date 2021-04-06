import UIKit
import ThemeKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Theme.updateNavigationBarTheme()

        App.shared.pinKit.didFinishLaunching()

        window = ThemeWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        window?.backgroundColor = .white
        window?.rootViewController = MainController()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        App.shared.pinKit.willEnterForeground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
