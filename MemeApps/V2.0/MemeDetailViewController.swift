//
//  ViewController.swift
//  gisberMeme
//
//  Created by Josue Gisber on 2/7/19.
//  Copyright © 2019 Mpixel Design & Development. All rights reserved.
//

import UIKit

// This will show the Meme image
// with Navigation LeftBarButton "Sent Memes" to go back to the previous navigation stack
// and right button Edit which can navigate to the edit page
class MemeDetailViewController: UIViewController {
    
   // @IBOutlet weak var memeUpper: UILabel!
    @IBOutlet weak var memeImage: UIImageView!
   // @IBOutlet weak var memeBottom: UILabel!
    
    var detailMeme: MemeStructor! // force unwrap - when do we want to do this?
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: Init the detail view
       // memeUpper.text = detailMeme.upperText
        memeImage.image = detailMeme.memedImage
      //  memeBottom.text = detailMeme.bottomText
    }
}
