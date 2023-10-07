//
//  NavigationBar.swift
//  VMokshaAssignmentChk
//
//  Created by Swapna Botta on 04/03/22.
//


import Foundation
import UIKit
import SideMenu


extension UIViewController{
    
    func setUpNavigationBar(with titlewithLbl : String, isBackNeed : Bool = true){

        self.navigationController?.navigationBar.backgroundColor = .white //CommonColor.navigationColor
        self.navigationController?.navigationBar.barTintColor = .white//CommonColor.navigationColor
       // self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
      //  self.navigationController?.navigationItem.title = "test"
        
        let titleLbl = UILabel()
        titleLbl.textColor = UIColor.green
        titleLbl.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLbl.text = titlewithLbl
        navigationItem.title = titleLbl.text
      //  navigationItem.title

        let btnTitle = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(backClick))
     //   btnTitle.tintColor = title == "Food Menu" ? .black : .darkGray
        
        let backImageView = UIImageView.init(image: #imageLiteral(resourceName: "back_ic"))
        backImageView.tintColor = title == "Service Details" ? .black : .white
        backImageView.contentMode = .scaleAspectFit
        backImageView.frame = CGRect(x:0.0,y:0.0, width:20,height:25.0)
        backImageView.contentMode = .scaleAspectFit
        backImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        backImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backClick)))
        let btnBack = UIBarButtonItem(customView: backImageView)
        
    let cartBtn: BadgeButton = BadgeButton(type: .custom)
    cartBtn.setImage(#imageLiteral(resourceName: "cart"), for: .normal)
//    cartBtn.addAction(for: .touchUpInside) {
//        print("in cart")
//    }
        
        cartBtn.addAction(UIAction(title: "Click Me", handler: { [self] _ in
                        print("Hi in cart")
            
            let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
            menu.presentationStyle = .menuSlideIn
            menu.leftSide = true
           SideMenuManager.default.leftMenuNavigationController = menu
           present(menu, animated: true, completion: nil)
            
                    }), for: .touchUpInside)
    cartBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //cartBtn.badgeBackgroundColor = CommonColor.buttonGradientTwo
        let cartQty = UserDefaults.standard.value(forKey: "cartCount")
        cartBtn.badgeText = cartQty as? String
    let btnCart = UIBarButtonItem(customView: cartBtn)

          let currWidth = btnCart.customView?.widthAnchor.constraint(equalToConstant: 30)
          currWidth?.isActive = true
          let currHeight = btnCart.customView?.heightAnchor.constraint(equalToConstant: 30)
          currHeight?.isActive = true

    btnCart.tag = 12
        if isBackNeed{
            self.navigationItem.setLeftBarButtonItems([btnBack,btnTitle], animated: true)
        self.navigationItem.setRightBarButton(btnCart, animated: true)
        }
}

func setBadgeCountForCart(with : String?){
    let badge = self.navigationItem.rightBarButtonItems?.map({$0.customView}).filter({$0 is BadgeButton}).first as? BadgeButton
    badge?.badgeText = with
}

    @objc func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
}




