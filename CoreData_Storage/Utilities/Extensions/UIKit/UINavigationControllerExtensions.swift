//
//
//
//  Created by Self on 11/16/17.
//  Copyright © 2017   All rights reserved.
//


import Foundation
import UIKit

// MARK: - Methods
public extension UINavigationController {
    
    func popToViewControllerWithHandler(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: true)
        CATransaction.commit()
    }
    
    func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
//    /// Pop ViewController with completion handler.
//    ///
//    /// - Parameter completion: optional completion handler (default is nil).
//    public func popViewController(_ completion: (() -> Void)? = nil) {
//        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        popViewController(animated: true)
//        CATransaction.commit()
//    }
//
//    /// Push ViewController with completion handler.
//    ///
//    /// - Parameters:
//    ///   - viewController: viewController to push.
//    ///   - completion: optional completion handler (default is nil).
//    public func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
//        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        pushViewController(viewController, animated: true)
//        CATransaction.commit()
//    }
    
    /// Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    public func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
    
    public func ConfiguredNavigationBar(isHidden:Bool,titleText:String?,viewController:UIViewController?,barColors:UIColor = UIColor.white,showShadowImage:Bool = false, shadowColor:String = "FFFFFF") {
        
        self.setNavigationBarHidden(isHidden, animated: true)
        viewController?.navigationItem.hidesBackButton = true
        let frame = CGRect(x: 0, y: 5, width: 200, height: 40)
        let tlabel = UILabel(frame: frame)
        tlabel.text = titleText
        tlabel.textColor = UIColor.black
        tlabel.font = UIFont.systemFont(ofSize: 17.0) // Make here your customfonts
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        viewController?.navigationItem.titleView = tlabel
        self.navigationBar.setColors(background: barColors, text: UIColor.hexString("131010"))
        if showShadowImage {
            self.navigationBar.shadowImage = #imageLiteral(resourceName: "nav_shadow_img")
        }
        else {
            self.navigationBar.shadowImage = UIImage()
        }
    }
    
    // Push View Controller from Bottom like present view controller
    public func pushViewControllerFromBottom(_ viewController: UIViewController, animation: Bool) {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(viewController, animated: animation)
    }
    
    // Push View Controller from Top like present view controller
    public func pushViewControllerFromTop(_ viewController: UIViewController, animation: Bool) {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(viewController, animated: animation)
    }
}
extension UINavigationController {
    /**
     It removes all view controllers from navigation controller then set the new root view controller and it pops.
     
     - parameter vc: root view controller to set a new
     */
    func initRootViewController(vc: UIViewController, transitionType type: CATransitionType = CATransitionType.fade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.viewControllers.removeAll()
        self.pushViewController(vc, animated: false)
        self.popToRootViewController(animated: false)
    }
    
    /**
     It adds the animation of navigation flow.
     
     - parameter type: kCATransitionType, it means style of animation
     - parameter duration: CFTimeInterval, duration of animation
     */
    private func addTransition(transitionType type: CATransitionType = CATransitionType.fade, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        self.view.layer.add(transition, forKey: nil)
    }
}
