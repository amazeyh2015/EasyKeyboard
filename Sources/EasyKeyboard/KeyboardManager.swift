//
//  KeyboardManager.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/6.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

public class KeyboardManager {
    
    public static let shared = KeyboardManager()
    
    var observers: NSHashTable<AnyObject> = NSHashTable(options: .weakMemory)
    
    init() {
        let selector1 = #selector(keyboardWillShow(_:))
        let selector2 = #selector(keyboardDidShow(_:))
        let selector3 = #selector(keyboardWillHide(_:))
        let selector4 = #selector(keyboardDidHide(_:))
        
        let name1 = UIResponder.keyboardWillShowNotification
        let name2 = UIResponder.keyboardDidShowNotification
        let name3 = UIResponder.keyboardWillHideNotification
        let name4 = UIResponder.keyboardDidHideNotification
        
        NotificationCenter.default.addObserver(self, selector: selector1, name: name1, object: nil)
        NotificationCenter.default.addObserver(self, selector: selector2, name: name2, object: nil)
        NotificationCenter.default.addObserver(self, selector: selector3, name: name3, object: nil)
        NotificationCenter.default.addObserver(self, selector: selector4, name: name4, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardInfo = keyboardInfo(in: notification) else { return }
        for object in observers.allObjects {
            guard let observer = object as? KeyboardObservering else { continue }
            observer.keyboardWillShow(keyboardInfo: keyboardInfo)
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        guard let keyboardInfo = keyboardInfo(in: notification) else { return }
        for object in observers.allObjects {
            guard let observer = object as? KeyboardObservering else { continue }
            observer.keyboardDidShow(keyboardInfo: keyboardInfo)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let keyboardInfo = keyboardInfo(in: notification) else { return }
        for object in observers.allObjects {
            guard let observer = object as? KeyboardObservering else { continue }
            observer.keyboardWillHide(keyboardInfo: keyboardInfo)
        }
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        guard let keyboardInfo = keyboardInfo(in: notification) else { return }
        for object in observers.allObjects {
            guard let observer = object as? KeyboardObservering else { continue }
            observer.keyboardDidHide(keyboardInfo: keyboardInfo)
        }
    }
    
    func keyboardInfo(in notification: Notification) -> KeyboardInfo? {
        guard let userInfo = notification.userInfo else {
            return nil
        }
        let keyboardInfo = KeyboardInfo()
        if let value = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            keyboardInfo.frameBegin = value.cgRectValue
        }
        if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardInfo.frameEnd = value.cgRectValue
        }
        if let number = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            keyboardInfo.animationDuration = number.doubleValue
        }
        if let number = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            keyboardInfo.animationCurve = number.intValue
        }
        return keyboardInfo
    }
    
    public func addObserver(_ observer: KeyboardObservering) {
        observers.add(observer)
    }
    
    public func removeObserver(_ observer: KeyboardObservering) {
        observers.remove(observer)
    }
}
