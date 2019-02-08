//
//  ViewController.swift
//  gisberMeme
//
//  Created by Josue Gisber on 2/7/19.
//  Copyright © 2019 Mpixel Design & Development. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    
    let memelist = MemeStructor.memeList
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(create))
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        collectionView?.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationItem.title = "Sent Meme"
        
        self.tabBarItem.image = UIImage(named: "collection")
        self.tabBarItem.title = "Collection"
        
        let space:CGFloat = 3.0
        //  TODO: Test in Landscape mode
        // when in landscape,  this calculation is not appropriate
        // maybe the solution is detect the device mode and use height to calculate the dimension
        let orientation = UIDevice.current.orientation
        let dimension = UIDeviceOrientation.portrait == orientation ? ((view.frame.size.width - (2 * space)) / 3.0) : ((view.frame.size.height - (2 * space)) / 3.0)
        //let dimension = (view.frame.size.width - (2 * space)) / 3.0
        print("Dimension is \(dimension)")
        //let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowlayout.minimumInteritemSpacing = space
        flowlayout.minimumLineSpacing = space
        flowlayout.itemSize = CGSize(width: dimension, height: dimension)
  
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    // nagvigate to the create meme page
    @objc func create() {
        let createVC = storyboard?.instantiateViewController(withIdentifier: "memeCreateView") as! MemeEditorViewController
        createVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(createVC, animated: true)
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memelist.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
        // TODO: Configure the cell
        if (memelist.count > 0) {
            let meme = memelist[indexPath.row]
            cell.memeImage?.image = meme.memedImage
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
        detailController.detailMeme = memelist[indexPath.row]
        detailController.hidesBottomBarWhenPushed = true
        // push so that we can go back
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
