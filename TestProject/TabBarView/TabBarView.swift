//
//  TabBarView.swift
//  AveryAndEve
//
//  Created by Convergent Infoware on 11/03/21.
//

import UIKit

let updateMessageCountName = "updateMessageCount"
let screenWidth = UIScreen.main.bounds.width

class TabBarView : UIView{
    
    @IBOutlet weak var containerView: UIViewX! {
        didSet {
            containerView.layer.cornerRadius = 25
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBOutlet weak var msgcountLabel: UILabel!

    @IBOutlet var viewCollection : [UIView]!
    @IBOutlet var viewForImageBacgroundCollection : [UIView]!
    @IBOutlet var imgCollection : [UIImageView]!
    @IBOutlet var btnCollection : [UIButton]!
    @IBOutlet var titleCollection : [UILabel]! {
        didSet {
            titleCollection.forEach { (label) in
                label.font = UIFont(name: "Helvetica", size: screenWidth > 375 ? 15 : 11)
            }
        }
    }
    
    var selectedTag : Int = 0{
        didSet{
            imgCollection.forEach({$0.image =  $0.image?.withRenderingMode(.alwaysTemplate)})
            imgCollection.forEach({$0.tintColor =  $0.tag == 4 || $0.tag == 2 ? .white : .lightGray})
            titleCollection.forEach({$0.textColor =  $0.tag == 4 || $0.tag == 2 ? .white : .lightGray})
         
        }
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        msgcountLabel.isHidden = true
      
        selectedTag = 2//profileIsComplete ? 2: 10
        msgcountLabel.layer.cornerRadius = 10
        msgcountLabel.layer.masksToBounds = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
}





