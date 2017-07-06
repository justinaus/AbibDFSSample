//
//  VCSlider.swift
//  AbibDFSSwift
//
//  Created by Bonkook Koo on 2017. 6. 29..
//  Copyright © 2017년 abib. All rights reserved.
//

import Foundation
import UIKit

class VCSlider: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate, SelectBoxDelegate {
    
    @IBOutlet var svImages: UIScrollView!
    @IBOutlet var naviView: UIView!
    @IBOutlet var naviBackView: UIView!
    @IBOutlet var ThumbnailContainer: UIView!
    @IBOutlet var languageSelectBox: LanguageSelectBoxView!
    
    var pageSize:CGSize?
    
    private var currentProduct:ProductEnum?
    
    var tapGRScrollView:UITapGestureRecognizer?
    var tapGRBack:UITapGestureRecognizer?
    
    private let chineseImageList:[ [String] ] = [
        ["3-1-0.jpg","3-1-1.jpg","3-1-2.jpg","3-1-3.jpg"],
        ["3-2-0.jpg","3-2-1.jpg","3-2-2.jpg"],
        ["3-3-0.jpg","3-3-1.jpg","3-3-2.jpg"],
        ["3-4-0.jpg","3-4-1.jpg","3-4-2.jpg","3-4-3.jpg"],
        ["3-5-0.jpg","3-5-1.jpg","3-5-2.jpg","3-5-3.jpg","3-5-4.jpg"],
        ["3-6-0.jpg"] ];
    
    private let englishImageList:[ [String] ] = [
        ["2-1-0.jpg","2-1-1.jpg","2-1-2.jpg","2-1-3.jpg"],
        ["2-2-0.jpg","2-2-1.jpg","2-2-2.jpg"],
        ["2-3-0.jpg","2-3-1.jpg","2-3-2.jpg"],
        ["2-4-0.jpg","2-4-1.jpg","2-4-2.jpg","2-4-3.jpg"],
        ["2-5-0.jpg","2-5-1.jpg","2-5-2.jpg","2-5-3.jpg","2-5-4.jpg"],
        ["2-6-0.jpg"] ];
    
    private let koreanImageList:[ [String] ] = [
        ["1-1-0.jpg","1-1-1.jpg","1-1-2.jpg","1-1-3.jpg"],
        ["1-2-0.jpg","1-2-1.jpg","1-2-2.jpg"],
        ["1-3-0.jpg","1-3-1.jpg","1-3-2.jpg"],
        ["1-4-0.jpg","1-4-1.jpg","1-4-2.jpg","1-4-3.jpg"],
        ["1-5-0.jpg","1-5-1.jpg","1-5-2.jpg","1-5-3.jpg","1-5-4.jpg"],
        ["1-6-0.jpg"] ];
    
    
    public func setProduct( productEnum:ProductEnum ) {
        currentProduct = productEnum;
    }
    
    func onSelectBoxChanged(_ index: Int) {
        Language.shared.currentLanguage = LanguageEnum( rawValue: UInt(index) )!;
        
        let productIndex = Int(currentProduct!.rawValue);
        
        let items = getCurrentImageList()[ productIndex ];
        
        for subview in svImages.subviews {
            let index = svImages.subviews.index(of: subview);
            
            let imageView = subview as! UIImageView;
            
            imageView.image = UIImage(named: items[index!]);
        }
    }
    
    
    
    
    override func viewDidLoad() {
        svImages.delegate = self;
        
        languageSelectBox.delegate = self;
        
        pageSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height);
        
        // 임시.
        naviView.isHidden = true;
        
        let productIndex = Int(currentProduct!.rawValue);
        makeScrollByProduct(productIndex: productIndex);
        
        makeTapGRScrollView();
        
        makeThumbnail();
        
        onChangedCurrentItem();
        
