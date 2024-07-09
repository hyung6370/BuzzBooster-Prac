//
//  Coordinator.swift
//  BuzzBooster-Prac
//
//  Created by Hyungjun KIM on 7/8/24.
//

import UIKit

class Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootVC = ViewController()
        let navigatinoRootVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navigatinoRootVC
        window.makeKeyAndVisible()
    }
}
