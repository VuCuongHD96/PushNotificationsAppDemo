//
//  CountDownViewController.swift
//  MobioSDKSwift
//
//  Created by sun on 13/08/2022.
//

import UIKit
import UserNotificationsUI

class CountDownViewController: BaseNotificationContentViewController {

    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserNotificationsCenter()
    }
}

extension CountDownViewController {
    
    enum NotificationActionIdentifier: String {
        case buyAction
        case prepayAction
        case debitAction
    }
    
    override func handleAction() -> UNNotificationContentExtensionResponseOption {
        view.backgroundColor = .yellow
        return .doNotDismiss
    }
    
    override func configureUserNotificationsCenter() {
        let actionReadLater = UNNotificationAction(identifier: NotificationActionIdentifier.buyAction.rawValue, title: "Buy", options: [])
        let actionShowDetails = UNNotificationAction(identifier: NotificationActionIdentifier.prepayAction.rawValue, title: "Prepay", options: [])
        let actionUnsubscribe = UNNotificationAction(identifier: NotificationActionIdentifier.debitAction.rawValue, title: "Debit", options: [.destructive])
        let tutorialCategory = UNNotificationCategory(identifier: "myNotificationCategory",
                                                      actions: [actionReadLater, actionShowDetails, actionUnsubscribe],
                                                      intentIdentifiers: [],
                                                      options: [])
        center.setNotificationCategories([tutorialCategory])
    }
}
