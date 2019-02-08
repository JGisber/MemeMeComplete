//
//  ViewController.swift
//  gisberMeme
//
//  Created by Josue Gisber on 2/7/19.
//  Copyright © 2019 Mpixel Design & Development. All rights reserved.
//

import Foundation
import UIKit


struct MemeStructor {
    
    let originalImage:UIImage?
    let memedImage:UIImage?
    let upperText:String?
    let bottomText:String?
}

extension MemeStructor {
    
    static var memeList = [MemeStructor]()
    
    static func append(meme:MemeStructor) {
    
        memeList.append(meme)
    
    }
    
}
