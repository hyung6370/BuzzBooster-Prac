//
//  AppDelegate.swift
//  BuzzBooster-Prac
//
//  Created by Hyungjun KIM on 7/8/24.
//

import UIKit
import BuzzBoosterSDK
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    static var APP_KEY: String = "279753136766115"
    static var USER_ID: String = NSUUID().uuidString

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        
        let config = BSTConfig { builder in
            builder.appKey = AppDelegate.APP_KEY
        }
        BuzzBooster.initialize(with: config)
        BuzzBooster.optInMarketingCampaignDelegate = self
        BuzzBooster.addUserEventDelegate(self)
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        BuzzBooster.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        BuzzBooster.setDeviceToken(deviceToken)
    }
}

extension AppDelegate: BSTOptInMarketingCampaignDelegate {
    func onMoveButtonTapped(in viewController: UIViewController) {
        let yourOptInMarketingVC = OptInMarketingViewController()
        viewController.present(yourOptInMarketingVC, animated: true)
    }
}

extension AppDelegate: BSTUserEventDelegate {
    func userEventDidOccur(_ userEvent: BSTUserEvent) {
        print("userEventDidOccur: \(userEvent.name) \(String(describing: userEvent.values))")
    }
}
