//
//  CategoryCollectionViewCell.swift
//  ChefsChoice
//
//  Created by Nikolai Zvonarev on 01.03.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "categoryRecipe")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
                layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been emplemented")
    }
    
    func setupView() {
        backgroundColor = #colorLiteral(red: 0.9342038631, green: 0.9539685845, blue: 0.9624658227, alpha: 1)
        layer.cornerRadius = 10
        addSubview(categoryLabel)
        addSubview(categoryImageView)
    }
    
    func configureCell(categoryName: String, imageName: String) {
        categoryLabel.text = categoryName
        categoryImageView.image = UIImage(named: imageName)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            categoryLabel.heightAnchor.constraint(equalToConstant: 16),
            
            categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            categoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            categoryImageView.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -5)
        ])
    }
}
