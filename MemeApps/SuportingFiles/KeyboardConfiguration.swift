//
//  KeyboardConfiguration.swift
//  MemeApps
//
//  Created by Josue Gisber on 2/8/19.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorViewController {
	
	@objc func keyboardWillShow(_ notification: NSNotification) {
		if topTextField.isEditing {
			view.frame.origin.y = 0
		} else {
			view.frame.origin.y = -getKeyboardHeight(notification)
		}
	}
	
	@objc func keyboardWillHide(_ notification: NSNotification) {
		view.frame.origin.y = 0
	}
	
	func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
		let userInfo = notification.userInfo
		let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
		return keyboardSize.cgRectValue.height
	}
	
	func subscribeToKeyboardNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		subscribeToKeyboardNotification()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		subscribeToKeyboardNotification()
	}
}
