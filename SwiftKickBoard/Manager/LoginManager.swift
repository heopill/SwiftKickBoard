//
//  UserData.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/29/25.
//

import Foundation
import UIKit

class LoginManager {
    private let defaults = UserDefaults.standard
    
    private var user: [[String]] {
        get {
            defaults.array(forKey: Key.user.rawValue) as? [[String]] ?? []
        }
        set {
            defaults.set(newValue, forKey: Key.user.rawValue)
        }
    }
    
    private enum Key: String {
        case user
        case autoLogin
        case lastID
    }
}

// MARK: - Method
extension LoginManager {
    func login(id: String, pw: String) -> [String]? {
        let data = user
        
        for i in data {
            if i[1] == id, i[2] == pw {
                return i
            }
        }
        
        return nil
    }
    
    func signUp(name: String, id: String, pw: String) -> Bool {
        var data = user
        
        for i in data {
            if i[1] == id {
                return false
            }
        }
        
        data.append([name, id, pw])
        user = data
        return true
    }
    
    func findID(name: String) -> String {
        let data = user
        var info = "해당 이름으로 가입된 아이디 ⬇️"
        
        for i in data {
            if i[0] == name {
                info += "\n\(i[1])"
            }
        }
        
        if info == "해당 이름으로 가입된 아이디 ⬇️" {
            info = "해당 이름으로 가입된 아이디가 없습니다."
        }
        
        return info
    }
    
    func findPW(name: String, id: String) -> String {
        let data = user
        var info = ""
        
        for i in data {
            if i[0] == name, i[1] == id {
                info = "해당 아이디의 비밀번호는 ( \(i[2]) )입니다."
                break
            }
        }
        
        if info.isEmpty {
            info = "일치하는 정보가 없습니다."
        }
        
        return info
    }
    
}
