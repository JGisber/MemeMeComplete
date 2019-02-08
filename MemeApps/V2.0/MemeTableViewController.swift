//
//  ViewController.swift
//  gisberMeme
//
//  Created by Josue Gisber on 2/7/19.
//  Copyright © 2019 Mpixel Design & Development. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    // conform to UITableViewDataSource
    // TODO: how to pass the memelist to this table?
    let memelist = MemeStructor.memeList
	
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memelist.count
    }

    // conform to UITableViewDataSource
    // each cell has the memeimage, and the text
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath)
        // set the data for the cell
        let meme = memelist[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = ("\(meme.upperText!)...\(meme.bottomText!)")
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        cell.accessibilityLabel? = "I am accessibility label"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let detailController = self.storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
      detailController.detailMeme = memelist[indexPath.row]
        detailController.hidesBottomBarWhenPushed = true
        // push so that we can go back
      self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set the title of the navigation bar
        //navigationController?.title = "Sent Meme"
        navigationItem.title = "Sent Meme"
        // Do any additional setup after loading the view.
        let tabItems = self.tabBarController?.tabBar.items
        tabItems?[0].image = UIImage(named: "table")
        tabItems?[0].title = "Table"
        
        tabItems?[1].image = UIImage(named: "collection")
        tabItems?[1].title = "Collection"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(create))
        
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    // nagvigate to the create meme page
    @objc func create() {
       let createVC = storyboard?.instantiateViewController(withIdentifier: "memeCreateView") as! MemeEditorViewController
        createVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(createVC, animated: true)
    }

}
