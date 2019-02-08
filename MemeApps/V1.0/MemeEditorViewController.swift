//
//  ViewController.swift
//  gisberMeme
//
//  Created by Josue Gisber on 2/7/19.
//  Copyright © 2019 Mpixel Design & Development. All rights reserved.
//
import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var toolBar: UIToolbar!
    var editMeme:MemeStructor?
    var memedImage: UIImage?
    var editMode:Bool = false
    
    var originalViewHight:CGFloat = 0
    
    // define the text attributes for the Upper and the Buttom text
    let memeTextFormat = TextAttributes()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        subscribeToKeyboardNotifications()
//        topTextField.delegate = self
//        bottomTextField.delegate = self
//        originalViewHight = view.frame.origin.y
//
//
//
//
//        // Initialize the information of the Meme
//        if let editImage = editMeme?.originalImage,
//           let editUpper = editMeme?.upperText,
//           let editBottom = editMeme?.bottomText {
//            imageView.image = editImage
//            topTextField.text = editUpper
//            bottomTextField.text = editBottom
//            // In Edit mode we do not disable the upload button
//            //navigationItem.leftBarButtonItem?.isEnabled = true
//            enableShare(bool: true)
//
//            editMode = true
//
//        }
//
//    }
	
    
    override func viewDidLoad() {
        super.viewDidLoad()
       cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
		memeTextFormat.setUpText(topTextField, defaultValue: "TOP")
		memeTextFormat.setUpText(bottomTextField, defaultValue: "BOTTOM")
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(share))
			enableShare(bool: false)
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancel))
			navigationItem.rightBarButtonItem?.isEnabled = true
		navigationItem.leftBarButtonItem?.isEnabled = true
		            enableShare(bool: true)
		            editMode = true
    }
	
    
    @IBAction func pickAnImage(_ sender: Any) {
        let button = sender as? UIButton
        if button?.titleLabel?.text == "album" {
            print("set the source to album")
            presentImagePickerWith(sourceType: .photoLibrary)
        } else {
            presentImagePickerWith(sourceType: .camera)
        }
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerController methods
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[.originalImage] as? UIImage {
            // set the image to the imageview
            imageView.image = originalImage
            
            // TODO: can also generate the image at this point
            if let image = generateMemedImage() {
                memedImage = image
                enableShare(bool: true)
            }
            
            dismiss(animated: true, completion: nil)
        
        }
        
       
    }
	
	
    func save() {
        let meme = MemeStructor(originalImage: imageView.image!, memedImage: memedImage!, upperText: topTextField.text!, bottomText: bottomTextField.text!)
        MemeStructor.append(meme: meme)
    }
    
    @objc func share() {
        // check if the memedImage is generated, if it is generated we will share the content
        guard memedImage != nil else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, success, returnedItems, activityError) in
            
            if (success) {
                self.save()
                
                // memeTabBarController
                let tableView = self.storyboard?.instantiateViewController(withIdentifier: "memeTabBarController") as! UITabBarController
                self.navigationController?.present(tableView, animated: true, completion: nil)
            }
        }
        present(activityViewController, animated: true, completion: nil)
        // how do we know the sharing is done?
        
        // TODO we navigate here to the tab controller?
    }
    
    @objc func cancel() {
        print("cancel")
        navigationController?.popViewController(animated: true)
    }
    
    func generateMemedImage() -> UIImage? {
        guard let _ = imageView.image else {
            return nil
        }
		
        // Hide toolbar and navbar
        hideTopAndButtomBar(hide:true)
		
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
		
        // Show toolbar and navbar
        hideTopAndButtomBar(hide:false)
        return memedImage
    }
    
    func hideTopAndButtomBar(hide:Bool) {
        toolBar.isHidden = hide
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
    }
    
    func enableShare(bool:Bool) {
        navigationItem.leftBarButtonItem?.isEnabled = bool
    }
    
    
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    @objc func dismissKeyboard() {
//        print("tap around to dismiss keyboard!")
//        view.endEditing(true)
//        view.frame.origin.y = self.originalViewHight
//
//        if let image = generateMemedImage() {
//            memedImage = image
//            enableShare(bool: true)
//        }
//    }
	
    // MARK: UITextFieldDelegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // TODO: Clear the textfield content
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
    
    // Limit the width is not more than the current view's width
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
		_ = oldText.replacingCharacters(in: range, with: string)
        
        return true
    }
    
    // If user presses return button, generate the memed image and enable the share button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        view.frame.origin.y = originalViewHight
        if let image = generateMemedImage() {
            memedImage = image
            enableShare(bool: true)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
}


