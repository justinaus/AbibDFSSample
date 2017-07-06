//
//  TimerManager.swift
//  AbibDFSSwift
//
//  Created by Bonkook Koo on 2017. 7. 5..
//  Copyright © 2017년 abib. All rights reserved.
//

import Foundation

protocol TimerDelegate {
    func onCompleteTimer();
}

final class TimerManager {
    
    // Can't init is singleton
    private init() { }
    
    //static let shared = GridManager()
    static let shared : TimerManager = TimerManager();
    
    
    var timer: Timer?
    
    var second:UInt = 0;
    var limitSecond:UInt = 0;
    
    var delegate:TimerDelegate? = nil;
    
    private var isPaused:Bool = false;
    
    
    // 앞에가 외부에 보여지는 변수명, 뒤에가 내가 사용할 변수명.
    func start( limitSecond targetSecond:UInt ) {
        limitSecond = targetSecond;
        
        if( timer != nil ) {
            stop();
        }
        
        second = 0;
        
        isPaused = false;
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: onTimer);
    }
    
    func onTimer( t:Timer ) {
        if( isPaused ) {
            return;
        }
        
        second += 1;
        
        //print(second)
        
        if( second > limitSecond ) {
            stop();
            
            delegate?.onCompleteTimer();
        }
    }
    
    public func stop() {
        isPaused = true;
        
        if timer != nil {
            timer!.invalidate();
            
            timer = nil;
        }
    }
    
    public func reset() {
        second = 0;
    }
    
    public func pause() {
        isPaused = true;
    }

    public func resume() {
        isPaused = false;
    }
    
}
