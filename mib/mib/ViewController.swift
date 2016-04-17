//
//  ViewController.swift
//  mib
//
//  Created by Gabriel I Leyva Merino on 4/16/16.
//  Copyright © 2016 Gabriel Leyva Merino. All rights reserved.
//

import UIKit
import Security



class ViewController: UIViewController {
    @IBOutlet weak var messageView: UITextView!
    @IBOutlet weak var decryptButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var transView: UIView!
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    var message = ""
    
    
    @IBOutlet weak var encryptButton: UIButton!
    
override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.whiteColor().CGColor
        textView.layer.cornerRadius = 5
        textView.layer.backgroundColor = UIColor.clearColor().CGColor
        textView.textColor = UIColor.whiteColor()
        textView.font = UIFont.preferredFontForTextStyle("AppleSDGothicNeo-Light")
        
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.whiteColor().CGColor
        messageView.layer.cornerRadius = 5
        messageView.layer.backgroundColor = UIColor.clearColor().CGColor
        messageView.font = UIFont.preferredFontForTextStyle("AppleSDGothicNeo-Light")
        messageView.textColor = UIColor.whiteColor()
        
    
        encryptButton.layer.borderWidth = 1
        encryptButton.layer.borderColor = UIColor.whiteColor().CGColor
        encryptButton.layer.cornerRadius = 5
        encryptButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        decryptButton.layer.borderWidth = 1
        decryptButton.layer.borderColor = UIColor.whiteColor().CGColor
        decryptButton.layer.cornerRadius = 5
        decryptButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        transView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        
                


        
    }
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        textView.resignFirstResponder()
    
    }
    
@IBAction func encryptButtonPressed(sender: AnyObject) {
    
        message = textView.text
        encryptButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        spinnerCalled()
    
        var buf = [UInt8](message.utf8)
        
        for (var i = 0; i < buf.count; ++i){
            
            if ( i % 2 == 0) {
            
            buf[i] = buf[i] + 1
                
            } else {
                
                buf[i] = buf[i] + 2
            }
            
        }
    
        
    let encryptMessage =  NSString(bytes: buf, length:buf.count, encoding: NSUTF8StringEncoding)!
    
    let delay = 1 * Double(NSEC_PER_SEC)
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    
    
    dispatch_after(time, dispatch_get_main_queue()) {
        self.spinner.stopAnimating()
        self.messageView.text = encryptMessage as String
    }
    
    
        
    }
    
@IBAction func decryptButtonPressed(sender: AnyObject) {
        
        
        message = textView.text
        encryptButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        spinnerCalled()
    
        var buf = [UInt8](message.utf8)
    
        
        for (var i = 0; i < buf.count; ++i){
            
            
            if ( i % 2 == 0) {
                
                buf[i] = buf[i] - 1
                
            } else {
                
                buf[i] = buf[i] - 2
            }
            
        }
        
    let decryptMessage =  NSString(bytes: buf, length:buf.count, encoding: NSUTF8StringEncoding)!
        
    let delay = 1 * Double(NSEC_PER_SEC)
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    
    
    dispatch_after(time, dispatch_get_main_queue()) {
        self.spinner.stopAnimating()
        self.messageView.text = decryptMessage as String
    }
    
        
        
    }
    
    
    //creates spinners
func spinnerCalled(){
        
        spinner = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        view.addSubview(spinner)
        spinner.startAnimating()
        
        
        
    }
    
}

