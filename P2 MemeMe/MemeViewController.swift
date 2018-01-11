//
//  MemeViewController.swift
//  P2 MemeMe
//
//  Created by Feras Allaou on 1/2/18.
//  Copyright © 2018 Feras Allaou. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController{

    @IBOutlet weak var buttomToolbar: UIToolbar!
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var upperText: UITextField!
    @IBOutlet weak var lowerText: UITextField!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    var memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -4,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(textfield: [upperText, lowerText],withText: "Enter Your Text")
        shareButtonOutlet.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func saveMeme() -> MemeObj{
        let myMemedImage = memedImage.init(memeImage: generateMemedImage())
        let meme = MemeObj(topText: upperText.text!, lowerText: lowerText.text!, image:mainImageView.image!, memedImage: myMemedImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        return meme
    }
    
    func generateMemedImage() -> UIImage{
        buttomToolbar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        buttomToolbar.isHidden = false
        return memedImage
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        var shareItems: [Any] = []
        let memeImg = generateMemedImage()
        shareItems.append(memeImg)
        let activityShare = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityShare.completionWithItemsHandler = { (activity, success, items, error) in
            if success{
                let savedMeme = self.saveMeme()
                shareItems.append(savedMeme)
                let detailsController = self.storyboard?.instantiateViewController(withIdentifier: "imageDetailsVC") as!ImageDetailViewController
                detailsController.imageURL = savedMeme.memedImage.memeImage
                self.navigationController?.pushViewController(detailsController, animated: true)
            }
        }
        self.present(activityShare, animated: true, completion: nil)
    }
    
    // Let's Handle Image Picker
    @IBAction func captureImage(_ sender: Any) {
        chooseSourceType(chooseType: .camera)
    }
    
    @IBAction func chooseFromGallery(_ sender: Any) {
        chooseSourceType(chooseType: .photoLibrary)
    }
    
    func chooseSourceType(chooseType: UIImagePickerControllerSourceType){
        let imageCapture = UIImagePickerController()
        imageCapture.delegate = self
        imageCapture.sourceType = chooseType
        present(imageCapture, animated: true, completion: nil)
    }

    func configure(textfield: [UITextField], withText: String){
        if textfield.count != 0{
            for textFields in textfield{
                textFields.text = withText
                textFields.defaultTextAttributes = memeTextAttributes
                textFields.textAlignment = .center
                textFields.delegate = self
            }
        }
    }
    
}
