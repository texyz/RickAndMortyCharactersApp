//
//  SceneDelegate.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Initialize the root view controller
        let initialViewController = CharactersTableViewController()
        initialViewController.viewModel = CharacterViewModel(apiService: APIService())

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: initialViewController)
        self.window = window
        window.makeKeyAndVisible()
    }
}
