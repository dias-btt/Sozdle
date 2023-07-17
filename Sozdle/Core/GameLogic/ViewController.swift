//
//  ViewController.swift
//  Sozdle
//
//  Created by Диас Сайынов on 10.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let answer = "қайық"
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.43, green: 0.45, blue: 0.66, alpha: 1)
        addChildren()
    }

    private func addChildren(){
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.dataSource = self
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
        
        addConstraints()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ViewController: KeyboardViewControllerDelegate{
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        
        var stop = false
        
        for i in 0..<guesses.count{
            for j in 0..<guesses[i].count{
                if guesses[i][j] == nil{
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop{
                break
            }
        }
        boardVC.reloadData()
    }
}

extension ViewController: BoardViewControllerDataSource{
    var currGuesses: [[Character?]]{
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap({$0}).count
        guard count == 5 else{
            return nil
        }
        
        let indexedAnswer = Array(answer)
        guard let letter = guesses[indexPath.section][indexPath.row], indexedAnswer.contains(letter) else{
            return nil
        }
        
        if indexedAnswer[indexPath.row] == letter{
            return .systemGreen
        }
        
        return .systemOrange
    }
}
