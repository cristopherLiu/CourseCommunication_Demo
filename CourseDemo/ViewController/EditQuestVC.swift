//
//  EditQuestVC.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/18.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit


class EditQuestVC: UIViewController ,UITextViewDelegate , UIViewControllerTransitioningDelegate{
    
    var dialogTextView:UITextView = UITextView()
    var dialogView = UIView()
    
    var bottomConstraint:NSLayoutConstraint?
    var defaultHeight:CGFloat = 16
    
    var callback:((String)->())?
    
    convenience init(title:String,content:String,callback:(String)->()){
        self.init(nibName: nil, bundle: nil)
        self.title = title
        dialogTextView.text = content
        self.callback = callback
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    func commonInit() {
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.ColorRGB(0xEFEFF4, alpha: 1)
        
        let Lbutton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        Lbutton.tintColor = UIColor.blueColor()
        self.navigationItem.leftBarButtonItem = Lbutton
        
        let Rbutton = UIBarButtonItem(title: "儲存", style: UIBarButtonItemStyle.Plain, target: self, action: "save")
        Rbutton.tintColor = UIColor.blueColor()
        self.navigationItem.rightBarButtonItem = Rbutton
        
        //底部view
        dialogView.backgroundColor = UIColor.ColorRGB(0xFFFFFF, alpha: 1)
        dialogView.layer.cornerRadius = 12 //圓角
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dialogView)
        
        //set layOut
        let views = [
            "top":self.topLayoutGuide,
            "dialogView":dialogView,
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[dialogView]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views as! [String : AnyObject]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[top]-16-[dialogView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views as! [String : AnyObject]))
        bottomConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: dialogView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: defaultHeight)
        self.view.addConstraint(bottomConstraint!)
        
        //text
        dialogTextView.backgroundColor = dialogView.backgroundColor
        dialogTextView.textColor = UIColor.ColorRGB(0x434A54, alpha: 1)
        dialogTextView.font = UIFont.systemFontOfSize(16)
        dialogTextView.textAlignment = NSTextAlignment.Left
        dialogTextView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addSubview(dialogTextView)
        
        //set layOut
        let innerview = [
            "dialogTextView":dialogTextView,
        ]
        
        dialogView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[dialogTextView]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: innerview))
        dialogView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[dialogTextView]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: innerview))
        
        self.automaticallyAdjustsScrollViewInsets = false //關閉自動調整scrollview
    }
    
    
    //註冊鍵盤觀察事件
    func registerForKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        dialogTextView.becomeFirstResponder() //設定為forcus
    }
    
    //返回
    func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //儲存
    func save(){
        dialogTextView.resignFirstResponder() //關閉鍵盤
        callback?(dialogTextView.text) //回呼前一頁text
        back()
    }
    
    //鍵盤show
    func keyboardShow(notification: NSNotification) {
        keyboardToggle(notification, isShow: true) //鍵盤顯示 調整constant
    }
    
    //鍵盤hide
    func keyboardHide(notification: NSNotification) {
        keyboardToggle(notification, isShow: false) //鍵盤隱藏 調整constant
    }
    
    //鍵盤顯示與隱藏 調整constant
    func keyboardToggle(notification: NSNotification,isShow:Bool) {
        
        if self != self.navigationController?.viewControllers.last{
            return
        }
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            
            //鍵盤duration
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            
            //動畫曲線
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            if let bottomConstraint = bottomConstraint{
                //鍵盤顯示
                if isShow{
                    bottomConstraint.constant = keyboardFrame?.size.height ?? 0 //調整bottom規則
                }else{
                    bottomConstraint.constant = defaultHeight //調整bottom規則
                }
            }
            
            UIView.animateWithDuration(duration,
                delay: NSTimeInterval(0),
                options: animationCurve,
                animations: { self.view.layoutIfNeeded() },
                completion: nil)
        }
    }
    
    // ---- UIViewControllerTransitioningDelegate methods
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        if presented == self {
            return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
        }
        
        return nil
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if presented == self {
            return CustomPresentationAnimationController(isPresenting: true)
        }
        else {
            return nil
        }
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed == self {
            return CustomPresentationAnimationController(isPresenting: false)
        }
        else {
            return nil
        }
    }
}