        languageSelectBox.changeCurrent(toIndex: Int(Language.shared.currentLanguage.rawValue));
    }
    
    override func viewDidAppear(_ animated: Bool) {
        TimerManager.shared.resume();
    }
    
    func makeScrollByProduct( productIndex:Int ) {
        clearScrollViewChildren();
        
        let langImageList = getCurrentImageList();
        
        let items = langImageList[ productIndex ];
        
        let pageWidth = Float( pageSize!.width );
        
        for item in items {
            let index = items.index(of: item);
            
            let imageView = makeUIImageView(language: langImageList, productIndex: productIndex, itemIndex: index!)
            
            let x = pageWidth * Float(index!);
            
            imageView.frame = CGRect(x: CGFloat(x), y: 0, width: pageSize!.width, height: pageSize!.height)
            
            svImages.addSubview(imageView);
        }
        
        svImages.contentSize.width = CGFloat(pageWidth * Float(items.count));
        svImages.contentSize.height = pageSize!.height;
    }
    
    func clearScrollViewChildren() {
        for subview in svImages.subviews {
            subview.removeFromSuperview();
        }
        
        svImages.contentOffset.x = 0;
        svImages.contentOffset.y = 0;
    }
    
    func makeTapGRScrollView() {
        tapGRScrollView = UITapGestureRecognizer(target: self, action: #selector(self.tapImages(_:)))
        tapGRScrollView!.delegate = self
        svImages.addGestureRecognizer(tapGRScrollView!)
    }
    
    func tapImages(_ gestureRecognizer: UITapGestureRecognizer) {
        svImages.removeGestureRecognizer(self.tapGRScrollView!)
        
        showNavi();
    }
    
    func showNavi() {
        naviView.alpha = 0;
        naviView.isHidden = false;
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.naviView.alpha = 1;
        }, completion: { finished in
            self.tapGRBack = UITapGestureRecognizer(target: self, action: #selector(self.tapBack(_:)))
            self.tapGRBack!.delegate = self
            self.naviBackView.addGestureRecognizer(self.tapGRBack!)
        });
    }
    
    func tapBack(_ gestureRecognizer: UITapGestureRecognizer) {
        naviBackView.removeGestureRecognizer(self.tapGRBack!)
        
        hideNavi();
    }
    
    func hideNavi() {
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.naviView.alpha = 0;
        }, completion: { finished in
            self.naviView.isHidden = true;
            
            self.makeTapGRScrollView();
        });
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        onChangedCurrentItem();
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        onChangedCurrentItem();
    }
    
    func onChangedCurrentItem() {
        let error:CGFloat = 100;
        //let totalWidth = svImages.contentSize.width;
        let pageWidth = pageSize!.width;
        
        let currentItemIndex = svImages.contentOffset.x == 0 ? 0 : Int( (svImages.contentOffset.x + error) / pageWidth );
        
        let subviews = ThumbnailContainer.subviews;
        
        for subview in subviews {
            let index = subviews.index(of: subview);
            
            let btn = subview as! UIButton;
            
            if( index == currentItemIndex ) {
                btn.layer.borderWidth = 7;
                btn.layer.borderColor = ColorUtil.UIColorFromRGB(rgbValue: 0x4272E6).cgColor;
            } else {
                btn.layer.borderWidth = 1;
                btn.layer.borderColor = UIColor.black.cgColor;
            }
        }
    }
    
    func makeThumbnail() {
        clearThumbnailChildren();
        
        let productIndex = Int(currentProduct!.rawValue);
        
        let items = getCurrentImageList()[ productIndex ];
        
        var posX:Float = 0;
        let gap:Float = 20;
        
        for item in items {
            let index = items.index(of: item)!;
            
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100) );
            let image = UIImage(named: "\(productIndex+1)-\(index).jpg");
            
            btn.setImage( image, for: UIControlState.normal)
            btn.setTitle(String(describing: index), for: .normal)
            btn.backgroundColor = UIColor.red;
            
            btn.frame.origin.x = CGFloat(posX);
            
            btn.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
            
            posX += Float(btn.frame.width) + gap;
            
            ThumbnailContainer.addSubview( btn );
        }
        
        let totalChildWidth = CGFloat(posX - gap);
        ThumbnailContainer.frame.size.width = totalChildWidth;
        ThumbnailContainer.frame.origin.x = (pageSize!.width - totalChildWidth)/2;
    }
    
    func pressButton(button: UIButton) {
        guard let title = button.currentTitle, let index = Int(title) else {
            return;
        }
        
        let posX = CGFloat(index) * pageSize!.width;
        
        let pnt = CGPoint(x: posX, y: 0)
        
        svImages.setContentOffset(pnt, animated: true)
    }
    
    func clearThumbnailChildren() {
        for subview in ThumbnailContainer.subviews {
            subview.removeFromSuperview();
        }
    }
    
    func makeUIImageView( language:[ [ String ] ], productIndex:Int, itemIndex:Int ) -> UIImageView {
        let items = language[ productIndex ];
        let fileName = items[ itemIndex ];
        let image = UIImage(named: fileName);
        let imageView = UIImageView(image: image );
        
        return imageView;
    }
    
    func getCurrentImageList() -> [ [String] ] {
        var arrRet:[ [String] ]?
        
        switch Language.shared.currentLanguage {
        case .chinese:
            arrRet = chineseImageList;
        case .english :
            arrRet = englishImageList;
        case .korean :
            arrRet = koreanImageList;
        }
        
        return arrRet!;
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }

}
