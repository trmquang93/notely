//
//  NTNotesUseCase.swift
//  Platform
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation
import Domain
import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

class NTNotesUseCase: Domain.NTNotesUseCase {
    static let firestore = Firestore.firestore()
    
    func getNotes(sort: SortOption) -> Observable<AnyCollection<Domain.NTNote>> {
        return .create { obs in
            let listener = Self.firestore.collection("notes")
                .order(by: sort.field, descending: !sort.ascending)
                .addSnapshotListener { snapshot, error in
                    debugPrint("sort by: \(sort)")
                    if let error = error {
                        obs.onError(error)
                    } else if let documents = snapshot?.documents {
                        let notes = documents.compactMap { document in
                            return try? NTNote.fromJSON(document.json)
                        }
                        
                        obs.onNext(.init(notes))
                    }
                }
            
            return Disposables.create {
                listener.remove()
            }
        }
    }
    
    func saveNote(_ attributedString: NSAttributedString, createdDate: Date) -> Observable<Void> {
        var data: Data
        do {
            data = try attributedString.data(.rtfd)
        } catch {
            return .error(error)
        }
        
        let rawText = attributedString.string
        let title = rawText.components(separatedBy: "\n").first ?? ""
        let body = rawText.components(separatedBy: "\n").dropFirst().first ?? ""
        
        let note = NTNote(
            title: title,
            body: body,
            content: data,
            createDate: createdDate,
            updateDate: Date())
        
        return saveNote(note)
    }
    
    func saveNote(_ note: Domain.NTNote) -> Observable<Void> {
        var json: [String: Any]
        
        do {
            json = (try note.toJSON() as? [String: Any]) ?? [:]
        } catch {
            return .error(error)
        }
        
        return .create { obs in
            let collectionRef = Self.firestore.collection("notes")
            let docRef = collectionRef.document("\(note.createDate.timeIntervalSince1970)")

            docRef.setData(json) { error in
                if let error = error {
                    obs.onError(error)
                } else {
                    obs.onNext(())
                    obs.onCompleted()
                }
            }
            
            return Disposables.create {
            }
        }
    }
    
    func delete(_ note: Domain.NTNote) -> Observable<Void> {
        let collectionRef = Self.firestore.collection("notes")
        let docRef = collectionRef.document("\(note.createDate.timeIntervalSince1970)")
        
        return .create { obs in
            docRef.delete { error in
                if let error = error {
                    obs.onError(error)
                } else {
                    obs.onNext(())
                    obs.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
}
