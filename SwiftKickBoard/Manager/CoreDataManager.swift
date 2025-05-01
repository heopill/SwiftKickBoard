//
//  CoreDataManager.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/30/25.
//

import Foundation
import CoreData
import UIKit

class CoreData {
    static let shared = CoreData()
    
    var container: NSPersistentContainer!
    
    private init() {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           self.container = appDelegate.persistentContainer
       }
    
    // CoreData 데이터 저장하기
    func createData(id: Int, lat: Double, lon: Double) {
        guard let entity = NSEntityDescription.entity(forEntityName: KickBoard.className, in: self.container.viewContext) else { return }
        let newContacts = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newContacts.setValue(id, forKey: KickBoard.Key.id)
        newContacts.setValue(lat, forKey: KickBoard.Key.lat)
        newContacts.setValue(lon, forKey: KickBoard.Key.lon)
        
        do {
            try self.container.viewContext.save()
            print("킥보드 등록 성공")
        } catch {
            print("킥보드 등록 실패")
        }
    }
    
    // CoreData 저장된 데이터 선택 삭제
    func deleteData(id: Int) {
        // 삭제할 데이터를 찾기 위한 fetch request 생성
        let fetchRequest = KickBoard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            // fetch request 실행
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            // 결과 처리
            for data in result as [NSManagedObject] {
                // 삭제
                // CRUD 의 D.
                self.container.viewContext.delete(data)
                print("삭제된 데이터: \(data)")
            }
            
            // 변경 사항 저장
            try self.container.viewContext.save()
            print("데이터 삭제 완료")
            
        } catch {
            print("데이터 삭제 실패: \(error)")
        }
    }
    
    // CoreData 저장된 데이터 읽어오기
    func readAllData() -> [KickBoard] {
        do {
            let kickBoard = try self.container.viewContext.fetch(KickBoard.fetchRequest())
                return kickBoard

        } catch {
            print("데이터 읽기 실패")
            return []
        }
        
    }
}
