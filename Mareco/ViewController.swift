//
//  ViewController.swift
//  Mareco
//
//  Created by JAN FREDRICK on 06/09/20.
//  Copyright © 2020 JFSK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageArray : NSMutableArray! = []
    
    //let asd = [["name": "1", "type": "image"] as! NSDictionary, ["name": "2", "type": "video"] as! NSDictionary, ["name": "3", "type": "image" as! NSDictionary], ["name": "4", "type": "video"] as! NSDictionary, ["name": "5", "type": "image"] as! NSDictionary, ["name": "6", "type": "image"] as! NSDictionary, ["name": "7", "type": "image"] as! NSDictionary]
    
    let oriArrayObjects = [["name": "1", "type": "image"] as NSDictionary, ["name": "2", "type": "video"] as NSDictionary, ["name": "3", "type": "image"] as NSDictionary, ["name": "4", "type": "image"] as NSDictionary, ["name": "5", "type": "image"] as NSDictionary, ["name": "6", "type": "image"] as NSDictionary, ["name": "7", "type": "image"] as NSDictionary]//["1", "2", "3", "4", "5", "6", "7"]

    var scrollView: UIScrollView!
    
    var viewGallery, viewPhoto : UIView!
    var buttonNewImage : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageArray.addObjects(from: oriArrayObjects)
        
        if fSH >= 812 {
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 40 + 50, width: Int(fSW), height: Int(fSH) - 40 - 50 - bSA))
            viewGallery = UIView(frame: CGRect(x: Int(fSW - 100), y: Int(fSH) - bSA - 100, width: 80, height: 80))
        }else {
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 20 + 50, width: Int(fSW), height: Int(fSH) - 20 - 50))
            viewGallery = UIView(frame: CGRect(x: Int(fSW - 100), y: Int(fSH - 100), width: 80, height: 80))
        }
        view.addSubview(scrollView)
        view.addSubview(viewGallery)
        
        //viewGallery.backgroundColor = .systemRed
        
        let galB = UIButton(frame: CGRect(x: 20, y: 20, width: 40, height: 40))
        viewGallery.addSubview(galB)
        
        galB.backgroundColor = .systemBlue
        galB.layer.cornerRadius = 20.0
        galB.layer.masksToBounds = true
        galB.setImage(UIImage(named: "image"), for: .normal)
        
        viewPhoto = UIView(frame: viewGallery.frame)
        view.addSubview(viewPhoto)
        
        //viewPhoto.backgroundColor = .systemGray
        
        let phoB = UIButton(frame: CGRect(x: 20, y: 20, width: 40, height: 40))
        viewPhoto.addSubview(phoB)
        
        phoB.backgroundColor = .systemBlue
        phoB.layer.cornerRadius = 20.0
        phoB.layer.masksToBounds = true
        phoB.setImage(UIImage(named: "camera"), for: .normal)
        
        buttonNewImage = UIButton(frame: viewPhoto.frame)
        view.addSubview(buttonNewImage)
        
        buttonNewImage.backgroundColor = UIColor.systemBlue
        buttonNewImage.setImage(UIImage(named: "add"), for: .normal)
        buttonNewImage.addTarget(self, action: #selector(show2Bs(sender:)), for: .touchUpInside)
        buttonNewImage.layer.masksToBounds = true
        buttonNewImage.layer.cornerRadius = 40.0
        
        refillScrollView(sView: scrollView)
        
        
        
    }
    
    @objc func show2Bs(sender: UIButton) {
        if sender.imageView!.image == UIImage(named: "close") {
            sender.setImage(UIImage(named: "add"), for: .normal)
            
            UIView.animate(withDuration: 0.5) {
                self.viewPhoto.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y, width: 80, height: 80)
                self.viewGallery.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y, width: 80, height: 80)
            }
            
        }else{
            sender.setImage(UIImage(named: "close"), for: .normal)
            
            UIView.animate(withDuration: 0.5) {
                self.viewPhoto.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y - 80, width: 80, height: 80)
                self.viewGallery.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y - 140, width: 80, height: 80)
            }
        }
    }
    
    func refillScrollView(sView: UIScrollView) {
        
        for subview in sView.subviews {
            subview.removeFromSuperview()
        }
        
        var originX : CGFloat = 0
        var originY : CGFloat = 0
        let cellLength : CGFloat = fSW/3
        
        for i in 0..<imageArray.count {
            
            let nextIB = CustomIB(frame: CGRect(x: originX, y: originY, width: cellLength, height: cellLength))
            sView.addSubview(nextIB)
            
            let dict = imageArray[i] as! NSDictionary
            
            nextIB.imageName = dict["name"] as? String
            nextIB.type = dict["type"] as? String
            nextIB.setBackgroundImage(UIImage(named: dict["name"] as! String), for: .normal)
            if nextIB.type == "video" {
                nextIB.setImage(UIImage(named: "play24px"), for: .normal)
                nextIB.contentMode = .scaleToFill
            }
            nextIB.tag = i
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toBigView(gesture:)))  //Tap function will call when user tap on button
            let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(deleteCell(gesture:)))  //Long function will call when user long press on button.
            tapGesture.numberOfTapsRequired = 1
            longGesture.minimumPressDuration = 1.2
            nextIB.addGestureRecognizer(tapGesture)
            nextIB.addGestureRecognizer(longGesture)
            
            if (i+1)%3 == 0 {
                originY += cellLength
                originX = 0
            }else{
                originX += cellLength
            }
            
        }
        
    }
    
    @objc func deleteCell(gesture: UIGestureRecognizer) {
        print("long tap")
        
        let sender = gesture.view as! CustomIB
        
        let alert = UIAlertController(title: "Delete?", message: "Continue to delete?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (aAction) in
            self.deleteImage(with: sender.tag)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func deleteImage(with index: Int) {
        imageArray.removeObject(at: index)
        refillScrollView(sView: scrollView)
    }
    
    var typeToSend = "video"
    var imageToSend = ""
    
    @objc func toBigView(gesture: UIGestureRecognizer) {
        print("tap")
        
        let sender = gesture.view as! CustomIB
        
        typeToSend = sender.type
        imageToSend = sender.imageName
        
        performSegue(withIdentifier: "to_detail_view", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "to_detail_view" {
            let nvc = segue.destination as! DetailViewController
            nvc.showType = typeToSend
            nvc.nameOfImage = imageToSend
        }
        
    }

}

class CustomIB : UIButton {
    var imageName: String!
    var type: String!
}

class CustomGalleryCell : UICollectionViewCell {
    
    var cImageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: fSW/3, height: fSW/3))
        contentView.addSubview(cImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

let fSW = UIScreen.main.bounds.width
let fSH = UIScreen.main.bounds.height
let bSA = 34
