//
//  VideoView.swift
//  AbibDFSSwift
//
//  Created by Bonkook Koo on 2017. 7. 4..
//  Copyright © 2017년 abib. All rights reserved.
//

import UIKit
import AVFoundation

class VideoView : UIView, UIGestureRecognizerDelegate {
    var player:AVQueuePlayer?;
    var playerLayer:AVPlayerLayer?;
    var playerLooper:AVPlayerLooper?;
    
    var tapGestureRecognizers:UITapGestureRecognizer?
    
    var delegate:UIViewDelegate? = nil;
    
    init(rect:CGRect, url:URL) {
        super.init(frame: rect);
        
        let playerItem = AVPlayerItem(url: url)
        
        player = AVQueuePlayer(items: [playerItem])
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer!.frame = rect;
        
        playerLooper = AVPlayerLooper(player: player!, templateItem: playerItem)
                
        layer.addSublayer(playerLayer!)
        
        backgroundColor = UIColor.white;
    }
    
    public func show( _ animated:Bool ) {
        func onComplete() {
            tapGestureRecognizers = UITapGestureRecognizer(target: self, action: #selector(self.taped(_:)));
            tapGestureRecognizers!.delegate = self;
            addGestureRecognizer(tapGestureRecognizers!);
        }
        
        if( animated ) {
            alpha = 0;
            isHidden = false;

            UIView.animate(withDuration: 0.25,
                            delay: 0.0,
                            options: UIViewAnimationOptions.curveEaseInOut,
                            animations: {
                            self.alpha = 1;
            }, completion: { finished in
                onComplete();
            });

        } else {
            onComplete();
        }
        
        player!.play();
    }
    
    func taped(_ gestureRecognizer: UITapGestureRecognizer) {
        removeGestureRecognizer(self.tapGestureRecognizers!)
        tapGestureRecognizers!.delegate = nil;
        
        hide( true );
    }
    
    private func hide( _ animated:Bool ) {
        func onComplete() {
            isHidden = true;
            
            delegate?.onCompleteHide( target: self );
        }
        
        if( animated ) {
            isHidden = false;
            
            UIView.animate(withDuration: 0.25,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseInOut,
                           animations: {
                            self.alpha = 0;
            }, completion: { finished in
                onComplete();
            });
            
        } else {
            onComplete();
        }
        
        player!.play();
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //fatalError("init(coder:) has not been implemented")
    }

}
