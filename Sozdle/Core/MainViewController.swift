import UIKit

class MainViewController: UIViewController {
    var statButton: UIButton!
    var bottomView: UIView!
    var viewIsHidden: Bool = true
    var rightButton: UIButton!
    var headerView: UIView!
    var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.darkTheme
        setupBottomView()
        setupNavigationBar()
        createStatButton()
        createStartButton()
        view.bringSubviewToFront(bottomView) // Bring the bottom view to the front
    }
    
    private func setupNavigationBar() {
        title = "Sozdle"
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.darkText,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        navigationController?.navigationBar.tintColor = Colors.darkText
        
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoButtonTapped))
        infoButton.tintColor = Colors.darkText
        navigationItem.rightBarButtonItem = infoButton
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = Colors.darkText
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    //MARK: - Stat Button
    private func createStatButton() {
            let buttonWidth = view.frame.width - 40
            let buttonHeight: CGFloat = 50
            
            // Create the container view
            let buttonContainer = UIView(frame: CGRect(x: 20, y: 120, width: buttonWidth, height: buttonHeight))
            buttonContainer.backgroundColor = UIColor(red: 0.55, green: 0.60, blue: 0.68, alpha: 1.00)
            buttonContainer.layer.cornerRadius = buttonHeight / 2
            buttonContainer.layer.masksToBounds = true
            view.addSubview(buttonContainer)
            
            // Create the icon image view
            let iconImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
            if let iconImage = UIImage(named: "stat-icon") {
                iconImageView.image = iconImage
            }
            buttonContainer.addSubview(iconImageView)
            
            // Create the text label
            let textLabel = UILabel(frame: CGRect(x: 50, y: 0, width: buttonWidth - 60, height: buttonHeight))
            textLabel.text = "Статистика көру"
            textLabel.textColor = UIColor.white
            textLabel.font = UIFont.boldSystemFont(ofSize: 16)
            buttonContainer.addSubview(textLabel)
            
            // Create the button
            statButton = UIButton(type: .system)
            statButton.frame = buttonContainer.bounds
            statButton.addTarget(self, action: #selector(statButtonTapped), for: .touchUpInside)
            buttonContainer.addSubview(statButton)
        }
    
    @objc private func statButtonTapped() {
            let statVC = StatViewController()
            navigationController?.pushViewController(statVC, animated: true)
    }
    
    //MARK: - Start Button
    private func createStartButton() {
        let buttonWidth = view.frame.width - 40
        let buttonHeight: CGFloat = 100
        
        // Create the container view
        let buttonContainer = UIView(frame: CGRect(x: 20, y: 190, width: buttonWidth, height: buttonHeight))
        buttonContainer.backgroundColor = UIColor(red: 0.76, green: 0.32, blue: 0.32, alpha: 1.00)
        buttonContainer.layer.cornerRadius = 20
        buttonContainer.layer.masksToBounds = true
        view.addSubview(buttonContainer)
        
        // Create the text label
        let textLabel = UILabel(frame: CGRect(x: 10, y: -20, width: buttonWidth - 60, height: buttonHeight))
        textLabel.text = "Ойынды бастау"
        textLabel.textColor = UIColor.white
        textLabel.font = UIFont.boldSystemFont(ofSize: 20)
        buttonContainer.addSubview(textLabel)
        
        let additionalTextLabel = UILabel(frame: CGRect(x: 10, y: 45, width: buttonWidth - 20, height: 40))
        additionalTextLabel.text = "Күрделі сөздерді табу арқылы барлық деңгейлерді ашыңыз"
        additionalTextLabel.textColor = UIColor.white
        additionalTextLabel.font = UIFont.systemFont(ofSize: 14)
        additionalTextLabel.numberOfLines = 0
        additionalTextLabel.textAlignment = .left
        buttonContainer.addSubview(additionalTextLabel)
            
        
        // Create the button
        let startButton = UIButton(type: .system)
        startButton.frame = buttonContainer.bounds
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        buttonContainer.addSubview(startButton)
    }
    
    @objc private func startButtonTapped() {
        let startVC = ViewController()
        navigationController?.pushViewController(startVC, animated: true)
    }
    
    //MARK: - Info view
    private func setupBottomView() {
        bottomView = UIView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 730))
        bottomView.backgroundColor = UIColor(red: 0.23, green: 0.24, blue: 0.32, alpha: 1.00)
        bottomView.layer.cornerRadius = 15
        view.addSubview(bottomView)
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: bottomView.frame.width, height: 50))
        headerView.layer.cornerRadius = 15
        headerView.backgroundColor = UIColor(red: 0.23, green: 0.24, blue: 0.32, alpha: 1.00)

            
        titleLabel = UILabel(frame: headerView.bounds)
        titleLabel.text = "Ойын ережелері"
        titleLabel.textAlignment = .center
        titleLabel.textColor = Colors.darkText
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerView.addSubview(titleLabel)
                
        rightButton = UIButton(type: .system)
        rightButton.frame = CGRect(x: headerView.frame.width - 70, y: 0, width: 60, height: headerView.frame.height)
        rightButton.setTitle("Қаз", for: .normal)
        rightButton.setTitleColor(Colors.darkText, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        rightButton.addTarget(self, action: #selector(langButtonTapped), for: .touchUpInside)
        headerView.addSubview(rightButton)
    
        bottomView.addSubview(headerView)
        
        let textLabel = UILabel(frame: CGRect(x: 10, y: 10, width: bottomView.frame.width - 20, height: bottomView.frame.height - 20))
        textLabel.text = """
            Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit, amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem.
            """
        textLabel.textAlignment = .left
        textLabel.textColor = Colors.darkText
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.numberOfLines = 0
        bottomView.addSubview(textLabel)
    }
    
    @objc private func infoButtonTapped() {
        
        if self.viewIsHidden{
            UIView.animate(withDuration: 0.4) {
                self.bottomView.frame.origin.y = self.view.frame.height - self.bottomView.frame.height
            }
            self.viewIsHidden = false
        }
    }
    
    @objc private func backButtonTapped(_ sender: UISwitch) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Change language
    @objc private func langButtonTapped() {
        if rightButton.title(for: .normal) == "Қаз" {
            rightButton.setTitle("Рус", for: .normal)
            titleLabel.text = "Правила игры"
        } else {
            rightButton.setTitle("Қаз", for: .normal)
            titleLabel.text = "Ойын ережелері"
        }
    }

    
    //MARK: - Touches to dismiss InfoView
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: view)
            let containerHeight = view.frame.height - bottomView.frame.height
            let containerOriginY = bottomView.frame.origin.y
            let newOriginY = containerOriginY + (touchLocation.y - containerOriginY)
            bottomView.frame.origin.y = max(containerHeight, newOriginY)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let containerHeight = view.frame.height - bottomView.frame.height
        if bottomView.frame.origin.y > containerHeight + 100 {
            dismissContainerView()
        } else {
            resetContainerViewPosition()
        }
    }
    
    private func dismissContainerView() {
        UIView.animate(withDuration: 0.4) {
            self.bottomView.frame.origin.y = self.view.frame.height
        }
        self.viewIsHidden = true
    }
    
    private func resetContainerViewPosition() {
        UIView.animate(withDuration: 0.4) {
            self.bottomView.frame.origin.y = self.view.frame.height - self.bottomView.frame.height
        }
    }
    
    
    //MARK: - Other functions - resizeImage
    private func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
            let size = image.size

            let widthRatio = targetSize.width / size.width
            let heightRatio = targetSize.height / size.height
            let scale = min(widthRatio, heightRatio)

            let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)

            let renderer = UIGraphicsImageRenderer(size: scaledSize)
            let resizedImage = renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: scaledSize))
            }

            return resizedImage
        }
}
