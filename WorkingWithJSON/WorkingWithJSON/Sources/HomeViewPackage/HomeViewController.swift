//
//  HomeViewController.swift
//  Tutor
//
//  Created by Tuyen on 2/22/18.
//  Copyright © 2018 Tuyen. All rights reserved.
//

import UIKit

let colorSelectMenu = UIColor.blue
class HomeViewController: BaseViewController {
    @IBOutlet weak var viewMenu: UIView!

    @IBOutlet weak var topicButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet var imageMenu: [UIImageView]!
    @IBOutlet var nameMenu: [UILabel]!

//    @IBOutlet weak var classView: UIView!
    
    private let listImage: [String] = ["1.circle.fill","2.circle.fill"]
    private let listImageOff: [String] = ["1.circle","2.circle"]
    
//    var socket = SocketService.shared.socket
    
    var numberNoti = 0
    
    var homePageViewController: HomePageViewController? {
        didSet {
            homePageViewController?.homeDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewPager()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotiNotificationChangeTabFirst(_:)),
                                                       name: EVENT_PUSH_FIRST_VC,
                                                       object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotiNotificationChangeTabSecond(_:)),
                                                       name: EVENT_PUSH_SECOND_VC,
                                                       object: nil)
    }
    
    @objc func handleNotiNotificationChangeTabFirst(_ notification: Notification) {
        self.homePageViewController?.scrollToViewController(index: 0)
    }
    
    @objc func handleNotiNotificationChangeTabSecond(_ notification: Notification) {
        self.homePageViewController?.scrollToViewController(index: 1)
    }
    
    
    func showController(controllerName: String, controller: UIViewController?)
    {
        let frame = containerView.frame
        controller!.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let navigationController = UINavigationController(rootViewController: controller!)
        navigationController.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        navigationController.isNavigationBarHidden = true
        self.addChild(navigationController)
        self.containerView.addSubview(navigationController.view)
    }
    
    
    func initViewPager()
    {
        let viewpager = HomePageViewController()
        self.homePageViewController = viewpager
        self.showController(controllerName: "HomePageViewController", controller: viewpager)
        
    }
    
    @IBAction func homeButtonDidTap(_ sender: UIButton) {
//        if sender.tag == 2 {
//            let noti = GeneralNotiViewController()
//            noti.content = "Tính năng đang trong giai đoạn phát triển, chúng tôi sẽ hoàn thiện trong thời gian sớm nhất"
//            noti.modalPresentationStyle = .overCurrentContext
//            Util.shared.returnHomeController()?.present(noti, animated: true, completion: nil)
//
//            //
//        }
//        else{
            self.homePageViewController?.scrollToViewController(index: sender.tag)
            UserDefaults.standard.set(sender.tag, forKey: "HomeViewController")
//        }
    }
}

extension HomeViewController: HomePageViewControllerDelegate {

    func homePageViewController(_ homePageViewController: HomePageViewController, didUpdatePageCount count: Int) {

    }

    func homePageViewController(_ homePageViewController: HomePageViewController, didUpdatePageIndex index: Int) {
        
        for item in self.nameMenu {
            if item.tag == index {
                item.textColor = UIColor.blue
            } else {
                item.textColor = .lightGray
            }
        }
        
        for item in self.imageMenu {
            if item.tag == index {
                item.image = UIImage(systemName: self.listImage[index])
            } else {
                item.image = UIImage(systemName: self.listImageOff[item.tag])
            }
        }
    }
}
