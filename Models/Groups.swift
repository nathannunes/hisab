//
//  Groups.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import Foundation

// Classes related to Groups

struct Group {
    let id: UUID
    var name: String
    var expenses: [Expense] = []
    var personIDs : [String]
    
    var dictionary: [String: Any] {
            let expenseDictionaries = expenses.map { $0.dictionary }
            return [
                "id": id.uuidString,
                "name": name,
                "expenses": expenseDictionaries,
                "personIDs": personIDs
            ]
        }
    
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
    
    var dictionary: [String: Any] {
            return [
                "amount": amount,
                "description": description
            ]
        }
    
    
}
