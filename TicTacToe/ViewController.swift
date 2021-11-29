//
//  ViewController.swift
//  TicTacToe
//
//  Created by cpark on 11/18/21.
//

import UIKit

class ViewController: UIViewController {
    var boardView = BoardView()
    var gameMgr = GameMgr()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI() {
        self.view.addSubview(boardView)
        boardView.translatesAutoresizingMaskIntoConstraints = false
        
        boardView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        boardView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        boardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        boardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        boardView.initBoard()
        
        boardView.updateBoard = { [weak self] (btn) in
            guard let self = `self` else { return }
            
            // Get 2d position with tag
            let x = btn.tag / 3
            let y = btn.tag % 3
            
            self.gameMgr.updateBoard(x, y) { winner, curr, error in
                if let error = error {
                    // Error Message
                    self.showPopup(error, nil)
                    return
                }
                
                // update UI
                let mark = curr == .red ? "O" : "X"
                let color = curr == .red ? UIColor.red : UIColor.blue
                
                self.boardView.updateUI(btn, mark, color)
                
                if let winner = winner {
                    // Game Over and reset
                    self.showPopup("Player \(winner) is win!") {
                        self.gameMgr.reset()
                        self.boardView.reset()
                    }
                }
            }
        }
    }
    
    func showPopup(_ message: String, _ handler: (()->Void)?) {
        let popup = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        
        popup.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            popup.dismiss(animated: true) {
                handler?()
            }
        }))
        self.present(popup, animated: true, completion: nil)
    }

}

