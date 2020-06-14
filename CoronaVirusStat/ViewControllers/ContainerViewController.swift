//
//  ContainerViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 14.06.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var controller: UITabBarController!
    var menuVC: UIViewController!
    var isShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configiureTabBarController()
        configureMenuController()
        
    }
    
    func configiureTabBarController(){
        let firstController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
        
        controller = firstController
        
        let navVC = controller.viewControllers?.first as! UINavigationController
        let briefVC = navVC.viewControllers.first as! BriefTableViewController
        briefVC.delegate = self
        
        addChild(controller)
        view.insertSubview(controller.view, at: 1)
        controller.didMove(toParent: self)
    }
    
    func configureMenuController(){
        if menuVC == nil {
            menuVC = storyboard?.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
            addChild(menuVC)
            view.insertSubview(menuVC.view, at: 0)
            menuVC.didMove(toParent: self)
        }
    }
}

extension ContainerViewController: MenuDelegate {
    func toggleMenu() {
        print("pressed")
        if isShow {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = 0
            }) { (_) in
                self.isShow.toggle()
            }
        } else {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = self.controller.view.frame.width - 140
            }) { (_) in
                self.isShow.toggle()
            }
        }
    }
}
