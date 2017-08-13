//
//  AppDelegate.swift
//  AbibDFSSwift
//
//  Created by Bonkook Koo on 2017. 6. 29..
//  Copyright © 2017년 abib. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TimerDelegate, UIViewDelegate, UIGestureRecognizerDelegate {

    var window: UIWindow?
    
    
    public func showVideo( _ animated:Bool ) {
        let url = Bundle.main.url(forResource: "170712_LDFDID", withExtension: "mp4")!
        //let url = Bundle.main.url(forResource: "did_170617", withExtension: "mp4")!
        let rect = CGRect(x: 0, y: 0, width: window!.frame.size.width, height: window!.frame.size.height);
        
        let videoView = VideoView(rect: rect,url:url);
        
        videoView.delegate = self;
        
        self.window!.addSubview(videoView)
        
        videoView.show(animated);
    }
    
    func onCompleteHide(target: UIView?) {
        if target == nil {
            return;
        }
        
        if let videoView = target as? VideoView {
            videoView.delegate = nil;
        }
        
        target!.removeFromSuperview();
        
        TimerManager.shared.start(limitSecond: 25)
        //TimerManager.shared.start(limitSecond: AppInfo.limitSecondForMovie)
    }
    
    func onCompleteTimer() {
        showVideo( true );
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        TimerManager.shared.delegate = self;
        
        let tapGR = UITapGestureRecognizer(target: self, action: nil)
        tapGR.delegate = self
        window!.addGestureRecognizer(tapGR)
        
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // User tapped on screen, do whatever you want to do here.
        
        TimerManager.shared.reset();
        
        return false
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

