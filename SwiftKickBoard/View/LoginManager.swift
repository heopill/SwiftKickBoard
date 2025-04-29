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
    private let key = "user"
    
    private var user: [[String]] {
        get {
            defaults.array(forKey: key) as? [[String]] ?? []
        }
        set {
            defaults.set(newValue, forKey: key)
        }
    }
    
    func login(id: String, pw: String) -> Bool {
        var data = user
        
        for i in data {
            if i[1] == id, i[2] == pw {
                return true
            }
        }
        
        return false
    }
    
    func signUp(name: String, id: String, pw: String) {
        var data = user
        
        for i in data {
            if i[1] == id {
                print("해당 아이디로 가입된 계정이 있습니다.")
                return
            }
        }
        
        data.append([name, id, pw])
        user = data
        
    }
    
    func findID(name: String, on vc: UIViewController) {
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
        
        let alert = UIAlertController(title: "알림🔔", message: info, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        vc.present(alert, animated: true)
    }
    
    func findPW(name: String, id: String, on vc: UIViewController) {
        let data = user
        var info = ""
        
        for i in data {
            if i[0] == name, i[1] == id {
                info = "해당 정보의 비밀번호는 ( \(i[2]) )입니다."
                break
            }
        }
        
        if info.isEmpty {
            info = "일치하는 정보가 없습니다."
        }
        
        let alert = UIAlertController(title: "알림🔔", message: info, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        vc.present(alert, animated: true)
    }
    
}
