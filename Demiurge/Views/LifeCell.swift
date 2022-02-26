import UIKit

class LifeCell: UICollectionViewCell {
    
    let background : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emojiView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
   
    
    override func layoutSubviews() {
        super.awakeFromNib()
        setUp()
    }
    func setUp() {
        self.backgroundColor = .clear
        self.contentView.addSubview(background)
        background.addSubview(nameLabel)
        background.addSubview(descriptionLabel)
        background.addSubview(emojiView)
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            emojiView.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            emojiView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -16),
            emojiView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            emojiView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -16),
            emojiView.widthAnchor.constraint(equalToConstant: 40),
            emojiView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo:  emojiView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo:  emojiView.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
        
        descriptionLabel.sizeToFit()
        nameLabel.sizeToFit()
    }
    
    func setUp(image: UIImage) {
            emojiView.image = image
       }

    
    func setUp(name: String) {
        self.nameLabel.text = name
    }
    
    func setUp(description: String) {
        self.descriptionLabel.text = description
    }
   
   
}
