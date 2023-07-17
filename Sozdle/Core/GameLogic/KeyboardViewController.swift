//
//  KeyboardViewController.swift
//  Sozdle
//
//  Created by Диас Сайынов on 11.07.2023.
//

import UIKit

protocol KeyboardViewControllerDelegate: AnyObject{
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        for rows in letters{
            let chars = Array(rows)
            keys.append(chars)
        }
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
        cell.backgroundColor = UIColor.systemGray3
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
