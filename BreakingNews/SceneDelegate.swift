//
//  SceneDelegate.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-11.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let langDeviceCode = Locale.current.languageCode ?? "en"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let newsViewController = NewsViewController()
        newsViewController.tabBarItem.title = "Swift NEWS".localizeString(string: langDeviceCode)
        newsViewController.tabBarItem.image = UIImage(systemName: "newspaper")
        let swiftNewsView = SwiftUINewsScreenView()
        let host = UIHostingController(rootView: swiftNewsView)
        let newsNavigationController = UINavigationController(rootViewController: newsViewController)
        host.tabBarItem.title = "SWIFT UI NEWS".localizeString(string: langDeviceCode)
        host.tabBarItem.image = UIImage(systemName: "swift")
        let tabBar = UITabBarController()
        tabBar.viewControllers = [newsNavigationController, host]
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

