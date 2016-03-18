//
//  EventDetailsViewController.swift
//  MusicPlayerTransition
//
//  Created by Valentina Coletti on 18/03/16.
//  Copyright © 2016 xxxAIRINxxx. All rights reserved.
//

import UIKit
import MapKit

final class EventDetailsViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
  
  var tapCloseButtonActionHandler : (Void -> Void)?
  @IBOutlet weak var navBar: UINavigationBar!
  @IBOutlet weak var tableView: UITableView!

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
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
  }

  // MARK: - Table view data source
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath)
      return cell
    }
    if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCellWithIdentifier("titleSubCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(4) as! UILabel
      title.text = "Check-in @ Four Seasons Hotel"
      let subtitle = cell.viewWithTag(5) as! UILabel
      subtitle.text = "Room ready at 3pm"
      return cell
    }
    if indexPath.row == 2 {
      let cell = tableView.dequeueReusableCellWithIdentifier("photosCell", forIndexPath: indexPath)
      return cell
    }
    if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCellWithIdentifier("titleSubCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(4) as! UILabel
      title.text = "Description"
      let subtitle = cell.viewWithTag(5) as! UILabel
      subtitle.text = "We did most of the heavy lifting for you to provide a default stylings that incorporate our custom components. Additionally, we refined animations and transitions to provide a smoother experience for developers."
      return cell
    }
    if indexPath.row == 4 {
      let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)
      let map = cell.viewWithTag(8) as! MKMapView
      map.mapType = MKMapType.Standard
      map.showsUserLocation = true
      return cell
    }
    if indexPath.row == 5 {
      let cell = tableView.dequeueReusableCellWithIdentifier("titleSubCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(4) as! UILabel
      title.text = "Weather"
      let subtitle = cell.viewWithTag(5) as! UILabel
      subtitle.text = "Light Rain 2°C"
      return cell
    }
    if indexPath.row == 6 {
      let cell = tableView.dequeueReusableCellWithIdentifier("titleSubCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(4) as! UILabel
      title.text = "Currency"
      let subtitle = cell.viewWithTag(5) as! UILabel
      subtitle.text = "1 CHF = 1.00 USD"
      return cell
    }
    
    return UITableViewCell()
  }
  
}
