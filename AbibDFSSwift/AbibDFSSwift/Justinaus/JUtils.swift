//
//  JUtils.swift
//  TwySwift3
//
//  Created by Bonkook Koo on 2017. 6. 8..
//  Copyright © 2017년 justinaus. All rights reserved.
//

import Foundation
import UIKit

public class NumberUtil {
    public static func roundToInt( _ value:Double ) -> Int {
        return Int(round( value ));
    }
    
    public static func roundToInt( _ value:String ) -> Int? {
        guard let d = Double( value ) else {
            return nil;
        }
        
        return roundToInt( d );
    }
    
    public static func roundToString( _ value:Double ) -> String {
        return String( roundToInt( value ) );
    }
    
    public static func roundToString( _ value:String ) -> String? {
        guard let d = roundToInt( value ) else {
            return nil;
        }
        
        return String( d );
    }
}

public class ColorUtil {
    public static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public class StringUtil {
    // ex) str : 'abcde', '2' = 'de'
    public static func substringFromEnd( str:String, count:UInt ) -> String {
        let minusCount:Int = Int( count ) * -1;
        
        let index = str.index(str.endIndex, offsetBy: minusCount)
        
        return str.substring(from: index);
    }
    
//    public static func substringFromStart( str:String, count:UInt ) -> String {
//        let index = str.index(str.endIndex, offsetBy: count)
//        
//        return str.substring(from: index);
//    }
}

public enum WeekdayShowTypeEnum {
    case koreanOneLetter;
    case koreanFullLetters;
    //case english3Letters;
    //case englishFullLetters;
    case koreanWithBracket;
}

public enum DateFormatEnum : String {
    case YYYY_MM_DD = "yyyy-MM-dd";
    case YYYY_MM_DD_HH_mm_SS = "yyyy-MM-dd HH:mm:ss";
    case YYYY_MM_DD_HH_mm = "yyyy-MM-dd HH:mm";
}

public class DateUtil {
    // 일요일:1, 월요일:2 ... 토요일:7로 파악됨.
    public static func getWeekdayString( _ weekday:Int, _ showType:WeekdayShowTypeEnum ) -> String {
        var strRet:String;
        
        switch showType {
        case WeekdayShowTypeEnum.koreanWithBracket:
            strRet = getWeekdayKoreanWithBracket( weekday );
        case WeekdayShowTypeEnum.koreanOneLetter:
            strRet = getWeekdayKoreanOneLetter( weekday );
        case WeekdayShowTypeEnum.koreanFullLetters:
            strRet = getWeekdayKoreanFullLetter( weekday );
        }
        
        return strRet;
    }
    
    private static func getWeekdayKoreanOneLetter( _ weekday:Int ) -> String {
        var strRet:String;
        
        switch weekday {
        case 1: strRet = "일";
        case 2: strRet = "월";
        case 3: strRet = "화";
        case 4: strRet = "수";
        case 5: strRet = "목";
        case 6: strRet = "금";
        case 7: strRet = "토";
        default:    strRet = "";
        }
        
        return strRet;
    }
    
    private static func getWeekdayKoreanWithBracket( _ weekday:Int ) -> String {
        return "(\(getWeekdayKoreanOneLetter( weekday )))";
    }
    
    private static func getWeekdayKoreanFullLetter( _ weekday:Int ) -> String {
        return "\(getWeekdayKoreanOneLetter( weekday ))요일";
    }
}


public class AlertUtil {
    public static func alert( vc:UIViewController, title:String, message:String, buttonText:String, onSelect: (() -> () )? ) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonText, style: UIAlertActionStyle.default);
        
        dialog.addAction(action)
        
        vc.present(dialog, animated: true, completion: onSelect);
    }
    
//    public static func alertSelect( vc:UIViewController, title:String, message:String, good:String, bad:String, onSelect:@escaping (UIAlertAction) -> () ) {
//        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        
//        let actionGood = UIAlertAction(title: good, style: UIAlertActionStyle.default, handler: onSelect);
//        let actionBad = UIAlertAction(title: bad, style: UIAlertActionStyle.cancel, handler: onSelect);
//        
//        dialog.addAction(actionGood);
//        dialog.addAction(actionBad);
//        
//        vc.present(dialog, animated: true, completion: nil);
//    }
}
