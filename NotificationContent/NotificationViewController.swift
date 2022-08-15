//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by sun on 15/08/2022.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import MobioSDKSwift

class NotificationViewController: MobioNotificationContentExtension {

    @IBOutlet var label: UILabel?
    let center = UNUserNotificationCenter.current()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        registerNotificationCategories()
        
    }
    
    override func didReceive(_ notification: UNNotification) {
        super.didReceive(notification)
    }

    func registerNotificationCategories() {
        let moreAction = UNNotificationAction(identifier: "One", title: "One", options: [.foreground])
        let shareAction = UNNotificationAction(identifier: "Two", title: "Two", options: [.foreground])
        let videoCategory = UNNotificationCategory(identifier: "myNotificationCategory", actions: [moreAction, shareAction], intentIdentifiers: [])
        center.setNotificationCategories([videoCategory])
    }
}
