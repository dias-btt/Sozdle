//
//  KeyboardViewController.swift
//  Sozdle
//
//  Created by Диас Сайынов on 11.07.2023.
//

import UIKit

protocol KeyboardViewControllerDelegate: AnyObject{
    func keyboardViewController(_ vc: KeyboardViewController, didTapCheckButton button: UIButton)
    func keyboardViewController(_ vc: KeyboardViewController, didTapBackspaceButton button: UIButton)
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character)
}

class KeyboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: KeyboardViewControllerDelegate?
    
    let letters = ["әіңғүұқөһ", "йцукенгшщзхъ", "фывапролджэё", "ячсмитьбю"]
    private var keys: [[Character]] = []
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    let checkButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Тексеру", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
            return button
        }()
    
    let backspaceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Жою", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(backspaceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(checkButton)
        view.addSubview(backspaceButton)
        collectionView.delegate = self
        collectionView.dataSource = self
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backspaceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 180),
            backspaceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backspaceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 1),
            backspaceButton.heightAnchor.constraint(equalToConstant: 40),
            
            checkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -100),
            checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            checkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            checkButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        for rows in letters{
            let chars = Array(rows)
            keys.append(chars)
        }
    }

    @objc func checkButtonTapped() {
            delegate?.keyboardViewController(self, didTapCheckButton: checkButton)
    }
    @objc func backspaceButtonTapped() {
        delegate?.keyboardViewController(self, didTapBackspaceButton: backspaceButton)
    }
}

extension KeyboardViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else{
            fatalError()
        }
        let letter = keys[indexPath.section][indexPath.row]
        cell.configure(with: letter)
        cell.backgroundColor = Colors.darkTheme
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 15
        let size: CGFloat = (collectionView.frame.size.width-margin)/12
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let margin: CGFloat = 15
        let size: CGFloat = (collectionView.frame.size.width-margin)/12
        
        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))
        
        let inset: CGFloat = (collectionView.frame.size.width-(size*count) - (2*(count-1)))/2
        
        return UIEdgeInsets(top: 2, left: inset, bottom: 2, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let letter = keys[indexPath.section][indexPath.row]
        delegate?.keyboardViewController(self, didTapKey: letter)
    }
}
