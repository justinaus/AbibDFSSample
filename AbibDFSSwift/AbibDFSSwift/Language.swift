//
//  Language.swift
//  AbibDFSSwift
//
//  Created by Bonkook Koo on 2017. 6. 30..
//  Copyright © 2017년 abib. All rights reserved.
//

import Foundation

enum LanguageEnum : UInt {
    case chinese = 0;
    case korean
    case english
}


final class Language {
    
    // Can't init is singleton
    private init() { }
    
    public var currentLanguage = LanguageEnum.chinese;
    
    static let shared = Language()
//    static let shared : GridManager = {
//        let instance = GridManager()
//        
//        instance.tempAdd()
//        
//        return instance
//    }()
    
    
    
}
