//
//  ViewController.swift
//  AbibDFSSwift
//
//  Created by Bonkook Koo on 2017. 6. 29..
//  Copyright © 2017년 abib. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SelectBoxDelegate {

    @IBOutlet var languageSelectBox: LanguageSelectBoxView!
    
    var viewTemp:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languageSelectBox.delegate = self;
        
        Language.shared.currentLanguage = .chinese;
        
        makeTempBgWhite();
        view.isHidden = true;
    }
    
    func makeTempBgWhite() {
        viewTemp = UIView();
        viewTemp!.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height);
        viewTemp!.backgroundColor = UIColor.white;
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window!.addSubview(viewTemp!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if( viewTemp != nil ) {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.showVideo(false);
            
            viewTemp!.removeFromSuperview();
            viewTemp = nil;
            
            view.isHidden = false;
        }
    }
    
    func onSelectBoxChanged(_ index: Int) {
        Language.shared.currentLanguage = LanguageEnum( rawValue: UInt(index) )!;
    }

    func openSlider( productEnum:ProductEnum ) {
        TimerManager.shared.pause();
        
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "VCSlider") as! VCSlider;
        
        uvc.setProduct(productEnum: productEnum);
        
        let segue = SegueFromRightToLeft(identifier: "test", source: self, destination: uvc)
        
        segue.perform();
    }
    
    @IBAction func onClickMainButton(_ sender: UIButton) {
        let title = sender.currentTitle!;
        
        let buttonName = "Button";
        
        let idx = UInt( title.substring(from: title.index(title.startIndex, offsetBy: buttonName.characters.count) ) );
        
        openSlider( productEnum: ProductEnum( rawValue: idx! )! );
    }
    
    @IBAction func unwindToVC( _ unwindSegue: UIStoryboardSegue) {
        languageSelectBox.changeCurrent(toIndex: Int(Language.shared.currentLanguage.rawValue));
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    //    func showGif( animated:Bool ) {
    //        // An animated UIImage
    //        let jeremyGif = UIImage.gif(name: "881")
    //
    //        // A UIImageView with async loading
    //        //let imageView = UIImageView()
    //        //imageView.loadGif(name: "jeremy")
    //
    //        gifImageView = UIImageView(image: jeremyGif)
    //        gifImageView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    //        view.addSubview(gifImageView!);
    //
    //        gifImageView?.isUserInteractionEnabled = true;
    //    }

}

