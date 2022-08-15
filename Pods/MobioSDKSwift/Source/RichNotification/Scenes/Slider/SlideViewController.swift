//
//  SlideViewController.swift
//  TestNotifyContent
//
//  Created by Sun on 04/08/2022.
//

import UIKit
import UserNotificationsUI

 class SlideViewController: BaseNotificationContentViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let timer = Timer()
    var currentIndex = 0
    var imageDataDictionary = [String: UIImage]()
    let group = DispatchGroup()
    let imageStringArray = [
        "https://vcdn1-dulich.vnecdn.net/2021/07/16/8-1626444967.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=GfgGn4dNuKZexy1BGkAUNA",
        "https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/5/26/913299/Ngan-Ha25.jpg",
        "https://d1hjkbq40fs2x4.cloudfront.net/2017-08-21/files/landscape-photography_1645-t.jpg"
    ]
    let center = UNUserNotificationCenter.current()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        configureUserNotificationsCenter()
    }

    func setupView() {
        imageView.clipsToBounds = true
    }
    
    func setupData() {
        downloadAllImage()
        group.notify(queue: .main) {
            self.setupTimer()
        }
    }
    
    func setupTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(downloadListImage), userInfo: nil, repeats: true)
    }
    
    @objc func downloadListImage() {
        currentIndex += 1
        let imageString = imageStringArray[currentIndex % 3]
        if let image = imageDataDictionary[imageString] {
            imageView.image = image
        }
    }
    
    func downloadAllImage() {
        imageStringArray.forEach { urlString in
            downloadImage(from: urlString)
        }
    }
    
    func downloadImage(from URLString: String) {
        group.enter()
        guard let url = URL(string: URLString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)
                self.imageDataDictionary[URLString] = image
                self.group.leave()
            }
        }.resume()
    }
    
}

extension SlideViewController {
    
    enum NotificationActionIdentifier: String {
        case nextAction
        case backAction
        case closeAction
    }
    
    override func handleAction() -> UNNotificationContentExtensionResponseOption {
        view.backgroundColor = .red
        return .doNotDismiss
    }

    override func configureUserNotificationsCenter() {
        let nextAction = UNNotificationAction(identifier: NotificationActionIdentifier.nextAction.rawValue, title: "Next", options: [])
        let backAction = UNNotificationAction(identifier: NotificationActionIdentifier.backAction.rawValue, title: "Back", options: [])
        let closeAction = UNNotificationAction(identifier: NotificationActionIdentifier.closeAction.rawValue, title: "Close", options: [.destructive])
        let tutorialCategory = UNNotificationCategory(identifier: "myNotificationCategory",
                                                      actions: [nextAction, backAction, closeAction],
                                                      intentIdentifiers: [],
                                                      options: [])
        center.setNotificationCategories([tutorialCategory])
    }
}
