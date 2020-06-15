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
    var menuVC: MenuViewController!
    var informationVC: InfoViewController?
    var contavtUsVc: ContactsViewController?
    
    var isShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configiureTabBarController()
        configureMenuController()
        gesturesRecognizer()
    }
    
    
    private func gesturesRecognizer(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            print("right")
            if !isShow {
                toggleMenu()
            }
            
        case UISwipeGestureRecognizer.Direction.left:
            print("left")
            if isShow {
                toggleMenu()
            }
        default:
            return
        }
    }
    // MARK: - configiureTabBarController
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
    
    // MARK: - configureMenuController
    func configureMenuController(){
        if menuVC == nil {
            menuVC = storyboard?.instantiateViewController(identifier: "MenuViewController") as? MenuViewController
            
            addChild(menuVC)
            view.insertSubview(menuVC.view, at: 0)
            menuVC.didMove(toParent: self)
            menuVC.delegate = self
        }
    }
    
    // MARK: - configureInformationViewController
    func configureInformationViewController() {
        
        if informationVC == nil {
            informationVC = storyboard?.instantiateViewController(identifier: "InformationVC") as? InfoViewController
            
            informationVC?.delegate = self
            
            guard let informationViewController = informationVC else { return }
            guard let informationView = informationVC?.view else { return }
            
            controller.addChild(informationViewController)
            controller.view.addSubview(informationView)
            informationViewController.didMove(toParent: controller)
            
        }
    }
    
    // MARK: - configureContactUsViewController
    func configureContactUsViewController() {
        
        if contavtUsVc == nil {
            contavtUsVc = storyboard?.instantiateViewController(identifier: "ContactUsVC") as? ContactsViewController
            
            contavtUsVc?.delegate = self
            
            guard let contactViewController = contavtUsVc else { return }
            guard let contactView = contavtUsVc?.view else { return }
            
            controller.addChild(contactViewController)
            controller.view.addSubview(contactView)
            contactViewController.didMove(toParent: controller)
            
        }
    }
    
    // MARK: - removeChild
    func removeChild(){
        if informationVC != nil {
            informationVC?.willMove(toParent: nil)
            informationVC?.view.removeFromSuperview()
            informationVC?.removeFromParent()
            informationVC = nil
        }
        if contavtUsVc != nil {
            contavtUsVc?.willMove(toParent: nil)
            contavtUsVc?.view.removeFromSuperview()
            contavtUsVc?.removeFromParent()
            contavtUsVc = nil
        }
        
    }
}

// MARK: - MenuDelegate
extension ContainerViewController: MenuDelegate {
    func menuPressed(menu: MenuList) {
        switch menu {
        case MenuList.statistics:
            removeChild()
            toggleMenu()
            
        case MenuList.information:
            removeChild()
            configureInformationViewController()
            toggleMenu()
            
        default:
            removeChild()
            configureContactUsViewController()
            toggleMenu()
        }
    }
    
    func toggleMenu() {
       
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
