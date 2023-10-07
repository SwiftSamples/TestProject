//
//  MenuViewController.swift
//  TestProject
//
//  Created by Swapna Botta on 18/07/23.
//

import UIKit
import SideMenu
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableVIew: UITableView!
    let menuArray = ["vc1", "vc2", "vc3", "vc4", "logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tableVIew.reloadData()
        // Do any additional setup after loading the view.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
       
        cell.titleLbl.text = menuArray[indexPath.row] //"hello"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row{
        case 0:
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainSegPageViewController") as? MainSegPageViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
            return
        case 1:
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController2") as? ViewController2
            self.navigationController?.pushViewController(vc!, animated: true)
          return
            
        case 2:
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController1") as? ViewController1
            self.navigationController?.pushViewController(vc!, animated: true)
            return
        case 3:
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController4") as? ViewController4
            self.navigationController?.pushViewController(vc!, animated: true)
          return
            
        case 4:
            print("logout")

            let status = false//UserDefaults.standard.bool(forKey: "token")
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
            let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
            guard let rootVC = loginVC else {return}
            // Embed loginVC in Navigation Controller and assign the Navigation Controller as windows root
            let nav = UINavigationController(rootViewController: rootVC)
            keyWindow?.rootViewController = nav
            
            return
            
        default:
            print("in default")
            return
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
}



class MenuCell: UITableViewCell{
  
    @IBOutlet weak var titleLbl: UILabel!

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        // Customize the layout of the cell's UI elements
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}





