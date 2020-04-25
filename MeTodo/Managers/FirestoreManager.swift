//
//  FirestoreManager.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/18/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation
import Firebase

class FirestoreManager: FirestoreService {
    func addTicket(ticket: Ticket, success: @escaping (Ticket) -> Void, failure: @escaping (AppError) -> Void) {
        let uid = Auth.auth().currentUser!.uid
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("tickets/\(uid)/listTicket").addDocument(data: ticket.generateParams()) { err in
            if let err = err {
                print("Error add ticket documents: \(err)")
                failure(.init(from: err as NSError))
            } else {
                var resultTicket = ticket
                resultTicket.id = ref!.documentID
                success(resultTicket)
            }
        }
    }
    
    func addCategoryTag(tag: CategoryTag ,success: @escaping (CategoryTag) -> Void, failure: @escaping (AppError) -> Void) {
        let uid = Auth.auth().currentUser!.uid
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("categories/\(uid)/listCategory").addDocument(data: tag.generateParams()) { err in
            if let err = err {
                print("Error add tag documents: \(err)")
                failure(.init(from: err as NSError))
            } else {
                var resultTag = tag
                resultTag.id = ref!.documentID
                success(resultTag)
            }
        }
    }
    
    func getListCategoryTag(success: @escaping ([CategoryTag]) -> Void, failure: @escaping (AppError) -> Void) {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("categories/\(uid)/listCategory").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                failure(.init(from: err as NSError))
            } else {
                var listTag: [CategoryTag] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    listTag.append(.init(document: document))
                }
                success(listTag)
            }
        }
    }
    
    func getListTicket(success: @escaping ([Ticket]) -> Void, failure: @escaping (AppError) -> Void) {
        let uid = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("tickets/\(uid)/listTicket").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                failure(.init(from: err as NSError))
            } else {
                var listTicket: [Ticket] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    listTicket.append(.init(document: document))
                }
                success(listTicket)
            }
        }
    }
    
    static let shared = FirestoreManager()
    
    public func setup() {
        let db = Firestore.firestore()
        print(db)
    }
    
    
}

