import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var appCoordinator: AppCoordinator?
  lazy var baseNavigation = UINavigationController()
  lazy var baseNavigator: Navigatable = BaseNavigator(navigationController: baseNavigation)

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    appCoordinator = AppCoordinator(window: window, navigator: baseNavigator, dependencyProvider: ApplicationFactory())
    appCoordinator?.start()
    return true
  }
}

