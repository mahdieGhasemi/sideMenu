//
//  SideMenuViewController.swift
//  sideMenu
//
//  Created by Mahdie Ghasemi on 12/20/20.
//

import UIKit

var childView : UIViewController?

struct sideMenuItem {
    var name : String
    var icon : UIImage
    
    init(name : String,icon : UIImage) {
        self.name = name
        self.icon = icon
    }
}

class SideMenuViewController: UIViewController {
    
    //MARK: -Variables
    
    let DicItem = ["All Inboxes" : #imageLiteral(resourceName: "icons8-send-mail-100"),"Primary" : #imageLiteral(resourceName: "icons8-inbox-52"),"Social" : #imageLiteral(resourceName: "icons8-mobile-social-networking-48"),"Promotions" : #imageLiteral(resourceName: "icons8-important-delivery-128"),"Starred" : #imageLiteral(resourceName: "icons8-rating-52"),"Important" : #imageLiteral(resourceName: "icons8-new-post-48"),"Sent" : #imageLiteral(resourceName: "icons8-sent-48"),"Scheduled" : #imageLiteral(resourceName: "icons8-schedule-48"),"Drafts" : #imageLiteral(resourceName: "icons8-bookmark-48"),"All mail" : #imageLiteral(resourceName: "icons8-new-post-48"),"Spam" : #imageLiteral(resourceName: "icons8-spam-48"),"Trash" : #imageLiteral(resourceName: "icons8-trash-52")]
    
    let textField = UITextField()
    let gradientView = UIView()
    let menuView = UIView()
    let menuTblView = UITableView()
    var menuItem = [sideMenuItem]()
    
    //MARK: -View
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view != menuView {
            
            closeMenu()
            
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        menuView.isHidden = true
        menuView.backgroundColor = #colorLiteral(red: 0.5710536838, green: 0.6806283593, blue: 0.7002953887, alpha: 1)
        self.view.addSubview(menuView)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        menuView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        gradientView.isHidden = true
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: menuView.topAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor).isActive = true
        gradientView.leftAnchor.constraint(equalTo: menuView.rightAnchor).isActive = true
        gradientView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        gradientView.layer.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 0.009792380137)
        
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.init(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5) ).cgColor ,UIColor.init(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) ).cgColor]
        layer.startPoint = CGPoint(x: 0,y: 1)
        layer.endPoint = CGPoint(x: 1,y: 1)
        layer.opacity = 0.5
        layer.name = "masklayer"
        gradientView.clipsToBounds = true
        gradientView.layer.addSublayer(layer)
        
        view.bringSubviewToFront(menuView)
        
        let name = UILabel()
        name.text = "Email"
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 2
        name.textColor = .black
        menuView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 20).isActive = true
        name.centerXAnchor.constraint(equalTo: menuView.centerXAnchor).isActive = true
        name.rightAnchor.constraint(equalTo: menuView.rightAnchor, constant: -10).isActive = true
        name.leftAnchor.constraint(equalTo: menuView.leftAnchor,constant: 10).isActive = true
        
        let lineImage = UIImageView()
        lineImage.backgroundColor = .white
        menuView.addSubview(lineImage)
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
        lineImage.centerXAnchor.constraint(equalTo: menuView.centerXAnchor).isActive = true
        lineImage.rightAnchor.constraint(equalTo: menuView.rightAnchor, constant: -20).isActive = true
        lineImage.leftAnchor.constraint(equalTo: menuView.leftAnchor,constant: 20).isActive = true
        lineImage.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        menuTblView.backgroundColor = .clear
        menuTblView.separatorStyle = .none
        menuTblView.dataSource = self
        menuTblView.delegate = self
        menuTblView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        menuView.addSubview(menuTblView)
        menuTblView.translatesAutoresizingMaskIntoConstraints = false
        menuTblView.topAnchor.constraint(equalTo: lineImage.bottomAnchor,constant: 10).isActive = true
        menuTblView.leftAnchor.constraint(equalTo: menuView.leftAnchor).isActive = true
        menuTblView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor ,constant: 10).isActive = true
        menuTblView.rightAnchor.constraint(equalTo: menuView.rightAnchor, constant: 10).isActive = true
        
        for (name,icon) in DicItem{
            menuItem.append(sideMenuItem(name: name, icon: icon))
        }
        
        menuTblView.reloadData()
        
        openMenu()
        
    }
    
    
    //MARK: -Functions
    
    func closeMenu(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseMenu"), object: nil)
    }
    
    func openMenu(){
        self.menuView.isHidden = false
        gradientView.isHidden = false
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        menuView.layer.add(transition, forKey: kCATransition)
        gradientView.layer.add(transition, forKey: kCATransition)
    }

}

//MARK: -Extention
extension SideMenuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SideMenuViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.label.text = menuItem[indexPath.row].name
        cell.icon.image = menuItem[indexPath.row].icon
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //open another viewController
    }
}

