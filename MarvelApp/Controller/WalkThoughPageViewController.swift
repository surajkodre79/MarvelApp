//
//  ViewController.swift
//  MarvelApp
//
//  Created by Suraj Kodre on 22/10/18.
//  Copyright © 2018 Suraj Kodre. All rights reserved.
//

import UIKit

class WalkThoughPageViewController: UIPageViewController {

    var pages: [UIViewController] = []
    var pageControl : UIPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createPages()
        
        self.dataSource = self as? UIPageViewControllerDataSource
        self.delegate = self as? UIPageViewControllerDelegate
        
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        createSkipButton()
        createPageControl()
    }
    
    func createPageControl() {
        pageControl = UIPageControl(frame: CGRect(x:(self.view.frame.size.width)/2 - 40, y: self.view.frame.size.height - 100, width: 80, height: 20))
        self.pageControl?.numberOfPages = pages.count
        self.pageControl?.currentPage = 0
        self.pageControl?.pageIndicatorTintColor = .gray
        self.pageControl?.currentPageIndicatorTintColor = .red
        self.view.addSubview(pageControl!)
    }
    
    

    @objc func handelSkip() {
        print("Skip clicked")
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
        let navCont = UINavigationController(rootViewController: vc)
        self.present(navCont, animated: true, completion: nil)
    }
    
    func createSkipButton() {
        let skipButton = UIButton(frame: CGRect(x: (self.view.frame.size.width)/2 - 40, y: self.view.frame.size.height - 55, width: 80, height: 30))
        skipButton.addTarget(self, action: #selector(handelSkip), for: .touchUpInside)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.backgroundColor = .blue
        self.view.addSubview(skipButton)
    }
    
    func createPages() {
        for i in 1...4 {
           let vc = PagesController()
           vc.screen = "\(i) Screen"
            pages.append(vc)
        }
    }
}

extension WalkThoughPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.index(of: viewController) else { return nil }
        let prevoiusIndex = currentIndex - 1
        guard prevoiusIndex >= 0 else { return pages.last }
        guard pages.count > prevoiusIndex else { return nil }
       
        return pages[prevoiusIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard  let currntIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = currntIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
    
}

extension WalkThoughPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let pageVC = pendingViewControllers[0]
        pageControl?.currentPage = pages.index(of: pageVC)!
    }

}
