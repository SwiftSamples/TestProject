//
//  SegmentViewController.swift
//  TestProject
//
//  Created by Swapna Botta on 01/12/23.
//

import UIKit
import HMSegmentedControl
class SegmentViewController: UIViewController {

    @IBOutlet weak var segmentView: HMSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentView.sectionTitles = ["one", "two", "three", "four"]
       // segmentView.selectionStyle = .box
        segmentView.selectionIndicatorColor = .cyan
        segmentView.selectionIndicatorLocation = .bottom
        segmentView.selectedSegmentIndex = 0
        segmentView.indexChangeBlock = { [weak self] index in
            self?.segmentDidChange(index: Int(index))
                }
                
                // Initial setup based on the initially selected segment
        segmentDidChange(index: Int(segmentView.selectedSegmentIndex))
        
    }
    
    func segmentDidChange(index: Int) {
          switch index {
          case 0:
              // Display data for Segment 1
              print("iuhsfusdhi")
            //  showDataForSegment1()
          case 1:
              // Display data for Segment 2
//              showDataForSegment2()
              print("iuhsfusdhi 1111")
          case 2:
              print("222222")

          default:
              break
          }
      }
    
    
  

}
