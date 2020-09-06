//
//  DetailViewController.swift
//  Mareco
//
//  Created by JAN FREDRICK on 06/09/20.
//  Copyright © 2020 JFSK. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController : UIViewController, UIScrollViewDelegate {
    
    var showType = ""
    var nameOfImage = ""
    
    var scrollView : UIScrollView!
    var imageView : UIImageView!
    var playerView : UIView!
    var video : AVPlayer!
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .black
        
        if fSH >= 812 {
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 40 + 50, width: Int(fSW), height: Int(fSH) - 40 - 50 - bSA))
            playerView = UIView(frame: scrollView.frame)
        }else {
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 20 + 50, width: Int(fSW), height: Int(fSH) - 20 - 50))
            playerView = UIView(frame: scrollView.frame)
        }
        view.addSubview(scrollView)
        view.addSubview(playerView)
        
        if showType == "image" {
            scrollView.isHidden = false
            playerView.isHidden = true
            
            setupViewForImage()
            
        }else{
            scrollView.isHidden = true
            playerView.isHidden = false
            
            setupViewForVideo(inView: playerView)
        }
        
    }
    
    func setupViewForImage() {
        
        scrollView.delegate = self
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: fSW, height: scrollView.frame.height))
        scrollView.addSubview(imageView)
        
        if let a = UIImage(named: "\(nameOfImage)-large") {
            imageView.image = a
        }else{
            imageView.image = UIImage(named: nameOfImage)
        }
        
        imageView.contentMode = .scaleAspectFit
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setupViewForVideo(inView: UIView) {
        
        let buttonImage = UIButton(frame: CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height))
        inView.addSubview(buttonImage)
        
        if let a = UIImage(named: "\(nameOfImage)-large") {
            buttonImage.setBackgroundImage(a, for: .normal)
        }else{
            buttonImage.setBackgroundImage(UIImage(named: nameOfImage), for: .normal)
        }
        
        buttonImage.setImage(UIImage(named: "play24px"), for: .normal)
    }
    
    @IBAction func backNow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
