//
//  EventCell.swift
//  CourseDemo
//
//  Created by hjliu on 2015/12/18.
//  Copyright © 2015年 hjliu. All rights reserved.
//

import UIKit


class EventCell: UITableViewCell {

    //題目
    var questText:UILabel!
    
    //進度條
    var progressBar = ProgressBar()
    
    //答案
    var view1:UIView!
    var ansLabel1:UILabel!
    var ansBtn1:MyButton!
    
    var view2:UIView!
    var ansLabel2:UILabel!
    var ansBtn2:MyButton!
    
    var view3:UIView!
    var ansLabel3:UILabel!
    var ansBtn3:MyButton!
    
    var view4:UIView!
    var ansLabel4:UILabel!
    var ansBtn4:MyButton!
    
    //開始按鈕
    var playButton:UIButton?
    
    //答案按鈕array
    private var array = [MyButton]()
    private var arrayLabel = ["A","B","C","D"]
    
    private var eventData:Event!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.brownColor()
        
        //題目
        questText = getLabel()

        //時間倒數條
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(progressBar)
        
        //答案
        let c1 = getContent()
        view1 = c1.0
        ansLabel1 = c1.1
        ansLabel1.text = "A"
        ansBtn1 = c1.2
        array.append(ansBtn1)
        
        let c2 = getContent()
        view2 = c2.0
        ansLabel2 = c2.1
        ansLabel2.text = "B"
        ansBtn2 = c2.2
        array.append(ansBtn2)
        
        let c3 = getContent()
        view3 = c3.0
        ansLabel3 = c3.1
        ansLabel3.text = "C"
        ansBtn3 = c3.2
        array.append(ansBtn3)
        
        let c4 = getContent()
        view4 = c4.0
        ansLabel4 = c4.1
        ansLabel4.text = "D"
        ansBtn4 = c4.2
        array.append(ansBtn4)
        
        if isTeacher{
            playButton = UIButton()
            playButton!.addTarget(self, action: "play", forControlEvents: UIControlEvents.TouchUpInside)
            playButton!.setImage(UIImage(named: "Play_button"), forState: UIControlState.Normal)
            playButton!.setImage(UIImage(named: "Play_button")?.translucentImageWithAlpha(0.1), forState: UIControlState.Disabled)
            playButton!.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(playButton!)
        }
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.None
        
        var viewsDict = [
            "super":contentView,
            "questText":questText,
            "progressBar":progressBar,
            
            "view1":view1,
            "view2":view2,
            "view3":view3,
            "view4":view4,
            ] as [String:AnyObject]
        
        if isTeacher{
            viewsDict["playButton"] = playButton
        }
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[questText]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[progressBar]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view1]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view2]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view3]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view4]|", options: [], metrics: nil, views: viewsDict))
        
        if isTeacher{
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[playButton(60)]", options: [], metrics: nil, views: viewsDict))
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[super]-(<=0)-[playButton]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict))
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[questText]-16-[progressBar(30)]-16-[view1][view2][view3][view4]-[playButton(60)]-|", options: [], metrics: nil, views: viewsDict))
        }else{
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[questText]-16-[progressBar(30)]-16-[view1][view2][view3][view4]|", options: [], metrics: nil, views: viewsDict))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getLabel()->UILabel{
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(30)
        label.textAlignment = NSTextAlignment.Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 0
        label.backgroundColor = self.backgroundColor
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        return label
    }
    
    func getContent()->(UIView,UILabel,MyButton){
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(16)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 0
        label.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.88, alpha: 1)
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.greenColor().CGColor
        label.layer.cornerRadius = 25
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        let btn = MyButton()
        
        if isTeacher == false{
            btn.addTarget(self, action: "SelectAns:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        btn.backgroundColor = UIColor.whiteColor()
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.greenColor().CGColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(btn, belowSubview: label)
        
        let viewsDict = [
            "view":view,
            "label":label,
            "btn":btn,
            ] as [String:AnyObject]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-45-[btn]-8-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label(50)]", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view]-(<=0)-[label]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label(50)]", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[btn]-8-|", options: [], metrics: nil, views: viewsDict))
        
        return (view,label,btn)
    }
    
    func setData(data:Event, selectChange:Int->()){
        
        questText.text = data.title
        
        //老師 以及 選過答案的學生 可以看到 計數量
        if isTeacher || array.filter({ $0.selected }).count > 0 {
            ansBtn1.setText(data.A,content: "\(data.Acount)")
            ansBtn2.setText(data.B,content: "\(data.Bcount)")
            ansBtn3.setText(data.C,content: "\(data.Ccount)")
            ansBtn4.setText(data.D,content: "\(data.Dcount)")
        }else{
            ansBtn1.setText(data.A,content: "")
            ansBtn2.setText(data.B,content: "")
            ansBtn3.setText(data.C,content: "")
            ansBtn4.setText(data.D,content: "")
        }
        
        if let playButton = playButton{
            //如果沒有開始時間，則按鈕可使用
            playButton.enabled = data.startTime == nil
        }
        
        //設定倒數時間
        if let timeRemaining = data.timeRemaining{
            progressBar.setValue(timeRemaining,maxValue: data.time)
        }
        
        eventData = data
    }
    
    //選擇答案(學生only)
    func SelectAns(sender:MyButton){
        
        let index = array.indexOf(sender) ?? 0
        let choiceText = arrayLabel[index]
        
        //老師開始計時 ＆ 計時還沒結束 ， 學生才可以操作
        if eventData.startTime != nil && eventData.timeRemaining ?? 0 > 0{
            API.setEventAnswer(eventData.id, choice: choiceText)
            sender.selected = true
            array.forEach({ $0.enabled = false })
        }
    }
    
    //開始倒數(老師only)
    func play(){
        API.setEventStart(eventData.id)
    }
}

