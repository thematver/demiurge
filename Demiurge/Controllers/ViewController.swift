import UIKit

class MainController: UIViewController {
    
    private let game = Game()
    private let impact = UIImpactFeedbackGenerator(style: .light)
    private var creationButton: UIButton!
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 360, height: 75)
        layout.minimumInteritemSpacing = 4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LifeCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - Properties
    private let reuseIdentifier = "Cell"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        
        
    }
    
    //MARK: UI

    func setUpUI() {
        setViewBackgroundGradient(sender: self, .purple, .black)
        setUpNavbar()
        setUpButton()
        setUpCollectionView()

    }
    

    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
                    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                  
                    creationButton.heightAnchor.constraint(equalToConstant: 20),
                    creationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                    creationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
                        creationButton.heightAnchor.constraint(equalTo: creationButton.widthAnchor, multiplier: 0.12),
                    creationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: creationButton.topAnchor, constant: -20)
        ])
    }
    

    func setViewBackgroundGradient(sender: UIViewController, _ topColor:UIColor, _ bottomColor:UIColor) {

        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations

        gradientLayer.frame = sender.view.bounds
        let backgroundView = UIView(frame: sender.view.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.view = backgroundView
    }
    
  
    func setUpNavbar() {
        navigationItem.title = "Клеточное наполнение"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .purple
        appearance.shadowColor = UIColor.clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setUpButton() {
        creationButton = UIButton(type: .system)
        creationButton.backgroundColor = .systemPurple
        creationButton.translatesAutoresizingMaskIntoConstraints = false
        creationButton.setTitle("СОТВОРИТЬ", for: .normal)
        creationButton.setTitleColor(.white, for: .normal)
        creationButton.layer.cornerRadius = 8
        creationButton.addTarget(self, action: #selector(creationButtonTapped), for: .touchDown)
        view.addSubview(creationButton)
    }
    
    
    @objc func creationButtonTapped() {
        impact.impactOccurred()
        game.addCell()
        collectionView.reloadData()
        collectionView.scrollToBottom(animated: true)
    }
    
    
}

extension MainController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.storage.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LifeCell
        
        let gameCell = game.storage.reversed()[indexPath.row]
        
        cell.nameLabel.text = gameCell.name
        cell.descriptionLabel.text = gameCell.description
        cell.setUp(image: UIImage(named: gameCell.imageName)!)
        return cell
    }
   
}

extension MainController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 75)
        
    }
    func collectionView(_ collectionView: UICollectionView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

extension UICollectionView {

    // MARK: - UICollectionView scrolling/datasource
    /// Last Section of the CollectionView
    var lastSection: Int {
        return numberOfSections - 1
    }

    /// IndexPath of the last item in last section.
    var lastIndexPath: IndexPath? {
        guard lastSection >= 0 else {
            return nil
        }

        let lastItem = numberOfItems(inSection: lastSection) - 1
        guard lastItem >= 0 else {
            return nil
        }

        return IndexPath(item: lastItem, section: lastSection)
    }

    /// Islands: Scroll to bottom of the CollectionView
    /// by scrolling to the last item in CollectionView
    func scrollToBottom(animated: Bool) {
        guard let lastIndexPath = lastIndexPath else {
            return
        }
        scrollToItem(at: lastIndexPath, at: .bottom, animated: animated)
    }
    

}


