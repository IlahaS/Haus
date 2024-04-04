//
//  SceneDelegate.swift
//  Hous
//
//  Created by Ilahe Samedova on 12.01.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "loggedIn") {
            switchToTabViewController()
        } else {
            let firstController = FirstController()
            let navigationController = UINavigationController(rootViewController: firstController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
    func switchToTabViewController() {
        print("Switching to TabViewController")
        let tabViewController = TabViewController()
        window?.rootViewController = tabViewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        //(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

