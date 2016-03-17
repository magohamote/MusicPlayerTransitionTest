//
//  ModalViewController.swift
//  MusicPlayerTransition
//
//  Created by xxxAIRINxxx on 2015/02/25.
//  Copyright (c) 2015 xxxAIRINxxx. All rights reserved.
//

import UIKit

final class ModalViewController: UIViewController {
    
    var tapCloseButtonActionHandler : (Void -> Void)?
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.sharedApplication().statusBarStyle = .Default
        
        imageView = UIImageView(image: UIImage(named: "agenda_big"))
        imageView.contentMode = .ScaleAspectFill
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64))
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize.width = self.view.frame.width
        scrollView.contentSize.height = imageView.frame.height
        
        scrollView.addSubview(imageView)
        self.view.addSubview(scrollView)
    }
    
    @IBAction func tapCloseButton() {
        self.tapCloseButtonActionHandler?()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("ModalViewController viewWillAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        print("ModalViewController viewWillDisappear")
    }
}
