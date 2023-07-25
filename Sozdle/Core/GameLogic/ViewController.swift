//
//  ViewController.swift
//  Sozdle
//
//  Created by Диас Сайынов on 10.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var wordFilled = false
    var canFill = false
    var countGuesses = 0
    public var checkTapped: Bool = false
    let answer = "қайық"
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.darkTheme
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
        canFill = false
        if checkTapped{
            wordFilled = false
        }
        if countGuesses >= 5{
            wordFilled = true
        }
        
        else {
            for i in 0..<guesses.count{
                for j in 0..<guesses[i].count{
                    if guesses[i][j] == nil{
                        guesses[i][j] = letter
                        countGuesses += 1
                        stop = true
                        break
                    }
                }
                if stop{
                    break
                }
            }
        }
        
        boardVC.reloadData()
    }
    
    func keyboardViewController(_ vc: KeyboardViewController, didTapBackspaceButton button: UIButton){
        for i in (0..<guesses.count).reversed() {
            if canFill{
                return
            }
        for j in (0..<guesses[i].count).reversed() {
            if let letter = guesses[i][j] {
                guesses[i][j] = nil
                countGuesses -= 1
                boardVC.reloadData()
                return
                }
            }
        }
    }

    
    func keyboardViewController(_ vc: KeyboardViewController, didTapCheckButton button: UIButton) {
            // Verify if all 5 letters are filled
            if countGuesses >= 5{
                wordFilled = true
            } else{
                canFill = false
                checkTapped = false
            }
        
            if wordFilled {
                // Convert the guesses array to a flat array of characters
                let word: String
                if let firstFilledRow = guesses.first(where: { !$0.isEmpty }), let lastFilledColumn = firstFilledRow.lastIndex(where: { $0 != nil }) {
                    let flatGuesses = Array(guesses.flatMap { $0.compactMap { $0 } }[...lastFilledColumn])
                    word = String(flatGuesses)
                } else {
                    word = ""
                }
                print(word)
                
                // Check if the word matches the answer
                if word == answer {
                    // The word is correct
                    let alertController = UIAlertController(title: "Congratulations!", message: "You guessed the word correctly.", preferredStyle: .alert)

                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                            // Perform any action you want after the user taps OK
                        self.guesses = Array(repeating: Array(repeating: nil, count: 5), count: 6)
                        self.countGuesses = 0
                        self.wordFilled = false
                        self.checkTapped = false
                        self.canFill = true
                        self.boardVC.reloadData()
                    }

                    alertController.addAction(okAction)

                    present(alertController, animated: true, completion: nil)
                } else {
                    // The word is incorrect
                    print("Sorry, the word you guessed is incorrect.")
                }
                countGuesses = 0
                checkTapped = true
                canFill = true
                
            } else {
                // The word is not completely filled
                print("Please fill all 5 letters before checking the word.")
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
        
        if indexedAnswer[indexPath.row] == letter && canFill{
            return .systemGreen
        } else if canFill{
            return .systemOrange
        }
        
        return nil
    }
}
