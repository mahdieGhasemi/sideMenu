//
//  ChildViewFuncs.swift
//  sideMenu
//
//  Created by Mahdie Ghasemi on 12/20/20.
//

import Foundation
import UIKit

extension  UIViewController {
    
    
    func child(view : UIView) -> UIViewController{
        
        let  controller = SideMenuViewController()
        //add as a childviewcontroller
        addChild(controller)
        let transition = CATransition()
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        view.layer.add(.init(), forKey: nil)
        view.addSubview(controller.view)
        controller.view.frame = CGRect(x: 0, y: 60 + view.safeAreaInsets.top, width: self.view.frame.width, height: self.view.frame.height - 60 - view.safeAreaInsets.top )
        
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // tell the childviewcontroller it's contained in it's parent
        controller.didMove(toParent: self)
        return controller
    }
    
    func removeChild(controller: UIViewController){
        
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
        childView = nil
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
        
    }
}
