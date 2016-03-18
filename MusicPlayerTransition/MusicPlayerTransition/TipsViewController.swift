//
//  TipsViewController.swift
//  MusicPlayerTransition
//
//  Created by Valentina Coletti on 18/03/16.
//  Copyright © 2016 xxxAIRINxxx. All rights reserved.
//

import UIKit
import MapKit

final class TipsViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
  
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
    setStatusBar()
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
  
  func setStatusBar() {
    let statusBarView = UIView(frame:
      CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)
    )
    statusBarView.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(statusBarView)
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
    return 6
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCellWithIdentifier("allCell", forIndexPath: indexPath)
      return cell
    }
    if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCellWithIdentifier("tipCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(1) as! UILabel
      title.text = "Hertz Car rental"
      let subtitle = cell.viewWithTag(2) as! UILabel
      subtitle.text = "Near the Four Seasons Hotel or JFK Airport. If you would like to have more freedom travelling."
      return cell
    }
    if indexPath.row == 2 {
      let cell = tableView.dequeueReusableCellWithIdentifier("tipCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(1) as! UILabel
      title.text = "Plugs"
      let subtitle = cell.viewWithTag(2) as! UILabel
      subtitle.text = "This is how the plugs looks like, don’t forget an adaptator if it isn’t the same as yours! This is how the plugs looks like, don’t forget an adaptator if it isn’t the same as yours!"
      return cell
    }
    if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCellWithIdentifier("tipCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(1) as! UILabel
      title.text = "Tip"
      let subtitle = cell.viewWithTag(2) as! UILabel
      subtitle.text = "Near the Four Seasons Hotel or JFK Airport. If you would like to have more freedom travelling. This is how the plugs looks like, don’t forget an adaptator if it isn’t the same as yours! Near the Four Seasons Hotel or JFK Airport. If you would like to have more freedom travelling"
      return cell
    }
    if indexPath.row == 4 {
      let cell = tableView.dequeueReusableCellWithIdentifier("tipCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(1) as! UILabel
      title.text = "Tip again"
      let subtitle = cell.viewWithTag(2) as! UILabel
      subtitle.text = "Contrairement à une opinion répandue, le Lorem Ipsum n'est pas simplement du texte aléatoire. Il trouve ses racines dans une oeuvre de la littérature latine classique datant de 45 av. J.-C., le rendant vieux de 2000 ans. Un professeur du Hampden-Sydney College, en Virginie."
      return cell
    }
    if indexPath.row == 5 {
      let cell = tableView.dequeueReusableCellWithIdentifier("tipCell", forIndexPath: indexPath)
      let title = cell.viewWithTag(1) as! UILabel
      title.text = "Tip again and again"
      let subtitle = cell.viewWithTag(2) as! UILabel
      subtitle.text = "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un peintre anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus PageMaker."
      return cell
    }
    
    return UITableViewCell()
  }
  
}
