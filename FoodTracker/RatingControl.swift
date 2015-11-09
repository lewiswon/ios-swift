//
//  RatingControl.swift
//  FoodTracker
//
//  Created by LuoLewis on 15/11/5.
//  Copyright © 2015年 LuoLewis. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    var rating=0{
        didSet{
            setNeedsLayout()
        }
    }
    var stars=5
    var specing=5
    var ratingButtons=[UIButton]()
//MARK: Initialization

    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
        let filledStarImage=UIImage(named: "filledStar")
        let emptyStartImage=UIImage(named:"emptyStar")
        
        for _ in 0..<stars{
            
            let button=UIButton(frame: CGRect(x:0,y:0,width:44,height:44))
            button.setImage(emptyStartImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted,.Selected])
            button.adjustsImageWhenHighlighted=false
            button.addTarget(self, action: "ratingButtonTaped:", forControlEvents: .TouchDown)
            ratingButtons+=[button]
            addSubview(button)
        }
       
        
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize=Int(frame.size.height)
        let width=(buttonSize+5)*specing
        return CGSize(width: width-specing, height:buttonSize)
    }
    
//MARK: Button Action
    func ratingButtonTaped(button: UIButton){
      
        print("Button pressed")
        rating=ratingButtons.indexOf(button)! + 1
        updateButtonSlectionStates()
        
        
    }
    override func layoutSubviews() {
        let buttonSize=Int(frame.size.height)
        
        var buttonFrame=CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
       
        for(index, button) in ratingButtons.enumerate(){
            buttonFrame.origin.x=CGFloat(index*(buttonSize+specing))
            button.frame=buttonFrame
        }
        
        updateButtonSlectionStates()
    }
    
    func updateButtonSlectionStates(){
        for(index,button) in ratingButtons.enumerate(){
        
                button.selected=index<rating
        }
        
    }

}
