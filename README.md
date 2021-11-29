# Tic Tac Toe

## Swift Simple Tic Tac Toe Game

- Checking Winner
 1. Simple Way
 
````swift
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
````
 2. Recursion
 ````swift
 enum Dir {
        case Left, Right,
             Up, Down,
             LUp, RDown,
             LDown, RUp
    }
    
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
 ````
