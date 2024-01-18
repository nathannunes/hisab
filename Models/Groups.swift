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
}

struct Expense {
    var amount: Double
    var description: String
}
