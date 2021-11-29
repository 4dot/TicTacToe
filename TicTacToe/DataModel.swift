//
//  DataModel.swift
//  TicTacToe
//
//  Created by cpark on 11/18/21.
//

import Foundation

struct Board {
    var cells: [[Cell]]
    init() {
        cells = Array(repeating: Array(repeating: Cell(), count: 3), count: 3)
    }
}

struct Cell {
    var status: CellStatus = .none
}
extension Cell : Equatable {
    static func == (_ lhs: Cell, _ rhs: Cell) -> Bool {
        return lhs.status != .none && rhs.status != .none && lhs.status == rhs.status
    }
}

enum CellStatus : Int {
    case none
    case cross
    case circle
}

enum PlayerType {
    case red
    case blue
}
