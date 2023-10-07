//
//  GlobalFile.swift
//  TestProject
//
//  Created by Swapna Botta on 17/07/23.
//

import Foundation
import UIKit


class Global{
    
    
   static let shared = Global()
    private init() {}

    var namesArray = [String]()
    
    var jsonGlobalData: TestAPIModel?
    
//    func globalCall(){
    func globalCall(completion: @escaping () -> Void) {

        let urlString = "https://reqres.in/api/unknown"
        
        var resourceURL = URL(string: urlString)!
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { [self] (data, response, error) in
            
            guard error == nil else {
                print (error!.localizedDescription)
                print ("stuck in data task")
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let jsonData = try decoder.decode(TestAPIModel.self, from: data!)
                jsonGlobalData = jsonData
                print("hsjdhsk \(String(describing: jsonGlobalData))")
                namesArray = jsonData.data.compactMap({$0.name})
                print(namesArray)
                if let index = jsonData.data.firstIndex(where: {$0.name == "aqua sky"}){
                    namesArray.remove(at: index)
                    print(namesArray)
                }
                completion()
                //  completion(.success(jsonData))
            }
            catch {
                print ("an error in catch")
                print (error)
            }
        }
        dataTask.resume()
    }
    
    func getNamesArray() -> [String] {
            return jsonGlobalData?.data.compactMap({ $0.name }) ?? []
        }
    
    
}


