//
//  CustomPresentationController.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/18.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    lazy var dimmingView :UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        view.alpha = 0.0
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        print("presentationTransition將開始")
        guard
            let containerView = containerView,
            let presentedView = presentedView()
            else {
                return
        }
        
        //添加半透明背景view到畫面
        // Add the dimming view and the presented view to the heirarchy
        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        containerView.addSubview(presentedView)
        
        //伴隨過動效果動畫 做出view的淡入效果
        // Fade in the dimming view alongside the transition
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                
                self.dimmingView.alpha = 1.0
                
                }, completion:nil)
        }
    }
    
    override func presentationTransitionDidEnd(completed: Bool)  {
        print("presentationTransition結束:\(completed)")
        // If the presentation didn't complete, remove the dimming view
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin()  {
        print("dismissalTransition將開始")
        // Fade out the dimming view alongside the transition
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 0.0
                }, completion:nil)
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        print("dismissalTransition結束:\(completed)")
        // If the dismissal completed, remove the dimming view
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        
        print("呈現PresentedView在ContainerView")
        guard
            let containerView = containerView
            else {
                return CGRect()
        }
        
        // We don't want the presented view to fill the whole container view, so inset it's frame
        var frame = containerView.bounds
        frame = CGRectInset(frame, 50.0, 50.0)
        
        return frame
    }
    
    
    // ---- UIContentContainer protocol methods
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator transitionCoordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: transitionCoordinator)
        
        print("viewWillTransitionToSize")
        
        guard
            let containerView = containerView
            else {
                return
        }
        
        transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.frame = containerView.bounds
            }, completion:nil)
    }
}
