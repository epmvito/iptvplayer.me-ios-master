import UIKit
import IQKeyboardManagerSwift
import Alamofire

// MARK: Global properties
//9876555
//2420581
//Sunduk.TV
var AlamofireSessionManager = Session()

var customAPI: String?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
   


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true
        UITabBar.appearance().tintColor = UIColor.pacificBlue
        
        let defaultConfiguration = URLSessionConfiguration.default
        defaultConfiguration.timeoutIntervalForRequest = 30
        defaultConfiguration.timeoutIntervalForResource = 30
        AlamofireSessionManager = Alamofire.Session(configuration: defaultConfiguration)
//        configureInitialViewController()
        deleteFilters()
        checkVersion()
        return true
    }
    
    func checkVersion(){
        VersionCheck.shared.isUpdateAvailable() { hasUpdates in
          print("is update available: \(hasUpdates)")
        }
    }
    
    private func deleteFilters() {
        UserDefaults.standard.removeObject(forKey: "Sorting")
        UserDefaults.standard.removeObject(forKey: "Types")
        UserDefaults.standard.removeObject(forKey: "Genres")
        UserDefaults.standard.removeObject(forKey: "Years")
        UserDefaults.standard.removeObject(forKey: "Rating Kinopoisk")
        UserDefaults.standard.removeObject(forKey: "Rating IMDB")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        checkVersion()
    }
    
    
//    private func configureInitialViewController() {
//        let initialViewController: UIViewController
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let navigationController = UINavigationController()
//
//        window = UIWindow()
//
//        if ProviderDataModel.getData() != nil {
//            let loginViewController = storyboard.instantiateViewController(withIdentifier: "signInScreen")
//            initialViewController = loginViewController
//        } else {
//            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainScreen")
//            initialViewController = mainViewController
//        }
//        navigationController.pushViewController(initialViewController, animated: false)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//    }

}

