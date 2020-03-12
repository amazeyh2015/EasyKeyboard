//
//  KeyboardManager.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/6.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

public class KeyboardManager {
    
    enum KeyboardEvent: String {
        
        case willShow
        case didShow
        case willHide
        case didHide
    }
    
    var observersInfo: [KeyboardEvent: [KeyboardObservering]] = [:]
    
    public static let shared = KeyboardManager()
    
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
        guard let observers = observersInfo[.willShow] else { return }
        for observer in observers {
            observer.keyboardWillShow(keyboardInfo: keyboardInfo)
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        guard let keyboardInfo = keyboardInfo(in: notification) else { return }
        guard let observers = observersInfo[.didShow] else { return }
        for observer in observers {
            observer.keyboardDidShow(keyboardInfo: keyboardInfo)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let keyboardInfo = keyboardInfo(in: notification) else { return }
        guard let observers = observersInfo[.willHide] else { return }
        for observer in observers {
            observer.keyboardWillHide(keyboardInfo: keyboardInfo)
        }
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        guard let keyboardInfo = keyboardInfo(in: notification) else { return }
        guard let observers = observersInfo[.didHide] else { return }
        for observer in observers {
            observer.keyboardDidHide(keyboardInfo: keyboardInfo)
        }
    }
    
    func keyboardInfo(in notification: Notification) -> KeyboardInfo? {
        guard let userInfo = notification.userInfo else {
            return nil
        }
        let keyboardInfo = KeyboardInfo()
        if let value = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            keyboardInfo.beginFrame = value.cgRectValue
        }
        if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardInfo.endFrame = value.cgRectValue
        }
        if let number = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            keyboardInfo.animationDuration = number.doubleValue
        }
        if let number = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            keyboardInfo.animationCurve = number.intValue
        }
        return keyboardInfo
    }
    
    func index(of observer: KeyboardObservering, in observers: [KeyboardObservering]) -> Int? {
        for (index, item) in observers.enumerated() where item === observer {
            return index
        }
        return nil
    }
    
    func addObserver(_ observer: KeyboardObservering, event: KeyboardEvent) {
        if var observers = observersInfo[event] {
            observers.append(observer)
            observersInfo[event] = observers
        } else {
            observersInfo[event] = [observer]
        }
    }
    
    func removeObserver(_ observer: KeyboardObservering, event: KeyboardEvent) {
        guard var observers = observersInfo[event] else { 
            return 
        }
        if let index = index(of: observer, in: observers) {
            observers.remove(at: index)
            observersInfo[event] = observers
        }
    }
    
    public func addWillShowObserver(_ observer: KeyboardObservering) {
        addObserver(observer, event: .willShow)
    }
    
    public func addDidShowObserver(_ observer: KeyboardObservering) {
        addObserver(observer, event: .didShow)
    }
    
    public func addWillHideObserver(_ observer: KeyboardObservering) {
        addObserver(observer, event: .willHide)
    }
    
    public func addDidHideObserver(_ observer: KeyboardObservering) {
        addObserver(observer, event: .didHide)
    }
    
    public func removeWillShowObserver(_ observer: KeyboardObservering) {
        removeObserver(observer, event: .willShow)
    }
    
    public func removeDidShowObserver(_ observer: KeyboardObservering) {
        removeObserver(observer, event: .didShow)
    }
    
    public func removeWillHideObserver(_ observer: KeyboardObservering) {
        removeObserver(observer, event: .willHide)
    }
    
    public func removeDidHideObserver(observer: KeyboardObservering) {
        removeObserver(observer, event: .didHide)
    }
}
