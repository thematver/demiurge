import UIKit

class MainController: UITableViewController {
    
    private var creationButton: UIButton!

    let game = Game()
    
    typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        tableView.register(UINib(nibName: "LifeCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    //MARK: UI

    func setUpUI() {
        view.backgroundColor = UIColor.purple
        setUpNavbar()
        setUpButton()
        setTableViewBackgroundGradient(sender: self, .purple, .black)
    }
    
    func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:UIColor, _ bottomColor:UIColor) {

        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations

        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
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
        view.addSubview(creationButton)
        
        NSLayoutConstraint.activate([
            creationButton.heightAnchor.constraint(equalToConstant: 50),
            creationButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            creationButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            creationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
        
        creationButton.addTarget(self, action: #selector(creationButtonTapped), for: .touchDown)
    }
    
    
    @objc func creationButtonTapped() {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        game.addCell()
        tableView.reloadData()
    }
    
    //MARK: Table View Settings
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LifeCell
        
        let gameCell = game.storage.reversed()[indexPath.section]
        cell.nameLabel.text = gameCell.name
        cell.descriptionLabel.text = gameCell.description
        cell.setUpGradient(with: gameCell.gradientColors)
        cell.setUpImage(UIImage(named: gameCell.imageName)!)
        
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
        return cell
    }
   
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return game.storage.count
    }
  
    //MARK: Spacing
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear

        return view
    }
 
    
 
   

    

   
}

