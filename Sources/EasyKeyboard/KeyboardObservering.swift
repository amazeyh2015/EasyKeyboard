//
//  KeyboardObservering.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/6.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

public protocol KeyboardObservering: AnyObject {
    
    func keyboardWillShow(keyboardInfo: KeyboardInfo)
    func keyboardDidShow(keyboardInfo: KeyboardInfo)
    func keyboardWillHide(keyboardInfo: KeyboardInfo)
    func keyboardDidHide(keyboardInfo: KeyboardInfo)
}

public extension KeyboardObservering {
    
    func keyboardWillShow(keyboardInfo: KeyboardInfo) {}
    func keyboardDidShow(keyboardInfo: KeyboardInfo) {}
    func keyboardWillHide(keyboardInfo: KeyboardInfo) {}
    func keyboardDidHide(keyboardInfo: KeyboardInfo) {}
}
