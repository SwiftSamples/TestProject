//
//  HomeViewController.swift
//  TestProject
//
//  Created by Swapna Botta on 26/07/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar(with: "Home", isBackNeed: true)

        NotificationCenter.default.addObserver(self, selector: #selector(testNoti(_:)), name: Notification.Name("TestNotificationArray"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(v11Data(_:)), name: notiNameV1, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func v11Data(_ notification: NSNotification) {
        
        let data = notification.userInfo?["key"] as? MultipleValues
        print("vvvvvvv1 data \(data?.name)")
    }
        
    
    @objc func testNoti(_ notification: Notification){
                let data = notification.userInfo as? [String : Any]
        
        let array = data?["key"] as? [Int]
        print("sent intArray \(array)")

    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
}
