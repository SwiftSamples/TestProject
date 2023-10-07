//
//  ViewController.swift
//  TestProject
//
//  Created by Swapna Botta on 10/07/23.
//

import UIKit
import SideMenu
class ViewController: UIViewController, AlldelegateMethods {
       
    
    var singleVataTest: String?
    var notiVal = "Mynotification"
    var namesArrayG = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //to recive a notification

        
        //---------------using this approach we can call global service call array in which viewcontroller we want-------------
//        Global.shared.globalCall { [weak self] in
//            self?.namesArrayG = Global.shared.namesArray
//            print(self?.namesArrayG ?? [])
//                   // Update UI or perform other tasks with the namesArray
//                   DispatchQueue.main.async {
//                       // Update UI elements with the namesArray
//                   }
//               }
        //---------------this approach for getting namesArray through out the app bcz called global service in appdelegate----------------------
      //  print("in vc namnes array \(Global.shared.namesArray)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        setUpNavigationBar(with: "Food Menu", isBackNeed: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
 
    func singleValDelegate(valueStr: String) {
        singleVataTest = valueStr
        print("singlevalue: \(String(describing: singleVataTest))")
    }
    func multipleValuesDelegate(data: MultipleValues) {
        print("multiplevalue: \n\(String(describing: data.name))\n\(String(describing: data.age))\n\(String(describing: data.school))")
    }
    func multipleValuesDelegate1(_ data: MultipleValues) {
        print("multiplevalue: \n\(String(describing: data.name))\n\(String(describing: data.age))\n\(String(describing: data.school))")
    }
    
    @IBAction func testBtn(_ sender: Any) {
        //------------using delegate--------
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController1") as? ViewController1
//        vc?.delegate = self
//        self.navigationController?.pushViewController(vc!, animated: true)
//
//        //------------using notification--------
//
//        NotificationCenter.default.post(name: Notification.Name("TestingValue"), object: nil)
        
//        let menuVC = MenuViewController()
//        let menu = SideMenuNavigationController(rootViewController: menuVC)
//        menu.presentationStyle = .menuSlideIn // Specify the desired presentation style
//        SideMenuManager.default.rightMenuNavigationController = menu
//        present(menu, animated: true, completion: nil)
        
        
//         let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
//        menu.presentationStyle = .menuSlideIn
//
//        SideMenuManager.default.rightMenuNavigationController = menu
//        present(menu, animated: true, completion: nil)
        
        
        
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    
    
    
    
    
}

