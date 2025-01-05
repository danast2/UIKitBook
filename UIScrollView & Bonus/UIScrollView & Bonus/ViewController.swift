//
//  ViewController.swift
//  UIScrollView & Bonus
//
//  Created by Даниил Асташов on 05.01.2025.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var myScrollView = UIScrollView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newScreenForUIImageView = UIImage(named: "new_screen_for_UIImageView.png")
        let vinil = UIImage(named: "vinil.png")
        let speaker = UIImage(named: "speaker.png")
        let scrollViewRect = self.view.bounds
        
        //create scroll
        self.myScrollView = UIScrollView(frame: scrollViewRect)
        self.myScrollView.isPagingEnabled = true
        self.myScrollView.contentSize = CGSize(width: scrollViewRect.size.width * 3, height: scrollViewRect.size.height)
        self.view.addSubview(self.myScrollView)
        
        //create screenShot
        var imageViewRect = self.view.bounds
        let screenShotImageView = self.newImageViewWithImage(paramImage: newScreenForUIImageView!, paramFrame: imageViewRect)
        self.myScrollView.addSubview(screenShotImageView)
        
        //next page
        imageViewRect.origin.x += imageViewRect.size.width
        let speakerImageView = self.newImageViewWithImage(paramImage: speaker!, paramFrame: imageViewRect)
        self.myScrollView.addSubview(speakerImageView)
        
        //next page
        imageViewRect.origin.x += imageViewRect.size.width
        let vinilImageView = self.newImageViewWithImage(paramImage: vinil!, paramFrame: imageViewRect)
        self.myScrollView.addSubview(vinilImageView)
    }
    
    func newImageViewWithImage(paramImage: UIImage, paramFrame: CGRect) -> UIImageView {
        let result = UIImageView(frame: paramFrame)
        result.contentMode = .scaleAspectFit
        result.image = paramImage
        return result
    }

}

