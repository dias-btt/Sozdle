import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = Colors.darkTheme
        let sozdle = UILabel()
        sozdle.text = "Sozdle"
        sozdle.font = UIFont.boldSystemFont(ofSize: 36)
        sozdle.textColor = Colors.darkText
        sozdle.textAlignment = .center
        sozdle.translatesAutoresizingMaskIntoConstraints = false
        
        let smallLabel = UILabel()
        smallLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit!"
        smallLabel.font = UIFont.systemFont(ofSize: 18)
        smallLabel.textAlignment = .center
        smallLabel.textColor = Colors.darkText
        smallLabel.numberOfLines = 0
        smallLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
        button.setTitle("          Бастау          ", for: .normal)
        button.setTitleColor(Colors.darkText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
            
                // Set the gradient colors
        gradientLayer.colors = [(UIColor(red: 2.16, green: 0, blue: 0.50, alpha: 0.8)).cgColor, (UIColor(red: 1.94, green: 0.81, blue: 0.81, alpha: 0.5)).cgColor]
                
                // Set the gradient direction
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
                
                // Apply the gradient layer as the button's background
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        view.addSubview(sozdle)
        view.addSubview(smallLabel)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sozdle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sozdle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            smallLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            smallLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            smallLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallLabel.topAnchor.constraint(equalTo: sozdle.bottomAnchor, constant: 16),
                    
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: smallLabel.bottomAnchor, constant: 162)
        ])
    }
    
    @objc private func startButtonTapped() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
}

