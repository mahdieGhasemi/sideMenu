//
//  ViewController.swift
//  sideMenu
//
//  Created by Mahdie Ghasemi on 12/20/20.
//

import UIKit

class ViewController: UIViewController {
    
    let menuButton = UIButton()
    
    //MARK:-View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.6719930172, green: 0.7955337763, blue: 0.8067910075, alpha: 1)
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        menuButton.setImage(#imageLiteral(resourceName: "icons8-menu-100"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuBtn(_ : )), for: .touchUpInside)
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        menuButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 5).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let appName = UILabel()
        appName.text = "SIDE MENU"
        view.addSubview(appName)
        appName.translatesAutoresizingMaskIntoConstraints = false
        appName.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        appName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        
        //when user is in side menu view controller,if touch view,this called to close the menu
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CloseMenu),
                                               name: NSNotification.Name(rawValue: "CloseMenu"),
                                               object: nil)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(RightAction))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "CloseMenu"), object: nil)
    }
    
    //MARK:-Action
    
    @objc func RightAction(sender:UISwipeGestureRecognizer!){
        if sender.direction == .right {
            openMenu()
        }
    }
    
    
    @objc func CloseMenu() {
        closeMenu()
    }
    
    
    @IBAction func menuBtn(_ sender : UIButton){
        if menuButton.currentImage == #imageLiteral(resourceName: "icons8-menu-100") {
            openMenu()
        }else if menuButton.currentImage == #imageLiteral(resourceName: "icons8-multiply-90"){
            closeMenu()
        }
    }
    
    //MARK:-Function
    
    func openMenu(){
        childView = child(view: self.view)
        menuButton.setImage(#imageLiteral(resourceName: "icons8-multiply-90"), for: .normal)
    }
    
    func closeMenu(){
        if childView != nil{
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            childView?.view.layer.add(transition, forKey: kCATransition)
            childView?.view.isHidden = true
            self.menuButton.setImage(#imageLiteral(resourceName: "icons8-menu-100"), for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.removeChild(controller: childView ?? self)
            }
        }
    }
    
}

