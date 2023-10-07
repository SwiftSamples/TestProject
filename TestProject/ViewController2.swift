//
//  ViewController2.swift
//  TestProject
//
//  Created by Swapna Botta on 23/07/23.
//

import UIKit
import StoreKit

class ViewController2: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //for cell1 --- second cell
    
    var namesArray = ["Apple", "Smasung", "Black berry", "Nokia", "Nokia", "Nokia", "Real me", "Lenova", "Pocco", "Motorola", "Infinix", "China Phone", "Jio"]
    
    var fullArray = [20,21,22,23,24,25,26,27,28,29]
    var firstHalf: [Int] = []
    var secondHalf: [Int] = []

    var selectedRows = [32, 38, 89, 11]//[Int]()
    var selectedNamesArray: [String] = []
 //   var alreadySelectedRows = [32, 38, 21, 76]
    
    var arrayModel: [SampleModel] = [SampleModel(id: 32, name: "Apple"),
                                     SampleModel(id: 38, name: "Smasung"),
                                     SampleModel(id: 22, name: "Black berry"),
                                     SampleModel(id: 76, name: "Nokia"),
                                     SampleModel(id: 12, name: "Real me"),
                                     SampleModel(id: 75, name: "Lenova"),
                                     SampleModel(id: 36, name: "Pocco"),
                                     SampleModel(id: 11, name: "Motorola"),
                                     SampleModel(id: 37, name: "Infinix"),
                                     SampleModel(id: 88, name: "China"),
                                     SampleModel(id: 89, name: "Jio")
    ]
    
    
    //for first cell
    var data: [Item] = [
        Item(title: "Item 1", isExpanded: false, details: "Details for Item 1 shcb zxgc zxgc zxjghc z,xhg cgxzh cgz xgczxhgc zhxg cgzxyh gcyzhx gcys gyd gsyd gsui."),
        Item(title: "Item 2", isExpanded: false, details: "Details for Item 2."),
        // ... add more items
    ]
   
    var productsArray = [SKProduct]()
    var subsciptionId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //notificationcenter
        
        let sendArray: [String : Any] = ["key" : [1,4,6,2,8]]
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TestNotificationArray"), object: nil, userInfo: sendArray)
        
        
        setUpNavigationBar(with: "third vc", isBackNeed: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let indecs = fullArray.count/2
        print(indecs)
       
//        for index in 0..<fullArray.count{
//
//            if index < indecs{
//                firstHalf.append(fullArray[index])
//            }
//            else{
//                secondHalf.append(fullArray[index])
//            }
//        }
        
        

//        fullArray.enumerated().forEach { ind, val in
//
//            if ind < indecs {
//                firstHalf.append(val)
//            }
//            else{
//                secondHalf.append(val)
//
//            }
//        }
        
                
       print("firsthalf: \(firstHalf)\nsecodhalf: \(secondHalf)")
        
        
        
        if !selectedRows.isEmpty{

//            selectedNamesArray = arrayModel.compactMap{ $0.name }
//            print("jhsdjks \(selectedNamesArray)")
//            selectedNamesArray = arrayModel
//                .filter { selectedRows.contains($0.id) }
//                .map { $0.name }
            
//            for aData in arrayModel{
//                if selectedRows.contains(aData.id){
//                    selectedNamesArray.append(aData.name)
//                }
//            }
            
            selectedRows.forEach { i in
                
                if let m = arrayModel.first(where: { $0.id == i }) {
                    selectedNamesArray.append(m.name)
                }
            }
                        
        }
        
    //    print("existing names: \(selectedNamesArray) \n and ids: \(selectedRows)")
        
        
        
        
        IAPManager.shared.setProductIds(
            ids:
                [
                    "monthly",
                    "yearly"
                ]
        )
        IAPManager.shared.fetchAvailableProducts { [weak self] (products) in
            guard let sSelf = self else {return}
            sSelf.productsArray = products
            print(products.count)
        }
    }
    
    @IBAction func testBtn(_ sender: UIButton) {
        print("sdhjfdsbj")
        //        performInAppPurchage(productIndex: senderTag ?? -1)
//        performInAppPurchage(productIndex: 1)
        
      
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func updatePaymentServiceCall(packagePaymentId: Int, transactionId: String) {
        let param = [
            "package_payment_id" : packagePaymentId,
            "payment_type" : "I",
            "transaction_id" : transactionId
        ] as [String : Any]
        
        //        APIReqeustManager.sharedInstance.serviceCall(param: param , method: .post, loaderNeed: false, loadingButton: nil, needViewHideShowAfterLoading: nil, vc: self, url: CommonUrl.save_payment_package, isTokenNeeded: true, isErrorAlertNeeded: true, isSuccessAlertNeeded: true, actionErrorOrSuccess: nil, fromLoginPageCallBack: nil) { (resp) in
        //
        //            if let _ = resp.dict?["result"] as? NSDictionary {
        //
        //            }
        //        }
    }
    
    private func performInAppPurchage(productIndex: Int) {
        // 2 - sender.tag for Rank
        // 3 + sender.tag for FlashSale
        
        if !productsArray.isEmpty {
            IAPManager.shared.purchase(product: self.productsArray[productIndex]) { (alert, product, transaction) in
                if let transaction = transaction, let product = product {
                    print(product)
                    //use transaction details and purchased product as you want
                    self.updatePaymentServiceCall(
                        packagePaymentId: self.subsciptionId,
                        transactionId: transaction.transactionIdentifier ?? "NA"
                    )
                }
                //  self.view.makeToast(alert.message)
            }
        } else {
            // self.view.makeToast("Product list is empty.")
        }
    }
}

