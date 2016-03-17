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
    
    var navBar = UINavigationBar()
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var bottomButtonsBar : UIView!
    @IBOutlet weak var agendaView : LineView!
    @IBOutlet weak var agendaButton : UIButton!
    
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet weak var docButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    
    @IBOutlet weak var notificationView: UIImageView!
    
    private var animator : ARNTransitionAnimator!
    private var modalVC : ModalViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        setNavBarToTheView()
        
        agendaView.backgroundColor = UIColor.clearColor()
        agendaButton.backgroundColor = UIColor.clearColor()
        agendaButton.setImage(UIImage(named: "agenda"), forState: .Normal)
        agendaButton.setImage(UIImage(named: "agenda"), forState: .Highlighted)
        
        notificationView.image = UIImage(named: "notification")
        
        bottomButtonsBar.backgroundColor = UIColor.clearColor()
        let backgroundLayer = Colors().gl
        backgroundLayer.frame = bottomButtonsBar.bounds
        bottomButtonsBar.layer.insertSublayer(backgroundLayer, atIndex: 0)
        
        contactButton.addTarget(self, action: "presentTmp:", forControlEvents: .TouchUpInside)
        tipsButton.addTarget(self, action: "presentTmp:", forControlEvents: .TouchUpInside)
        docButton.addTarget(self, action: "presentTmp:", forControlEvents: .TouchUpInside)
        galleryButton.addTarget(self, action: "presentTmp:", forControlEvents: .TouchUpInside)
        
        setButton(agendaButton)
        setButton(contactButton)
        setButton(tipsButton)
        setButton(docButton)
        setButton(galleryButton)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.modalVC = storyboard.instantiateViewControllerWithIdentifier("ModalViewController") as? ModalViewController
        self.modalVC.modalPresentationStyle = .OverFullScreen
        self.modalVC.tapCloseButtonActionHandler = { [unowned self] in
            self.animator.interactiveType = .None
        }
        
        let color = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.3)
        self.agendaButton.setBackgroundImage(self.generateImageWithColor(color), forState: .Highlighted)
        
        self.setupAnimator()
        
    }
    
    
    func presentTmp(sender: UIButton!) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("tmpViewController") as! TmpViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func setNavBarToTheView() {
        navBar.frame = CGRectMake(0, 0, self.view.frame.width, 98)  // Here you can set you Width and Height for your navBar
        navBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navBar.translucent = true
        navBar.shadowImage = UIImage()
        
        let title = UILabel(frame: CGRect(x: 127, y: 38, width: 126, height: 24))
        title.text = "Business Trip"
        title.font = UIFont(name: "Roboto-Regular", size: 21)
        title.textColor = myColor.planifyGrey()
        
        let subtitle = UILabel(frame: CGRect(x: 152, y: 68, width: 90, height: 14))
        subtitle.text = "New-York City"
        subtitle.font = UIFont(name: "Roboto-Regular", size: 14)
        subtitle.textColor = myColor.planifyGrey()
        
        let pinIcon = UIImage(named: "pinIcon")
        let pinIconView = UIImageView(frame: CGRect(x: 137, y: 69, width: 10, height: 14))
        pinIconView.image = pinIcon
        
        let closeIcon = UIImage(named: "closeIcon")
        let closeIconView = UIImageView(frame: CGRect(x: 45, y: 45, width: 12, height: 12))
        closeIconView.image = closeIcon
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visualEffectView.frame = self.navBar.bounds
        navBar.addSubview(visualEffectView)
        navBar.addSubview(title)
        navBar.addSubview(pinIconView)
        navBar.addSubview(closeIconView)
        navBar.addSubview(subtitle)
        
        self.view.addSubview(navBar)
    }
    
    func setButton(button: UIButton) {
        button.contentHorizontalAlignment = .Fill
        button.contentVerticalAlignment = .Fill
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
        self.animator.gestureTargetView = self.agendaView
        self.animator.interactiveType = .Present
        
        // Present
        self.animator.presentationBeforeHandler = { [unowned self] containerView, transitionContext in
            print("start presentation")
            self.beginAppearanceTransition(false, animated: false)
            
            self.animator.direction = .Left
            
            self.modalVC.view.frame.origin.y = 0
            self.view.insertSubview(self.modalVC.view, aboveSubview : self.navBar)
            
            self.view.layoutIfNeeded()
            self.modalVC.view.layoutIfNeeded()

            // for X axe
            let startOriginX = self.agendaView.frame.origin.x
            let endOriginX = -self.agendaView.frame.size.width
            let diffX = -endOriginX + startOriginX
            
            // tabBar
            let tabStartOriginY = self.bottomButtonsBar.frame.origin.y
            let tabEndOriginY = containerView.frame.size.height
            let tabDiff = tabEndOriginY - tabStartOriginY
            
            // navBar
            let navBarStartOriginY = self.navBar.frame.origin.y
            let navBarEndOriginY = -self.navBar.frame.height
            let navBarDiff = navBarEndOriginY - navBarStartOriginY
            
            self.animator.presentationCancelAnimationHandler = { containerView in
                self.agendaView.frame.origin.x = startOriginX
                self.modalVC.view.frame.origin.x = self.agendaView.frame.origin.x + self.agendaView.frame.size.width
                self.modalVC.view.frame.origin.y = 0
                self.bottomButtonsBar.frame.origin.y = tabStartOriginY
                self.navBar.frame.origin.y = navBarStartOriginY
                self.containerView.alpha = 1.0
                self.bottomButtonsBar.alpha = 1.0
                self.navBar.alpha = 1.0
                self.agendaView.alpha = 1.0
                self.notificationView.alpha = 1.0
                for subview in self.agendaView.subviews {
                    subview.alpha = 1.0
                }
            }
            
            self.animator.presentationAnimationHandler = { [unowned self] containerView, percentComplete in
                let _percentComplete = percentComplete >= 0 ? percentComplete : 0
                self.agendaView.frame.origin.x = startOriginX - (diffX * _percentComplete)
                
                if self.agendaView.frame.origin.x < endOriginX {
                    self.agendaView.frame.origin.x = endOriginX
                }

                self.modalVC.view.frame.origin.x = self.agendaView.frame.origin.x + self.agendaView.frame.size.width
                self.modalVC.view.frame.origin.y = 0
                self.bottomButtonsBar.frame.origin.y = tabStartOriginY + (tabDiff * _percentComplete)
                if self.bottomButtonsBar.frame.origin.y > tabEndOriginY {
                    self.bottomButtonsBar.frame.origin.y = tabEndOriginY
                }
                
                self.navBar.frame.origin.y = navBarStartOriginY + (navBarDiff * _percentComplete)
                if self.navBar.frame.origin.y < navBarEndOriginY {
                    self.navBar.frame.origin.y = navBarEndOriginY
                }
                
                let alpha = 1.0 - (1.0 * _percentComplete)
                self.containerView.alpha = alpha + 0.5
                self.bottomButtonsBar.alpha = alpha
                self.navBar.alpha = alpha
                self.notificationView.alpha = alpha
               
                for subview in self.agendaView.subviews {
                    subview.alpha = alpha
                }
            }
            
            self.animator.presentationCompletionHandler = { containerView, completeTransition in
                self.endAppearanceTransition()
                
                if completeTransition {
                    self.agendaView.alpha = 0.0
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
            
            self.view.insertSubview(self.modalVC.view, aboveSubview: self.navBar)
            
            self.view.layoutIfNeeded()
            self.modalVC.view.layoutIfNeeded()
            
            // miniPlayerView
            let startOriginX = 0 - self.agendaView.bounds.size.width
            let endOriginX = self.containerView.bounds.size.width - self.agendaView.frame.size.width
            let diffX = -startOriginX + endOriginX
            
            // tabBar
            let tabStartOriginY = containerView.bounds.size.height
            let tabEndOriginY = containerView.bounds.size.height - self.bottomButtonsBar.bounds.size.height
            let tabDiff = tabStartOriginY - tabEndOriginY
            
            // navBar
            let navStartOriginY = -self.navBar.frame.height
            let navEndOriginY:CGFloat = 0
            let navDiff = navStartOriginY - navEndOriginY
            
            self.bottomButtonsBar.frame.origin.y = containerView.bounds.size.height
            self.navBar.frame.origin.y = -self.navBar.frame.height
            self.containerView.alpha = 0.5
            
            self.animator.dismissalCancelAnimationHandler = { containerView in
                self.agendaView.frame.origin.x = startOriginX
                self.modalVC.view.frame.origin.x = self.agendaView.frame.origin.x + self.agendaView.frame.size.width
                self.modalVC.view.frame.origin.y = 0
                self.bottomButtonsBar.frame.origin.y = tabStartOriginY
                self.navBar.frame.origin.y = navStartOriginY
                self.containerView.alpha = 0.5
                self.bottomButtonsBar.alpha = 0.0
                self.navBar.alpha = 0.0
                self.agendaView.alpha = 0.0
                self.notificationView.alpha = 0.0
                for subview in self.agendaView.subviews {
                    subview.alpha = 0.0
                }
            }
            
            self.animator.dismissalAnimationHandler = { containerView, percentComplete in
                let _percentComplete = percentComplete >= -0.05 ? percentComplete : -0.05
                self.agendaView.frame.origin.x = startOriginX + (diffX * _percentComplete)
                self.modalVC.view.frame.origin.x = self.agendaView.frame.origin.x + self.agendaView.frame.size.width
                self.modalVC.view.frame.origin.y = 0
                self.bottomButtonsBar.frame.origin.y = tabStartOriginY - (tabDiff * _percentComplete)
                self.navBar.frame.origin.y = navStartOriginY - (navDiff * _percentComplete)
                
                let alpha = 1.0 * _percentComplete
                self.containerView.alpha = alpha + 0.5
                self.bottomButtonsBar.alpha = alpha
                self.navBar.alpha = alpha
                self.agendaView.alpha = alpha
                self.notificationView.alpha = alpha
                for subview in self.agendaView.subviews {
                    subview.alpha = alpha
                }
            }
            
            self.animator.dismissalCompletionHandler = { containerView, completeTransition in
                self.endAppearanceTransition()
                
                if completeTransition {
                    self.modalVC.view.removeFromSuperview()
                    self.animator.gestureTargetView = self.agendaView
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

