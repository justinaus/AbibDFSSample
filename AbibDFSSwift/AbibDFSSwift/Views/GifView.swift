//
//  GifCControl.swift
//  AbibDFSSwift
//
//  Created by Bonkook Koo on 2017. 7. 1..
//  Copyright © 2017년 abib. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class GifView: UIImageView, UIGestureRecognizerDelegate {
    
    //private var gifImageView:UIImageView?
    private var gifTabGestureRecog:UITapGestureRecognizer?;
    
    public func show( width:Float, height:Float ,animated:Bool ) {
        // An animated UIImage
        let jeremyGif = UIImage.gif(name: "881")
        
        // A UIImageView with async loading
        //let imageView = UIImageView()
        //imageView.loadGif(name: "jeremy")
        
        image = jeremyGif;
        frame = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height));
        isUserInteractionEnabled = true;
        
//        uiView.addSubview(gifImageView!);
//        
//        gifImageView?.isUserInteractionEnabled = true;
        
        
        
        //        func makeTapGesture() {
        //            gifTabGestureRecog = UITapGestureRecognizer(target: self, action: #selector(self.tapGif(_:)));
        //            gifTabGestureRecog!.delegate = self;
        //            gifImageView!.addGestureRecognizer(gifTabGestureRecog!);
        //        }
        //
        //        if( animated ) {
        //            gifImageView?.alpha = 0;
        //            gifImageView?.isHidden = false;
        //
        //            UIView.animate(withDuration: 0.25,
        //                           delay: 0.0,
        //                           options: UIViewAnimationOptions.curveEaseInOut,
        //                           animations: {
        //                            self.gifImageView?.alpha = 1;
        //            }, completion: { finished in
        //                makeTapGesture();
        //            });
        //            
        //        } else {
        //            makeTapGesture();
        //        }
    }
    
}
