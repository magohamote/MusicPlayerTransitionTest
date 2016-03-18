//
//  ModalViewController.swift
//  MusicPlayerTransition
//
//  Created by xxxAIRINxxx on 2015/02/25.
//  Copyright (c) 2015 xxxAIRINxxx. All rights reserved.
//

import UIKit

final class ModalViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
  var tapCloseButtonActionHandler : (Void -> Void)?
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var navBar: UINavigationBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    UIApplication.sharedApplication().statusBarStyle = .Default
    configureTableView()
    configureNavBar() 
  }
  
  func configureTableView() {
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 130.0
  }
  
  func configureNavBar() {
    navBar.barTintColor = UIColor.whiteColor()
    navBar.titleTextAttributes = [
      NSForegroundColorAttributeName : UIColor.blackColor(),
      NSFontAttributeName : UIFont(name: "Roboto-Regular", size: 16)!
    ]
  }
  
  @IBAction func tapCloseButton(sender: UIBarButtonItem) {
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
  
  // MARK: - Table view data source
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCellWithIdentifier("dayCell", forIndexPath: indexPath)
      return cell
    }
    if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCellWithIdentifier("hourCell", forIndexPath: indexPath)
      return cell
    }
    if indexPath.row == 2 {
      let cell = tableView.dequeueReusableCellWithIdentifier("pastEventCell", forIndexPath: indexPath)
      return cell
    }
    if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCellWithIdentifier("hourCell", forIndexPath: indexPath)
      let hour = cell.viewWithTag(1) as! UILabel
      hour.text = "14:30"
      return cell
    }
    if indexPath.row == 4 {
      let cell = tableView.dequeueReusableCellWithIdentifier("futureEventCell", forIndexPath: indexPath)
      return cell
    }

    return UITableViewCell()
  }

}
