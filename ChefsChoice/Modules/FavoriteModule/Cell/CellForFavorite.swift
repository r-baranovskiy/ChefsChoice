//
//  CellForFavorite.swift
//  ChefsChoice
//
//  Created by Дмитрий on 28.02.2023.
//

import UIKit

class CellForFavorite: UITableViewCell {
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .gray
        label.alpha = 0.7
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 6
        label.textAlignment = .center
        label.text = "Likes: 2034"
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cookingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .blue
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(cookingLabel)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(likesLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ recipeModel: RecipeModel) {
        titleLabel.text = recipeModel.title
        cookingLabel.text = String(recipeModel.cookingMinutes)
        //photoImageView.image = recipeModel
    }
    
    func configureTest(_ testModel: testModel) {
        titleLabel.text = testModel.title
        cookingLabel.text = "Time for cooking:\n \(testModel.time) minutes"
        photoImageView.image = testModel.image
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 480),
            photoImageView.heightAnchor.constraint(equalToConstant: 360),
            
            stackView.leftAnchor.constraint(equalTo: photoImageView.leftAnchor, constant: 50),
            stackView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -30),
            stackView.rightAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: -150),
            
            likesLabel.leftAnchor.constraint(equalTo: photoImageView.leftAnchor, constant: 56),
            likesLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 16),
            likesLabel.widthAnchor.constraint(equalToConstant: 100),
            likesLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
