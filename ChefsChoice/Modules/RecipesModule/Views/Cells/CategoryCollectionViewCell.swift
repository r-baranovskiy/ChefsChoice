import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been emplemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        categoryImageView.image = nil
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        addSubview(categoryLabel)
        addSubview(categoryImageView)
    }
    
    func configureCell(categoryName: String, imageName: String) {
        categoryLabel.text = categoryName
        categoryImageView.image = UIImage(named: imageName)
    }
    
    func getName() -> String {
        return categoryLabel.text!
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 5),
            categoryLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -5),
            categoryLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: -5),
            categoryLabel.heightAnchor.constraint(
                equalToConstant: 16),
            
            categoryImageView.topAnchor.constraint(
                equalTo: topAnchor, constant: 5),
            categoryImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 5),
            categoryImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -5),
            categoryImageView.bottomAnchor.constraint(
                equalTo: categoryLabel.topAnchor, constant: -5)
        ])
    }
}
