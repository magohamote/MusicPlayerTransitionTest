//
//  ViewController.swift
//  MusicPlayerTransition
//
//  Created by xxxAIRINxxx on 2015/08/27.
//  Copyright (c) 2015 xxxAIRINxxx. All rights reserved.
//

import UIKit
import ARNTransitionAnimator

final class ViewController: UIViewController {
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var tabBar : UITabBar!
    @IBOutlet weak var miniPlayerView : LineView!
    @IBOutlet weak var miniPlayerButton : UIButton!
    
    private var animator : ARNTransitionAnimator!
    private var modalVC : ModalViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        miniPlayerView.backgroundColor = UIColor.clearColor()
        
        let contactItem = tabBar.items![0] as UITabBarItem
        contactItem.image = UIImage(named: "contact")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let tipsItem = tabBar.items![1] as UITabBarItem
        tipsItem.image = UIImage(named: "tips")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let docItem = tabBar.items![2] as UITabBarItem
        docItem.image = UIImage(named: "documents")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let galleryItem = tabBar.items![3] as UITabBarItem
        galleryItem.image = UIImage(named: "gallery")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        contactItem.imageInsets.bottom = -7
        contactItem.imageInsets.top = -7
        contactItem.imageInsets.left = -7
        contactItem.imageInsets.right = -7
        
        tipsItem.imageInsets.bottom = -7
        tipsItem.imageInsets.top = -7
        tipsItem.imageInsets.left = -7
        tipsItem.imageInsets.right = -7
        
        docItem.imageInsets.bottom = -7
        docItem.imageInsets.top = -7
        docItem.imageInsets.left = -7
        docItem.imageInsets.right = -7
        
        galleryItem.imageInsets.bottom = -7
        galleryItem.imageInsets.top = -7
        galleryItem.imageInsets.left = -7
        galleryItem .imageInsets.right = -7
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.modalVC = storyboard.instantiateViewControllerWithIdentifier("ModalViewController") as? ModalViewController
        self.modalVC.modalPresentationStyle = .OverFullScreen
        self.modalVC.tapCloseButtonActionHandler = { [unowned self] in
            self.animator.interactiveType = .None
        }
        
