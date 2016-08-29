//
//  KeyboardViewController.swift
//  Appcoda Keyboard
//
//  Created by Joyce Echessa on 10/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet weak var qKey: UIButton!
    @IBOutlet weak var wKey: UIButton!
    @IBOutlet weak var eKey: UIButton!
    @IBOutlet weak var rKey: UIButton!
    @IBOutlet weak var tKey: UIButton!
    @IBOutlet weak var yKey: UIButton!
    @IBOutlet weak var uKey: UIButton!
    @IBOutlet weak var iKey: UIButton!
    @IBOutlet weak var oKey: UIButton!
    @IBOutlet weak var pKey: UIButton!
    
    @IBOutlet weak var aKey: UIButton!
    @IBOutlet weak var sKey: UIButton!
    @IBOutlet weak var dKey: UIButton!
    @IBOutlet weak var fKey: UIButton!
    @IBOutlet weak var gKey: UIButton!
    @IBOutlet weak var hKey: UIButton!
    @IBOutlet weak var jKey: UIButton!
    @IBOutlet weak var kKey: UIButton!
    @IBOutlet weak var lKey: UIButton!
    
    @IBOutlet weak var zKey: UIButton!
    @IBOutlet weak var xKey: UIButton!
    @IBOutlet weak var cKey: UIButton!
    @IBOutlet weak var vKey: UIButton!
    @IBOutlet weak var bKey: UIButton!
    @IBOutlet weak var nKey: UIButton!
    @IBOutlet weak var mKey: UIButton!
    
    //second page
    
    @IBOutlet weak var keyboardView: UIView!
    
    
    var capsLockOn = true
    
    var delChar = "0"
    
    var last20Chars: String = ""
    
    var equivalents = [String: String]()
    
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NewKeyboardView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        view = objects[0] as! UIView;
        
        applyHoverShadow(qKey)
        applyHoverShadow(wKey)
        applyHoverShadow(eKey)
        applyHoverShadow(rKey)
        applyHoverShadow(tKey)
        applyHoverShadow(yKey)
        applyHoverShadow(uKey)
        applyHoverShadow(iKey)
        applyHoverShadow(oKey)
        applyHoverShadow(pKey)
        
        applyHoverShadow(aKey)
        applyHoverShadow(sKey)
        applyHoverShadow(dKey)
        applyHoverShadow(fKey)
        applyHoverShadow(gKey)
        applyHoverShadow(hKey)
        applyHoverShadow(jKey)
        applyHoverShadow(kKey)
        applyHoverShadow(lKey)
        
        applyHoverShadow(zKey)
        applyHoverShadow(xKey)
        applyHoverShadow(cKey)
        applyHoverShadow(vKey)
        applyHoverShadow(bKey)
        applyHoverShadow(nKey)
        applyHoverShadow(mKey)

        //charSet2.hidden = true
        
        for (var i = 0; i < 20; i++){
            last20Chars += "0"
        }
    }
    
    
    @IBAction func moreCharacters(sender: AnyObject) {
        
        for view in self.keyboardView.subviews as [UIView] {
            if let btn = view as? UIButton {
                if (btn.hidden){
                    btn.hidden = false
                }
                else {
                    if (btn.tag == 6){
                        btn.hidden = true
                    }
                }
            }
        }
        
    }
    
    @IBAction func nextKeyboardPressed(button: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(row1)
        changeCaps(row2)
        changeCaps(row3)
        changeCaps(row4)
    }
    
    @IBAction func evenMoreCharacters(sender: AnyObject) {
    }
    @IBAction func keyPressed(button: UIButton) {
        
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        
        last20Chars = String(last20Chars.characters.dropFirst())
        last20Chars += string!
        
        
        if (last20Chars.rangeOfString(" @= ") != nil && last20Chars.rangeOfString(">") != nil && last20Chars.rangeOfString("<") != nil) {
            //(textDocumentProxy as UIKeyInput).insertText("yes")
//            (textDocumentProxy as UIKeyInput).insertText("\nSTART INDEX: \(last20Chars.rangeOfString("<")!.startIndex)")
//            (textDocumentProxy as UIKeyInput).insertText("\nEND INDEX: \(last20Chars.rangeOfString(">")!.startIndex)")
//            (textDocumentProxy as UIKeyInput).insertText(last20Chars[(Int(last20Chars.rangeOfString("<")!.startIndex.distanceTo(last20Chars.characters.indexOf(last20Chars[0])!)) + 1)...(last20Chars.rangeOfString(" @= ")!.startIndex.distanceTo(last20Chars.characters.indexOf(last20Chars[0])!) + 1)])
            //(textDocumentProxy as UIKeyInput).insertText(last20Chars.substringWithRange(Range<String.Index>(start: last20Chars.rangeOfString("<")!.startIndex, end: last20Chars.rangeOfString(">")!.startIndex)))
            let setStr = (last20Chars.substringWithRange(Range<String.Index>(start: last20Chars.rangeOfString("<")!.startIndex, end: last20Chars.rangeOfString(">")!.startIndex)))[1...((last20Chars.substringWithRange(Range<String.Index>(start: last20Chars.rangeOfString("<")!.startIndex, end: last20Chars.rangeOfString(">")!.startIndex))).characters.count - 1)]
            //(textDocumentProxy as UIKeyInput).insertText("\(setStr)")
            let varSetArr = setStr.componentsSeparatedByString(" @= ")
            let varName = varSetArr[0]
            let varVal = varSetArr[1]
            
            equivalents[varName] = varVal
            
            //(textDocumentProxy as UIKeyInput).insertText("\(varName) should be equal to \(varVal)")
        }
        else {
            //(textDocumentProxy as UIKeyInput).insertText("\n [\(last20Chars)]")
        }
        
        for (name, val) in equivalents {
            //(textDocumentProxy as UIKeyInput).insertText("Test: \(equivalents[name]!)")
            if (last20Chars[(20 - (name.characters.count))...19] == name){
                //(textDocumentProxy as UIKeyInput).insertText("IF: \(equivalents[name]!)")
                for (var i = 0; i < (name.characters.count); i++){
                    (textDocumentProxy as UIKeyInput).deleteBackward()
                }
                (textDocumentProxy as UIKeyInput).insertText(equivalents[name]!)
            }
            else {
                //(textDocumentProxy as UIKeyInput).insertText("\n\(last20Chars[(20 - (name.characters.count))...19]) != ")
                //(textDocumentProxy as UIKeyInput).insertText("\n\(name)")
            }
        }

        
        if (last20Chars[17...19].lowercaseString == "dog") {
            for (var i = 0; i < 3; i++){
                (textDocumentProxy as UIKeyInput).deleteBackward()
            }
            (textDocumentProxy as UIKeyInput).insertText("🐶")
        }
        
        
        //print(last20Chars)
        
        UIView.animateWithDuration(0.02, animations: {
            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
            }, completion: {(_) -> Void in
                button.transform =
                    CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
        })
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
        delChar = last20Chars[0]
        last20Chars = "0" + String(last20Chars.characters.dropLast())
    }
    
    @IBAction func spacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
        last20Chars = String(last20Chars.characters.dropFirst())
        last20Chars += " "
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func charSetPressed(button: UIButton) {
        if button.titleLabel!.text == "1/2" {
            //charSet1.hidden = true
            //charSet2.hidden = false
            button.setTitle("2/2", forState: .Normal)
        } else if button.titleLabel!.text == "2/2" {
            //charSet1.hidden = false
            //charSet2.hidden = true
            button.setTitle("1/2", forState: .Normal)
        }
    }
    var capsState = 1
    
    @IBAction func capsToggle(sender: AnyObject) {
        
        if (capsState == 1) {
            for view in self.keyboardView.subviews as [UIView] {
                if let btn = view as? UIButton {
                    if (btn.tag == 6) {
                        btn.titleLabel?.text = btn.titleLabel?.text?.lowercaseString
                        capsState = 0
                    }
                }
            }
        }
        else {
            for view in self.keyboardView.subviews as [UIView] {
                if let btn = view as? UIButton {
                    if (btn.tag == 6) {
                        btn.titleLabel?.text = btn.titleLabel?.text?.uppercaseString
                        capsState = 1
                    
                    }
                }
            }
        }
        
        

    }
    
    func applyHoverShadow(view: UIView) {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        
        let ovalRect = CGRect(x: 5, y: height + 0.5, width: width - 10, height: 4)
        let path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
        
        let layer = view.layer
        layer.shadowPath = path.CGPath
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func applyPlainShadow(view: UIView) {
        let layer = view.layer
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 0.4)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
    }
    
    func changeCaps(containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercaseString
                    button.setTitle("\(text)", forState: .Normal)
                } else {
                    let text = buttonTitle!.lowercaseString
                    button.setTitle("\(text)", forState: .Normal)
                }
            }
        }
    }
    
}