extension ViewController2: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return data.count
        }else{
            return arrayModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableviewCell", for: indexPath) as? TestTableviewCell
            cell?.selectionStyle = .none
            let item = data[indexPath.row]
            cell?.titleLbl?.text = item.title
            cell?.despLbl?.text = item.isExpanded ? item.details : ""
            
            return cell!
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableviewCell1", for: indexPath) as? TestTableviewCell1
            cell?.selectionStyle = .none
            cell?.titleLbl?.text = arrayModel[indexPath.row].name
            cell?.checkBtn.tag = indexPath.row
            
            cell?.isChecked = selectedRows.contains(arrayModel[indexPath.row].id)
            
            
            cell?.buttonAction = { [self] sender in
                print("hello")
                
                if selectedRows.contains(arrayModel[indexPath.row].id) {
                    if let indexToRemove = selectedRows.firstIndex(of: arrayModel[indexPath.row].id) {
                        selectedRows.remove(at: indexToRemove)
                        selectedNamesArray.remove(at: indexToRemove)
                        
//                        if indexToRemove < selectedNamesArray.count {
//                            selectedNamesArray.remove(at: indexToRemove) // Remove corresponding name
//                        }
                        
                        cell?.isChecked = false
                    }
                } else {
                    selectedRows.append(arrayModel[indexPath.row].id)
                    selectedNamesArray.append(arrayModel[indexPath.row].name) // Add the corresponding name
                    cell?.isChecked = true
                }
                
                print("Selected rows: \(selectedRows)")
                print("Selected names: \(selectedNamesArray)")
            }
                        
            
            return cell!
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 100
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            var selectedItem = data[indexPath.row]
            selectedItem.isExpanded.toggle()
            data[indexPath.row] = selectedItem
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        else{
            print(indexPath.row)
        }
    }
}

class TestTableviewCell: UITableViewCell{
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var despLbl: UILabel!
    
}
class TestTableviewCell1: UITableViewCell{
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
        var isChecked = false{
        didSet{
            checkBtn.backgroundColor = isChecked ? .blue : .green
        }
    }
    
    var buttonAction: ((_ sender: AnyObject) -> Void)?
    
    @IBAction func buttonPressed(_ sender: UIButton) {
            self.buttonAction?(sender)
        }
    
}
struct Item {
    var title: String
    var isExpanded: Bool
    var details: String
    
}

//for cell2

struct SampleModel{
    var id: Int
    var name: String
}










