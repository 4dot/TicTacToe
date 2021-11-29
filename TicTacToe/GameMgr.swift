//
//  GameMgr.swift
//  TicTacToe
//
//  Created by cpark on 11/18/21.
//

import Foundation

// Game Manager Class
//
// Update GameData and Check Game Result

class GameMgr {
    var board: Board
    var player: PlayerType
    
    
    init() {
        board = Board()
        player = .red
    }
    
    func reset() {
        board = Board()
        player = .red
    }
    
    func updateBoard(_ x: Int, _ y: Int, _ result: (_ winner: PlayerType?, _ curr: PlayerType?, _ error: String?) -> Void) {
        
        let cell = board.cells[x][y]
        if cell.status != .none {
            // Alreay placed
            return result(nil, nil, "Already Placed, Please select others.")
        }
        // Update Board Data
        board.cells[x][y].status = (player == .red) ? .circle : .cross
        
        // Check Winner
        //if let winner = checkWinner() {
        if let winner = checkWinner2(x, y, board.cells[x][y].status) {
            result(winner, self.player, nil)
            return
        }
        
        result(nil, self.player, nil)
        
        // Update next turn
        self.player = (player == .red) ? .blue : .red
    }
    
    // Check Winner
    // Simple and Easy Check all of conditions
    // return player if exist winner or nil
    private func checkWinner() -> PlayerType? {
        if (board.cells[0][0] == board.cells[0][1] && board.cells[0][1] == board.cells[0][2]) ||
            (board.cells[1][0] == board.cells[1][1] && board.cells[1][1] == board.cells[1][2]) ||
            (board.cells[2][0] == board.cells[2][1] && board.cells[2][1] == board.cells[2][2]) ||
            
            (board.cells[0][0] == board.cells[1][0] && board.cells[1][0] == board.cells[2][0]) ||
            (board.cells[0][1] == board.cells[1][1] && board.cells[1][1] == board.cells[2][1]) ||
            (board.cells[0][2] == board.cells[1][2] && board.cells[1][2] == board.cells[2][2]) ||
            
            (board.cells[0][0] == board.cells[1][1] && board.cells[1][1] == board.cells[2][2]) ||
            (board.cells[0][2] == board.cells[1][1] && board.cells[1][1] == board.cells[2][0]) {
            
            return player
        }
        
        return nil
    }
}

extension GameMgr {
    
    private func checkWinner2(_ x: Int, _ y: Int, _ status: CellStatus) -> PlayerType? {
        let checkDirs = [[Dir.Left, Dir.Right],
                        [Dir.Up, Dir.Down],
                        [Dir.LUp, Dir.RDown],
                        [Dir.LDown, Dir.RUp]]
        
        for dir in checkDirs {
            // e.g) leftsum + rightsum - 1(duplicate)
            if getMarkCnt(x, y, status, dir[0], 0) + getMarkCnt(x, y, status, dir[1], 0) - 1 >= 3 {
                return self.player
            }
        }
        
        return nil
    }
    
    
    enum Dir {
        case Left, Right,
             Up, Down,
             LUp, RDown,
             LDown, RUp
    }
    // Using Recursion, get same status count
    private func getMarkCnt(_ x: Int, _ y: Int, _ status: CellStatus, _ dir: Dir, _ curr: Int) -> Int {
        if x < 0 || x >= 3 || y < 0 || y >= 3 || board.cells[x][y].status != status {
            return curr
        }
        
        switch dir {
        case .Left:
            return getMarkCnt(x - 1, y, status, dir, curr + 1)
        case .Right:
            return getMarkCnt(x + 1, y, status, dir, curr + 1)
        case .Up:
            return getMarkCnt(x, y - 1, status, dir, curr + 1)
        case .Down:
            return getMarkCnt(x, y + 1, status, dir, curr + 1)
        case .LUp:
            return getMarkCnt(x - 1, y - 1, status, dir, curr + 1)
        case .RDown:
            return getMarkCnt(x + 1, y + 1, status, dir, curr + 1)
        case .LDown:
            return getMarkCnt(x - 1, y + 1, status, dir, curr + 1)
        case .RUp:
            return getMarkCnt(x + 1, y - 1, status, dir, curr + 1)
        }
    }
}
