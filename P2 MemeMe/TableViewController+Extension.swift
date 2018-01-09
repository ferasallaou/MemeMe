//
//  tableViewExtension.swift
//  P2 MemeMe
//
//  Created by Feras Allaou on 1/8/18.
//  Copyright © 2018 Feras Allaou. All rights reserved.
//

import Foundation
import UIKit

extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "memesCell")
        let getCurrentItem = memes[indexPath.row]
        myCell?.textLabel?.text = getCurrentItem.topText
        myCell?.detailTextLabel?.text = getCurrentItem.lowerText
        myCell?.imageView?.image = getCurrentItem.image
        return myCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prepareItem = memes[indexPath.row]
        let getDetailsController = self.storyboard?.instantiateViewController(withIdentifier:"imageDetailsVC") as! ImageDetailViewController
        getDetailsController.imageURL = prepareItem.memedImage.memeImage
        self.navigationController?.pushViewController(getDetailsController, animated: true)
    }
}
