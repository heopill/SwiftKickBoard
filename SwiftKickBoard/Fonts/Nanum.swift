//
//  Nanum.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/28/25.
//
import UIKit

final class Nanum {
    static let light = { size in
        return UIFont(name: "NanumSquareNeoTTF-aLt", size: size)
    }
    
    static let bold = { size in
        return UIFont(name: "NanumSquareNeoTTF-cBd", size: size)
    }
    
    static let heavy = { size in
        return UIFont(name: "NanumSquareNeoTTF-eHv", size: size)
    }
}
