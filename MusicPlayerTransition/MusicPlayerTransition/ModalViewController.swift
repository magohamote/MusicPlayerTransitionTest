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
    
    @IBOutlet weak var imageView: UIImageView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "screenshot")
        imageView.contentMode = .ScaleAspectFill
        
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor.blackColor()
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
        print("ModalViewController viewWillDisappear")
    }
}
