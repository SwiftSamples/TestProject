//
//  MainSegPageViewController.swift
//  TestProject
//
//  Created by Swapna Botta on 15/08/23.
//

import UIKit

class MainSegPageViewController: UIPageViewController {

    private(set) lazy var subViewcontrollers: [UIViewController] = {
        return [
//            studentSignupViewController(step: 1),
//            studentSignupViewController(step: 2),
//            studentSignupViewController(step: 3),
//            studentSignupViewController(step: 4)
            
            
            UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "ViewController1"),
            UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "ViewController2")
        ]
    }()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar(with: "Pagination vc", isBackNeed: true)
        self.navigationController?.navigationBar.isHidden = false
        
        dataSource = self
       // view.backgroundColor = .systemBackground
      //  modalPresentationStyle = .popover
        
        UIPageControl.appearance(whenContainedInInstancesOf: [MainSegPageViewController.self]).currentPageIndicatorTintColor = .systemBlue
        UIPageControl.appearance(whenContainedInInstancesOf: [MainSegPageViewController.self]).pageIndicatorTintColor = .lightGray
        
        
        // Do any additional setup after loading the view.
        
        if let firstViewController = subViewcontrollers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }
    
    
}


// MARK: UIPageViewControllerDataSource
extension MainSegPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = subViewcontrollers.firstIndex(of:viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard subViewcontrollers.count > previousIndex else {
            return nil
        }
        if previousIndex == 2 {
            return nil
        }
        return subViewcontrollers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = subViewcontrollers.firstIndex(of:viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = subViewcontrollers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        if nextIndex == 3 {
            return nil
        }
        return subViewcontrollers[nextIndex]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewcontrollers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = subViewcontrollers.firstIndex(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }
}










