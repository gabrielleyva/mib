//
//  ViewController.swift
//  mib2
//
//  Created by Gabriel Leyva Merino on 6/6/18.
//  Copyright © 2018 Gabriel Leyva Merino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var decryptButton: UIButton!
    @IBOutlet weak var transView: UIView!
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        transView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        self.prepareTextView(textView: inputTextView)
        self.prepareTextView(textView: outputTextView)
        self.prepareButton(button: encryptButton, title: "Encrypt")
        self.prepareButton(button: decryptButton, title: "Decrypt")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
        inputTextView.resignFirstResponder()
    }
    
    func prepareButton(button: UIButton, title: String) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(title, for: .normal)
    }
    
    func prepareTextView(textView: UITextView) {
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.cornerRadius = 5
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.textColor = UIColor.white
        textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: "AppleSDGothicNeo-Light"))
    }
    
    @IBAction func ecryptButtonPressed(_ sender: Any) {
        message = inputTextView.text
        encryptButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        spinnerCalled()
        
        var buf = [UInt8](message.utf8)
        
        for i in 0..<buf.count {
            if i % 2 == 0 {
                print(buf[i])
                buf[i] = buf[i] + 1
            } else {
                print(buf[i])
                buf[i] = buf[i] + 2
            }
        }
        
        let encryptMessage =  NSString(bytes: buf, length:buf.count, encoding: String.Encoding.utf8.rawValue)!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.spinner.stopAnimating()
            self.outputTextView.text = encryptMessage as String
        }
        
    }
    @IBAction func decryptButtonPressed(_ sender: Any) {
        message = inputTextView.text
        encryptButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        spinnerCalled()
        
        var buf = [UInt8](message.utf8)
        
        for i in 0..<buf.count {
            if i % 2 == 0 {
                print(buf[i])
                buf[i] = buf[i] - 1
            } else {
                print(buf[i])
                buf[i] = buf[i] - 2
            }
        }
        
        let decryptMessage =  NSString(bytes: buf, length:buf.count, encoding: String.Encoding.utf8.rawValue)!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
            self.spinner.stopAnimating()
            self.outputTextView.text = decryptMessage as String
        }
    }
    
    func spinnerCalled(){
        spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        view.addSubview(spinner)
        spinner.startAnimating()
    }
    
}

