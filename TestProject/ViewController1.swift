//
//  ViewController1.swift
//  TestProject
//
//  Created by Swapna Botta on 10/07/23.
//

import UIKit
import Alamofire
protocol AlldelegateMethods{
    func singleValDelegate(valueStr : String)
    func multipleValuesDelegate(data : MultipleValues)
    func multipleValuesDelegate1(_ data : MultipleValues)
}

struct MultipleValues{
    
    var name: String?
    var age: Int?
    var school: String?
    
}

struct TestModel{
let name: String?
var isSelectced = false
}



let notiNameV1 = Notification.Name("ViewCOnt1Data")

class ViewController1: UIViewController {
    var delegate: AlldelegateMethods!
    var namesArray = [String]()
    var selectedNamesArray = [String]()
    var selectedIDarray = [Int]()

    var stu = Student(name: "hello", num: 10)
    
    
    var stuS = student(name: "struct", num: 10)
    
    var jsonData: TestAPIModel? {
        didSet{
            print(jsonData?.data)
        }
        
    }
    var selectedIndexPath: IndexPath? = nil

    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var pStu = self.stu
        var pubStu = self.stuS

        pStu.name = "world"
        
        pubStu.name = "created"
        print("class \(pStu.name), \(stu.name)")
        print("struct \(pubStu.name), \(stuS.name)")

        
        let values = MultipleValues(name: "Tom", age: 20, school: "Oxford")
        let sendData: [String : Any] = ["key" : values]
        NotificationCenter.default.post(name: notiNameV1, object: nil, userInfo: sendData)
        
      

        collectionView.delegate = self
        collectionView.dataSource = self
        
       // self.navigationController?.isNavigationBarHidden = true
        setUpNavigationBar(with: "Second vc", isBackNeed: true)
        self.navigationController?.navigationBar.isHidden = false

        print("only names arry \(Global.shared.namesArray)")
      //  let widthVal = collectionView.bounds.width / 3
        
        let layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = .vertical
//        layOut.minimumLineSpacing = 0//5
//        layOut.minimumInteritemSpacing = 5
//        layOut.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        layOut.itemSize = CGSize(width: widthVal, height: widthVal)

        collectionView.collectionViewLayout = layOut
        collectionView.allowsMultipleSelection = true

        GenericCodableServicecall()
    }
    
    var cvWidth: CGFloat = -1.0

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if cvWidth != collectionView.frame.size.width {
            cvWidth = collectionView.frame.size.width
            if let fl = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {

                // number of columns to show - you might be setting this elsewhere
                let nColumns: Int = 4
                
                // get the left and right section inset values
                let sideSpace: CGFloat = fl.sectionInset.left + fl.sectionInset.right
                
                // we want *about* 5-points spacing between items
                let totalEmptyspace: CGFloat = sideSpace + (CGFloat(nColumns) * 3.0)
                
                // calculate item width for nColumns number of columns
                let w = (cvWidth - totalEmptyspace) / CGFloat(nColumns)
                fl.itemSize = .init(width: w, height: w)

                // make sure interItemSpacing is set to Zero!
                fl.minimumInteritemSpacing = 0.0

            }
        }
    }
    
    private func GenericCodableServicecall(){
        
        let parameters: Parameters = [
            "user_id": 123
        ]
        
        NetworkService.request("https://reqres.in/api/unknown", method: .get, parameters: parameters) { (result: Result<TestAPIModel, APIError>) in
            switch result {
            case .success(let user):
                print("response \(user)")
                self.namesArray = user.data.compactMap { $0.name }
                self.jsonData = user
                self.collectionView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func topBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func testBtn(_ sender: Any) {
        delegate.singleValDelegate(valueStr: "Hello world!!")
        let values = MultipleValues(name: "Tom", age: 20, school: "Oxford")
        delegate.multipleValuesDelegate(data: values)
        delegate.multipleValuesDelegate1(values)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewController1: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        jsonData?.data.count ?? 0//40
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionCell", for: indexPath) as! TestCollectionCell
        cell.layoutIfNeeded()
        cell.titleLbl.text = jsonData?.data[indexPath.row].name
//        cell.contentView.backgroundColor = jsonData?.data[indexPath.row].isSelected ?? false ? .yellow : .red
        cell.contentView.backgroundColor = selectedIndexPath == indexPath ? .yellow : .red

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        print("in select..")
      //  jsonData?.data[indexPath.row].isSelected.toggle()
        
        
//        if selectedIndexPath == indexPath {
//            selectedIndexPath = nil
//               // unselect code here
//           } else {
//               selectedIndexPath = indexPath
//               // Select code here
//           }
        selectedIndexPath = indexPath
        collectionView.reloadItems(at: [indexPath])
       // collectionView.reloadData()
        
        
        
//        if let previouslySelectedIndexPath = selectedIndexPath {
//            jsonData?.data[previouslySelectedIndexPath.row].isSelected = false
//            collectionView.reloadItems(at: [previouslySelectedIndexPath])
//        }
//
//        // Select the new cell
//        collectionView.reloadItems(at: [indexPath])
//        selectedIndexPath = indexPath
        
        //multiple cell select/deselect
//        let selectedName = jsonData?.data[indexPath.row].name
//        jsonData?.data[indexPath.row].isSelected.toggle()
//        if let inx = selectedNamesArray.firstIndex(of: selectedName ?? ""){
//            selectedNamesArray.remove(at: inx)
//            selectedIDarray.remove(at: inx)
//        }
//        else{
//            selectedNamesArray.append(selectedName!)
//            selectedIDarray.append(jsonData?.data[indexPath.row].id ?? 0)
//        }
//        collectionView.reloadItems(at: [indexPath])
//        print("selected Name: \(selectedNamesArray)\n selectedID: \(selectedIDarray)")
    }
}


class TestCollectionCell: UICollectionViewCell{
    @IBOutlet weak var roundImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {

        super.awakeFromNib()

       }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundImg.layer.cornerRadius = roundImg.frame.width / 2
        roundImg.contentMode = .scaleToFill
        roundImg.clipsToBounds = true
        
    }
    
}








class Student{
    var name: String
    var num: Int
    
    init(name: String, num: Int) {
        self.name = name
        self.num = num
    }
}

struct student{
    var name: String
    var num: Int
}
