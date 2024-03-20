
import UIKit

final class TabViewController: UITabBarController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        customizeTabBarAppearance()
    }
    
    
    private func setUpTabs(){
        let home = self.createNav(with: "Elanlar", and: UIImage(systemName: "house") ?? .mainScreenLogo, and: HomeController())
        let discover = self.createNav(with: "Kəşf et", and: UIImage(systemName: "play.rectangle") ?? .flag, and: DiscoverController())
        let profile = self.createNav(with: "Profil", and: UIImage(systemName: "person") ?? .flag, and: ProfileController())
        self.setViewControllers([home,discover,profile], animated: true)
    }
    
    private func createNav(with name: String, and image: UIImage, and vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = name
        nav.tabBarItem.image = image
        return nav
    }
    
    private func customizeTabBarAppearance() {        
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.tintColor], for: .selected)
        self.tabBar.tintColor = .mainBlueColor
        self.tabBar.backgroundColor = .white
    }
}
