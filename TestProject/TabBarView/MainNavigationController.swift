//
//  MainNavigationController.swift
//  AveryAndEve
//
//  Created by Convergent Infoware on 11/03/21.
//

import UIKit


class MainNavigationController : UINavigationController, UINavigationControllerDelegate {
    
    public var tabBarView : TabBarView?
    public var needTabHide : Bool = false
    private var bottomSpace : CGFloat = 95
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTab()
        self.delegate = self
    }
    
    //Set up view for top tab
    private func setUpTab(){
        DispatchQueue.main.async {
            var tab : TabBarView{
                if let v = self.view.subviews.first(where: {$0 is TabBarView}) as? TabBarView{
                    return v
                }else{
                    let tabbar = Bundle.main.loadNibNamed("TabBarView", owner: self, options: nil)?.first! as! TabBarView
                    self.view.addSubview(tabbar)
                    return tabbar
                }
            }
            self.tabBarView = tab
            self.view.addSubview(tab)
            tab.translatesAutoresizingMaskIntoConstraints = false
            let bottom = NSLayoutConstraint(item: tab, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
            let leading = NSLayoutConstraint(item: tab, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint(item: tab, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
            tab.selectedTag = 0
            self.bottomSpace = 95
            tab.heightAnchor.constraint(equalToConstant: 95).isActive = true
            tab.btnCollection.forEach({$0.addTarget(self, action: #selector(self.btnClickOnButton), for: .touchUpInside)})
            self.view.addConstraints([bottom,leading,trailing])
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func btnClickOnButton(_ from : UIButton){
        //        if let v = self.view.subviews.first(where: {$0 is TabBarView}) as? TabBarView{
        //            v.selectedTag = from.tag
        //        }
        
    //    let root = self.sideMenuController?.contentViewController as! UINavigationController
        
        if from.tag == 1{
            (self.view.subviews.first(where: {$0 is TabBarView}) as? TabBarView)?.selectedTag = from.tag
           
        }
        else if from.tag == 2 {
            (self.view.subviews.first(where: {$0 is TabBarView}) as? TabBarView)?.selectedTag = from.tag
          
        }
        else if from.tag == 3 {
            (self.view.subviews.first(where: {$0 is TabBarView}) as? TabBarView)?.selectedTag = from.tag
         
        }
        else if from.tag == 4{
           
        }
        else{
            (self.view.subviews.first(where: {$0 is TabBarView}) as? TabBarView)?.selectedTag = 0
            //            let home = Helper.getVcObject(vcName: .HomeVC, StoryBoardName: .Main) as! HomeVC
            //            self.checkAndPushPop(home, navigationController: self)
          //  root.popToRootViewController(animated: true)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
}
