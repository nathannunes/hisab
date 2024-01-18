//
//  Groups.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import Foundation

struct Group {
    let id: UUID
    var name: String
    var expenses: [Expense]
    var personIDs : [String]
}

struct Person {
    let pid : UUID
    var username : String
    var email : String
    var displayname : String
}

struct Expense {
    var amount: Double
    var description: String
}
