//
//  BackgroundViewController.swift
//  MusicPlayerTransition
//
//  Created by Coteries on 16/03/16.
//  Copyright © 2016 xxxAIRINxxx. All rights reserved.
//

import UIKit

class TmpViewController: UIViewController {

    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton(backButton)
        backButton.addTarget(self, action: "backButton:", forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setButton(button: UIButton) {
        button.contentHorizontalAlignment = .Fill
        button.contentVerticalAlignment = .Fill
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
