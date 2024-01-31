//
//  Groups.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import Foundation
import FirebaseFirestore

struct Group {
    let id: String
    var name: String
    var expenses: [Expense] = []
    var personIDs: [String] = []

    var dictionary: [String: Any] {
            var dict: [String: Any] = [
                "id": id,
                "name": name,
                "personIDs": personIDs
            ]

            // Convert each Expense to a dictionary and add it to the 'expenses' key
            let expensesDict = expenses.map { $0.dictionary }
            dict["expenses"] = expensesDict
            
            return dict
        }
    
    init(id: UUID, name: String, personIDs: [String]) {
            self.id = id.uuidString  // Convert UUID to String
            self.name = name
            self.personIDs = personIDs
            // Expenses are initialized as an empty array by default
        }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let name = data["name"] as? String else { return nil }
        
        self.id = document.documentID
        self.name = name

        // Parse expenses if they exist and are stored in the format you expect
        if let expensesData = data["expenses"] as? [[String: Any]] {
            self.expenses = expensesData.compactMap(Expense.init(dictionary:))
        }

        // Parse personIDs if they exist
        self.personIDs = data["personIDs"] as? [String] ?? []
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
    
    init?(dictionary: [String: Any]) {
            guard let amount = dictionary["amount"] as? Double,
                  let description = dictionary["description"] as? String else {
                return nil
            }

            self.amount = amount
            self.description = description

            // Initialize other properties...
        }
    
}
