//
//  BoardView.swift
//  TicTacToe
//
//  Created by cpark on 11/18/21.
//

import Foundation
import UIKit

// Board UI
class BoardView : UIView {
    // 3 x 3
    var boardView: [UIButton] = []
    
    // Binding for update UI
    var updateBoard: ((_ btn: UIButton) ->Void)?
    
    
    
    // Init UI, Create Buttons and align with StackView
    func initBoard() {
        
        // Create Main StackView
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        self.addSubview(mainStack)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        mainStack.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        mainStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mainStack.distribution = .fillEqually
        
        for row in 0..<3 {
            // Create Sub StackViews
            let colStack = UIStackView()
            colStack.axis = .horizontal
            mainStack.addArrangedSubview(colStack)
            
            for col in 0..<3 {
                let btn = UIButton()
                colStack.addArrangedSubview(btn)
                colStack.distribution = .fillEqually
                
                // Set button tag (row * col)
                btn.tag = (row * 3) + col
                
                btn.backgroundColor = (btn.tag % 2) == 0 ? .darkGray : .lightGray
                btn.addTarget(self, action: #selector(cellSelected), for: .touchUpInside)
                btn.titleLabel?.numberOfLines = 1
                btn.titleLabel?.adjustsFontSizeToFitWidth = true
                
                boardView.append(btn)
            }
        }
    }
    
    @objc func cellSelected(_ btn: UIButton) {
        updateBoard?(btn)
    }
    
    // Update UI, Set button text and color
    func updateUI(_ btn: UIButton, _ type: String, _ color: UIColor) {
        btn.setTitleColor(color, for: .normal)
        btn.setTitle(type, for: .normal)
    }
    
    // Clear Text on Buttons
    func reset() {
        for btn in boardView {
            btn.setTitle("", for: .normal)
        }
    }
}
