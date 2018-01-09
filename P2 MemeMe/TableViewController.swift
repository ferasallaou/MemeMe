//
//  TableViewController.swift
//  P2 MemeMe
//
//  Created by Feras Allaou on 1/2/18.
//  Copyright © 2018 Feras Allaou. All rights reserved.
//

import UIKit

class TableViewController: UIViewController{
 
    @IBOutlet weak var memesTable: UITableView!
    var memes = [MemeViewController.MemeObj]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memes = appDelegate.memes
        memesTable.reloadData()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self,action: #selector(newMeme))
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action: ("newMeme"))
//        // Do any additional setup after loading the view, typically from a nib.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    @objc func newMeme(){
        //let photoPickerController = self.storyboard?.instantiateViewController(withIdentifier: "MemeVC")
        
        performSegue(withIdentifier: "showMemeSegue", sender: nil)
    }
    
  

}