        let color = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.3)
        self.miniPlayerButton.setBackgroundImage(self.generateImageWithColor(color), forState: .Highlighted)
        
        self.setupAnimator()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController viewWillAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController viewWillDisappear")
    }
    
    func setupAnimator() {
        self.animator = ARNTransitionAnimator(operationType: .Present, fromVC: self, toVC: self.modalVC)
        self.animator.usingSpringWithDamping = 0.8
        self.animator.gestureTargetView = self.miniPlayerView
        self.animator.interactiveType = .Present
        
        // Present
        
        self.animator.presentationBeforeHandler = { [unowned self] containerView, transitionContext in
            print("start presentation")
            self.beginAppearanceTransition(false, animated: false)
            
            self.animator.direction = .Left
            
            self.modalVC.view.frame.origin.y = self.containerView.frame.width
            self.view.insertSubview(self.modalVC.view, belowSubview: self.tabBar)
            
            self.view.layoutIfNeeded()
            self.modalVC.view.layoutIfNeeded()
            
            // miniPlayerView
            // for Y axe
//            let startOriginY = self.miniPlayerView.frame.origin.y
//            let endOriginY = -self.miniPlayerView.frame.size.height
//            let diff = -endOriginY + startOriginY

            // for X axe
            let startOriginX = self.miniPlayerView.frame.origin.x
            let endOriginX = -self.miniPlayerView.frame.size.width
            let diffX = -endOriginX + startOriginX
            
            // tabBar
            let tabStartOriginY = self.tabBar.frame.origin.y
            let tabEndOriginY = containerView.frame.size.height
            let tabDiff = tabEndOriginY - tabStartOriginY
            
            self.animator.presentationCancelAnimationHandler = { containerView in
                self.miniPlayerView.frame.origin.x = startOriginX
//                self.miniPlayerView.frame.origin.y = startOriginY
                self.modalVC.view.frame.origin.x = self.miniPlayerView.frame.origin.x + self.miniPlayerView.frame.size.width
                self.modalVC.view.frame.origin.y = 0
                self.tabBar.frame.origin.y = tabStartOriginY
                self.containerView.alpha = 1.0
                self.tabBar.alpha = 1.0
                self.miniPlayerView.alpha = 1.0
                for subview in self.miniPlayerView.subviews {
                    subview.alpha = 1.0
                }
            }
            
            self.animator.presentationAnimationHandler = { [unowned self] containerView, percentComplete in
                let _percentComplete = percentComplete >= 0 ? percentComplete : 0
                self.miniPlayerView.frame.origin.x = startOriginX - (diffX * _percentComplete)
//                self.miniPlayerView.frame.origin.y = startOriginY - (diff * _percentComplete)
                if self.miniPlayerView.frame.origin.x < endOriginX {
                    self.miniPlayerView.frame.origin.x = endOriginX
                }
//                if self.miniPlayerView.frame.origin.y < endOriginY {
//                    self.miniPlayerView.frame.origin.y = endOriginY
//                }
                self.modalVC.view.frame.origin.x = self.miniPlayerView.frame.origin.x + self.miniPlayerView.frame.size.width
                self.modalVC.view.frame.origin.y = 0
                self.tabBar.frame.origin.y = tabStartOriginY + (tabDiff * _percentComplete)
                if self.tabBar.frame.origin.y > tabEndOriginY {
                    self.tabBar.frame.origin.y = tabEndOriginY
                }
                
                let alpha = 1.0 - (1.0 * _percentComplete)
                self.containerView.alpha = alpha + 0.5
                self.tabBar.alpha = alpha
                for subview in self.miniPlayerView.subviews {
                    subview.alpha = alpha
                }
            }
            
            self.animator.presentationCompletionHandler = { containerView, completeTransition in
                self.endAppearanceTransition()
                
                if completeTransition {
                    self.miniPlayerView.alpha = 0.0
                    self.modalVC.view.removeFromSuperview()
                    containerView.addSubview(self.modalVC.view)
                    self.animator.interactiveType = .Dismiss
                    self.animator.gestureTargetView = self.modalVC.view
                    self.animator.direction = .Right
                } else {
                    self.beginAppearanceTransition(true, animated: false)
                    self.endAppearanceTransition()
                }
            }
        }
        
        // Dismiss
        
        self.animator.dismissalBeforeHandler = { [unowned self] containerView, transitionContext in
            print("start dismissal")
            self.beginAppearanceTransition(true, animated: false)
            
            self.view.insertSubview(self.modalVC.view, belowSubview: self.tabBar)
            
            self.view.layoutIfNeeded()
            self.modalVC.view.layoutIfNeeded()
            
            // miniPlayerView
            let startOriginX = 0 - self.miniPlayerView.bounds.size.width
            let endOriginX = self.containerView.bounds.size.width - self.miniPlayerView.frame.size.width
            let diffX = -startOriginX + endOriginX
            
//            let startOriginY = 0 - self.miniPlayerView.bounds.size.height
//            let endOriginY = self.containerView.bounds.size.height - self.miniPlayerView.frame.size.height
//            let diff = -startOriginY + endOriginY
            // tabBar
            let tabStartOriginY = containerView.bounds.size.height
            let tabEndOriginY = containerView.bounds.size.height - self.tabBar.bounds.size.height
            let tabDiff = tabStartOriginY - tabEndOriginY
            
            self.tabBar.frame.origin.y = containerView.bounds.size.height
            self.containerView.alpha = 0.5
            
            self.animator.dismissalCancelAnimationHandler = { containerView in
                self.miniPlayerView.frame.origin.x = startOriginX
//                self.miniPlayerView.frame.origin.y = startOriginY
                self.modalVC.view.frame.origin.x = self.miniPlayerView.frame.origin.x + self.miniPlayerView.frame.size.width
                self.modalVC.view.frame.origin.y = 0
                self.tabBar.frame.origin.y = tabStartOriginY
                self.containerView.alpha = 0.5
                self.tabBar.alpha = 0.0
                self.miniPlayerView.alpha = 0.0
                for subview in self.miniPlayerView.subviews {
                    subview.alpha = 0.0
                }
            }
            
            self.animator.dismissalAnimationHandler = { containerView, percentComplete in
                let _percentComplete = percentComplete >= -0.05 ? percentComplete : -0.05
                self.miniPlayerView.frame.origin.x = startOriginX + (diffX * _percentComplete)
//                self.miniPlayerView.frame.origin.y = startOriginY + (diff * _percentComplete)
                self.modalVC.view.frame.origin.x = self.miniPlayerView.frame.origin.x + self.miniPlayerView.frame.size.width
                self.modalVC.view.frame.origin.y = 0
                self.tabBar.frame.origin.y = tabStartOriginY - (tabDiff *  _percentComplete)
                
                let alpha = 1.0 * _percentComplete
                self.containerView.alpha = alpha + 0.5
                self.tabBar.alpha = alpha
                self.miniPlayerView.alpha = 1.0
                for subview in self.miniPlayerView.subviews {
                    subview.alpha = alpha
                }
            }
            
            self.animator.dismissalCompletionHandler = { containerView, completeTransition in
                self.endAppearanceTransition()
                
                if completeTransition {
                    self.modalVC.view.removeFromSuperview()
                    self.animator.gestureTargetView = self.miniPlayerView
                    self.animator.interactiveType = .Present
                } else {
                    self.modalVC.view.removeFromSuperview()
                    containerView.addSubview(self.modalVC.view)
                    self.beginAppearanceTransition(false, animated: false)
                    self.endAppearanceTransition()
                }
            }
        }
        
        self.modalVC.transitioningDelegate = self.animator
    }
    
    @IBAction func tapMiniPlayerButton() {
        self.animator.interactiveType = .None
        self.presentViewController(self.modalVC, animated: true, completion: nil)
    }
    
    private func generateImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

