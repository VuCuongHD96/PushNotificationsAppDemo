//
//  BaseNotificationContentViewController.swift
//  MobioSDKSwift
//
//  Created by Sun on 15/08/2022.
//

import UIKit
import UserNotificationsUI

protocol NotificationContentViewControllerType {
    
    func handleAction() -> UNNotificationContentExtensionResponseOption
    func configureUserNotificationsCenter()
}

class BaseNotificationContentViewController: UIViewController, XibSceneBased {
    
    @objc dynamic func handleAction() -> UNNotificationContentExtensionResponseOption {
        return .doNotDismiss
    }
    
    @objc dynamic func configureUserNotificationsCenter() {
    }
}
