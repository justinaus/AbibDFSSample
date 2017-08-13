//
//  LanguageSelectBoxView.swift
//  AbibDFSSwift
//
//  Created by Bonkook Koo on 2017. 6. 30..
//  Copyright © 2017년 abib. All rights reserved.
//

import UIKit

protocol SelectBoxDelegate {
    func onSelectBoxChanged( _ index:Int );
}

@IBDesignable
class LanguageSelectBoxView : UIView, UIGestureRecognizerDelegate {
    
    var contentView:UIView?
    //@IBInspectable var nibName:String?
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var listView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    
    // delegate event
    
    private var currentItemIndex:Int = -1;
    
    var delegate:SelectBoxDelegate? = nil;
    
    
    func initCustom() {
        listView.isHidden = true;
        
        if( !getHasTabGestureRecognizer( view: mainView ) ) {
            let tab = UITapGestureRecognizer(target: self, action: #selector(self.tabMain(_:)))
            tab.delegate = self
            mainView.addGestureRecognizer(tab)
        }
    }
    
    func getHasTabGestureRecognizer( view:UIView ) -> Bool {
        guard let recognizers = view.gestureRecognizers else {
            return false;
        }
        
        for recog in recognizers {
            if( recog is UITapGestureRecognizer ) {
                return true;
            }
        }
        
        return false;
    }
    
    func tabMain(_ gestureRecognizer: UITapGestureRecognizer) {
        listView.isHidden = !listView.isHidden;
    }
    
    public func changeCurrent( toIndex:Int ) {
        listView.isHidden = true;
        
        if( toIndex == currentItemIndex ) {
            return;
        }
        
        currentItemIndex = toIndex;
        
        let fileName = ["chn","kor","eng"];
        
        for subview in listView.subviews {
            let button = subview as! UIButton;
            
            let title = button.currentTitle!;
            
            let idx = Int( title )!;
            
            var image:UIImage?
            
            if( idx == toIndex ) {
                //image = UIImage(named: "\(fileName[idx])_a.jpg");
                image = UIImage(named: "\(fileName[idx])_a.png");
                
                mainImageView.image = UIImage(named: "\(fileName[idx]).png");
                //mainImageView.image = UIImage(named: "\(fileName[idx]).jpg");
            } else {
                image = UIImage(named: "\(fileName[idx]).png");
                //image = UIImage(named: "\(fileName[idx]).jpg");
            }
            
            button.setImage( image!, for: UIControlState.normal);
        }
    }
    
    @IBAction func onClickItems(_ sender: UIButton) {
        let title = sender.currentTitle!;
        
        let idx = Int( title )!;
        
        if( idx == currentItemIndex ) {
            return;
        }
        
        changeCurrent( toIndex: idx );
        
        //print("dispatch event")
        
        delegate?.onSelectBoxChanged( idx );
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        
        initCustom();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
//    func xibSetup() {
//        contentView = loadViewFromNib()
//        
//        // use bounds not frame or it'll be offset
//        contentView.frame = bounds
//        
//        // Make the view stretch with containing view
//        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
//        
//        // Adding custom subview on top of our view (over any custom drawing > see note below)
//        addSubview(contentView)
//    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
//    func loadViewFromNib() -> UIView? {
//        guard let nibName = nibName else { return nil }
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(
//            withOwner: self,
//            options: nil).first as? UIView
//    }
}
