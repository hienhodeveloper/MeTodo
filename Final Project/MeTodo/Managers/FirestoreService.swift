//
//  FirestoreService.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/18/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

protocol FirestoreService {
    func getListTicket(success: @escaping ([Ticket]) -> Void, failure: @escaping (AppError) -> Void)
    func getListCategoryTag(success: @escaping ([CategoryTag]) -> Void, failure: @escaping (AppError) -> Void)
    func addCategoryTag(tag: CategoryTag, success: @escaping (CategoryTag) -> Void, failure: @escaping (AppError) -> Void)
    func addTicket(ticket: Ticket, success: @escaping (Ticket) -> Void, failure: @escaping (AppError) -> Void)
}
