//
//  ProgressBar.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/21.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit

class ProgressBar:UIView{
    
    private var minTrackLayer: CALayer = CALayer()
    private var maxTrackLayer: CALayer = CALayer()
    private var textLabel = UILabel()
    
    //高
    private var trackLayerHeight: CGFloat{
        return self.bounds.size.height
    }
    
    //寬
    private var trackLayerWidth: CGFloat {
        return self.bounds.size.width
    }
    
    //設定值
    func setValue(value:Double,maxValue:Double){
        
        //設定最大值
        self.maxValue = maxValue
        self.currentValue = value
        
        progressPercent = min(1.0, max(0.0, CGFloat(value) / CGFloat(self.maxValue)))
        
        self.setNeedsLayout() //重新設定畫面
    }
    
    //最大值
    private var maxValue:Double!
    
    //當前值
    private var currentValue: Double = 0{
        didSet {
            //文字
            textLabel.text = "\(currentValue)"
            textLabel.sizeToFit()
        }
    }
    
    //進度百分比
    private var progressPercent: CGFloat = 0
    
    //達標顏色
    internal var thumbTintColor: UIColor = UIColor.orangeColor() {
        didSet {
            self.minTrackLayer.backgroundColor = self.thumbTintColor.CGColor
        }
    }
    
    //未達標顏色
    internal var trackTintColor: UIColor = UIColor(red: 0.3, green: 0.5, blue: 0.88, alpha: 1)  {
        didSet {
            self.maxTrackLayer.backgroundColor = self.trackTintColor.CGColor
        }
    }
    
    // MARK: initialization
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup(){
        
        //最大底圖
        maxTrackLayer = CALayer()
        maxTrackLayer.frame = CGRectMake(0, 0, self.trackLayerWidth, self.trackLayerHeight)
        maxTrackLayer.backgroundColor = self.thumbTintColor.CGColor
        self.layer.addSublayer(maxTrackLayer)
        
        //最小底圖
        minTrackLayer = CALayer()
        minTrackLayer.frame = CGRectMake(0, 0, self.progressPercent * self.trackLayerWidth, self.trackLayerHeight)
        minTrackLayer.backgroundColor = self.trackTintColor.CGColor
        self.layer.addSublayer(minTrackLayer)
        
        //文字
        textLabel = UILabel()
        textLabel.font = UIFont.systemFontOfSize(25)
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.textColor = UIColor.whiteColor()
        self.layer.addSublayer(textLabel.layer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
        
        //最大底圖
        self.maxTrackLayer.frame = CGRectMake(0, 0, self.trackLayerWidth, self.trackLayerHeight)
        maxTrackLayer.cornerRadius = 1/2 * self.trackLayerHeight
        
        //最小底圖
        self.minTrackLayer.frame = CGRectMake(0, 0, self.progressPercent * self.trackLayerWidth, self.trackLayerHeight)
        minTrackLayer.cornerRadius = 1/2 * self.trackLayerHeight
        
        //當前值文字位置
        self.textLabel.center = CGPointMake(1/2 * self.trackLayerWidth, 1/2 * self.trackLayerHeight)
        
        CATransaction.commit()
    }
    
    
    
    //    var barColor: UIColor = UIColor(red: (37.0/255.0), green: (252.0/255), blue: (244.0/255.0), alpha: 1.0)
    //    var bar:CAShapeLayer!
    //
    //    var label:UILabel!
    //
    //    //進度條百分比
    //    var progressPercent:CGFloat = 1.0{
    //        didSet{
    //
    //        }
    //    }
    //
    //    var AnimationDuration:CFTimeInterval = 5
    //
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //
    //        label = UILabel()
    //        label.font = UIFont.systemFontOfSize(16)
    //        label.textAlignment = NSTextAlignment.Center
    //        label.textColor = UIColor.brownColor()
    //        label.numberOfLines = 0
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        self.addSubview(label)
    //
    //
    //        let viewsDict = [
    //            "super":self,
    //            "label":label,
    //            ] as [String:AnyObject]
    //
    //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[super]-(<=0)-[label]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict))
    //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[super]-(<=0)-[label]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: viewsDict))
    //
    //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[label]", options: [], metrics: nil, views: viewsDict))
    //        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label]", options: [], metrics: nil, views: viewsDict))
    //
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //    }
    //
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //
    //        // Add
    //        bar = self.addBar(self.barColor)
    //    }
    //
    //    func startAnimation(){
    //
    //        //animation
    //        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
    //        pathAnimation.duration = AnimationDuration
    //        pathAnimation.fromValue = 0
    //        pathAnimation.toValue = 1
    //        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    //        pathAnimation.removedOnCompletion = false
    //        pathAnimation.fillMode = kCAFillModeForwards
    //        pathAnimation.autoreverses = true
    //        bar.addAnimation(pathAnimation, forKey: "lineStrokeEnd")
    //    }
    //
    //    func setTimeText(text:String){
    //        label.text = text
    //    }
    //
    //    func addBar(color: UIColor)->CAShapeLayer{
    //
    //        let centerY = CGRectGetMidY(self.bounds)
    //
    //        // 環繞的BezierPath
    //        let BasePath = UIBezierPath(rect: CGRectMake(16, centerY, self.bounds.width - 32, 0)).CGPath
    //
    //        //環繞的底layer
    //        let arclayer = CAShapeLayer()
    //        arclayer.lineWidth = self.bounds.height
    //        arclayer.path = BasePath
    //        arclayer.strokeStart = 0
    //        arclayer.strokeEnd = 1
    //        arclayer.strokeColor = color.CGColor
    //        arclayer.fillColor = UIColor.clearColor().CGColor
    //        arclayer.lineCap = kCALineCapRound
    //        arclayer.lineJoin = kCALineJoinRound
    //        layer.insertSublayer(arclayer, below: label.layer)
    //        
    //        return arclayer
    //    }
}
