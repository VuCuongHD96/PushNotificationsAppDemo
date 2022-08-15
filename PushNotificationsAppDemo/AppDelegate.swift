//
//  AppDelegate.swift
//  PushNotificationsAppDemo
//
//  Created by sun on 15/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let center = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configPushNotifications()
//        registerNotificationCategories()
        return true
    }
    
    func configPushNotifications() {
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("---- debug ----- granted = ", granted)
        }
    }
    
    func registerNotificationCategories() {
        let moreAction = UNNotificationAction(identifier: "more", title: "Watch More", options: [.foreground])
        let shareAction = UNNotificationAction(identifier: "share", title: "Share", options: [.foreground])
        let videoCategory = UNNotificationCategory(identifier: "myNotificationCategory", actions: [moreAction, shareAction], intentIdentifiers: [])
        center.setNotificationCategories([videoCategory])
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert])
    }
}
