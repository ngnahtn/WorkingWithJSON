//
//  HomePageViewController.swift
//  Tutor
//
//  Created by Tuyen on 2/22/18.
//  Copyright © 2018 Tuyen. All rights reserved.
//

import UIKit

class HomePageViewController: UIPageViewController {
    
    weak var homeDelegate: HomePageViewControllerDelegate?
    var indext:Int = 0
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [
                    FirstViewController(),
                    SecondViewController()
              ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
        scrollToViewController(orderedViewControllers[indext])
        
//        if Util.shared.isRegister {
//            indext = 0
//            Util.shared.isRegister = false
//            scrollToViewController(orderedViewControllers[indext])
//        }
//        else{
//            scrollToViewController(orderedViewControllers[indext])
//        }
        
        homeDelegate?.homePageViewController(self,
                                             didUpdatePageCount: orderedViewControllers.count)
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey : Any]? = nil)
    {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func scrollToRightViewController() {
        if let visibleViewController = viewControllers?.first,
            let rightViewController = pageViewController(self,
                                                         viewControllerBefore: visibleViewController) {
            scrollToViewController(rightViewController)
        }
    }
    
    func scrollToLeftViewController() {
        if let visibleViewController = viewControllers?.first,
            let leftViewController = pageViewController(self,
                                                        viewControllerAfter: visibleViewController) {
            scrollToViewController(leftViewController)
        }
    }
    
    
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
           let currentIndex = orderedViewControllers.firstIndex(of: firstViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
    
    fileprivate func newViewController(_ name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(name)")
    }
    
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewController.NavigationDirection = .forward) {
        
        
        
        
        
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            self.notifyhomeDelegateOfNewIndex()
        })
    }
    
    fileprivate func notifyhomeDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
           let index = orderedViewControllers.firstIndex(of: firstViewController) {
            homeDelegate?.homePageViewController(self,
                                                 didUpdatePageIndex: index)
        }
    }
}

// MARK: UIPageViewControllerDataSource

extension HomePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

extension HomePageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyhomeDelegateOfNewIndex()
    }
    
}

protocol HomePageViewControllerDelegate: AnyObject {
    
    
    func homePageViewController(_ homePageViewController: HomePageViewController,
                                didUpdatePageCount count: Int)
    
    func homePageViewController(_ homePageViewController: HomePageViewController,
                                didUpdatePageIndex index: Int)
    
}

