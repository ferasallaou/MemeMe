//
//  MemesCollectionViewController.swift
//  P2 MemeMe
//
//  Created by Feras Allaou on 1/4/18.
//  Copyright © 2018 Feras Allaou. All rights reserved.
//

import UIKit

class MemesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var layoutFlow: UICollectionViewFlowLayout!


    @IBOutlet weak var memesCollectionView: UICollectionView!
    var memes = [MemeViewController.MemeObj]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addMeme))
        let space:CGFloat = 3
        let mHeight = (view.frame.size.height - (2 * space))
        let mWidth = (view.frame.size.width - (2 * space))
        
        layoutFlow?.minimumInteritemSpacing = space
        layoutFlow?.minimumLineSpacing = space
        layoutFlow?.itemSize = CGSize(width: mWidth/3, height: mHeight/5)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memes = appDelegate.memes
        memesCollectionView.reloadData()
    }
    
    @objc func addMeme(){
        performSegue(withIdentifier: "showMemeSegue", sender: nil)

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let myCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCustomCell", for: indexPath) as! MemeCustomCellCollectionViewCell
        let currentItem = memes[indexPath.row]
        myCustomCell.memeImage.image = currentItem.memedImage.memeImage
        myCustomCell.layer.borderWidth = 1.0
        myCustomCell.layer.borderColor = UIColor.gray.cgColor
        return myCustomCell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 400.0, height: 400.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getItem = self.memes[indexPath.row]
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "imageDetailsVC") as! ImageDetailViewController
        detailsVC.imageURL = getItem.memedImage.memeImage
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

}
