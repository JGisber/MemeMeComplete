//
//  TextFormat.swift
//  MemeApps
//
//  Created by Josue Gisber on 2/7/19.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation
import UIKit

class TextAttributes: UIViewController, UITextFieldDelegate {
	
	let textAttributes: [NSAttributedString.Key: Any] = [
		.strokeWidth: -3.5,
		.strokeColor: UIColor.black,
		.foregroundColor: UIColor.white,
		.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
	]
	
	let paragraphStyle = NSMutableParagraphStyle()
	
	// MARK: - Format Font text for the textfield
	
	func setUpText(_ text: UITextField, defaultValue: String) {
		text.defaultTextAttributes = textAttributes
		text.delegate = self
		text.text = defaultValue
		text.textAlignment = .center
		
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		return true
	}
	
	// MARK: - Erase default text on tap
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.text = nil
	}
	
	// MARK: - Allow editing textfield
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		return true
	}

	
}
