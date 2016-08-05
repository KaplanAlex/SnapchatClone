//
//  PageControllerVC.swift
//  SnapchatClone
//
//  Created by Alexander Kaplan on 8/3/16.
//  Copyright © 2016 develop. All rights reserved.
//

import UIKit


class PageControllerVC: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: [String]!
    var pageIndex: Int!
    var pageIndexBefore: Int!
    var pageIndexAfer: Int!
    var cameraView: CameraVC!
    var receivedView: ReceivedVC!
    var viewControllers: [UIViewController]!
    var allVC: [UIViewController]!
    var thisControl: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageIndex = 1
        self.pageIndexBefore = 0
        self.pageIndexAfer = 2
        
        self.pageTitles = ["Received","Camera"]
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        receivedView = self.storyboard?.instantiateViewController(withIdentifier: "ReceivedVC") as! ReceivedVC
        cameraView = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") as! CameraVC
        allVC = [receivedView,cameraView]
        
        let startVC = cameraView
        
        viewControllers = []
        viewControllers.append(startVC!)

        self.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        let subviews = self.pageViewController.view.subviews
        let max = subviews.count
        
        for i in 0 ..< max {
            if subviews[i].isKind(of: UIPageControl().dynamicType){
                thisControl = subviews[i]
            }
        }
        
        thisControl.isHidden = true

        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.size.height+37)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        print(pageIndex)
    }

    func viewControllerAtIndex(index: Int) -> UIViewController{
        if index == 1{
            let vc: CameraVC = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") as! CameraVC
            return vc
        }else if index == 0{
            let vc: ReceivedVC = self.storyboard?.instantiateViewController(withIdentifier: "ReceivedVC") as! ReceivedVC
            return vc
        }
        return UIViewController()
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if DataService.instance.currentPageIndex == 0 {
            return nil
        }
        
        return self.viewControllerAtIndex(index: 0)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        if DataService.instance.currentPageIndex == 1{
            return nil
        }
        
        return self.viewControllerAtIndex(index: 1)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 1
    }
    
    
}
