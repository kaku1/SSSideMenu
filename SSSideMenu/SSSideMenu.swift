    //
    //  SSSideMenu.swift
    //  Bounce
    //
    //  Created by Siddhant Saxena on 27/03/18.
    //  Copyright © 2018 Siddhant Saxena. All rights reserved.
    //

import UIKit

public class SSSideMenu: UIView {

    var lastLocation = CGPoint(x: 0, y: 0)
    var translationPoint: Int = Int()
    let closeButton: UIButton = UIButton()

    public override func awakeFromNib() {
        super.awakeFromNib()
        //----Pen renRecognizer for sidemenu
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(self.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
    }

    public func showSideMenu(superView: UIViewController){
        //----add button to close view on tap
        closeButton.setTitle(" ", for: UIControlState.normal)
        closeButton.backgroundColor = UIColor.init(rgbValue: 0x25265E, alpha: 0.2)
        closeButton.alpha = 0
        closeButton.frame = CGRect.init(x: 0, y: 0, width: superView.view.frame.size.width, height: superView.view.frame.size.height)
        closeButton.addTarget(self, action: #selector(self.closeButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
        superView.view.addSubview(closeButton)

        //----add sidemenu
        self.frame = CGRect.init(x: 0, y: 0, width: superView.view.frame.size.width - 90, height: superView.view.frame.size.height)
        //sideMenubody.setCardBorderAndShadow(color: .black, opacity: 1, offSet: CGSize(width: 0, height: 4), radius: 24, scale: true, cardRadius: 10)
        self.frame.origin.x = -superView.view.frame.size.width
        self.roundCorners([.topRight, .bottomRight], radius: 10)
        superView.view.addSubview(self)

        //----bounce side menu
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: ({
            self.frame.origin.x = -15
            self.closeButton.alpha = 1
        }), completion: nil)
    }

    @objc func closeButtonTapped(sender: UIButton!){
    removeViewFromSuperView()
    }

    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        //setting value of transition from begining
        let translation  = recognizer.translation(in: self.superview)
        translationPoint = Int(lastLocation.x + translation.x)
        //logic on translation
        if self.frame.origin.x <= -15{
            self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y)
        }
        if recognizer.state == UIGestureRecognizerState.ended {
            if self.frame.origin.x <= -(self.frame.size.width/4){
                removeViewFromSuperView()
            }
            else{
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: ({
                    self.frame.origin.x = -15
                }), completion: nil)
            }

        }
    }

    func removeViewFromSuperView(){
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: ({
            self.frame.origin.x = -self.frame.size.width
            self.closeButton.alpha = 0
        }), completion: {(finished:Bool) in
            self.removeFromSuperview()
            self.closeButton.removeFromSuperview()
        })
    }

    override public func touchesBegan(_ touches: (Set<UITouch>!), with event: UIEvent!) {
        lastLocation = self.center
    }

}
