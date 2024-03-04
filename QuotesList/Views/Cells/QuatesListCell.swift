//
//  QuatesListCell.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import UIKit

final class QuatesListCell: UICollectionViewCell {
    static let resuseID = "QuatesListCell"
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstrains()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
    }
    
    private func applyGradient(){
        categoryImage.bounds = self.contentView.bounds
        categoryImage.applyGradientMask(colors: [#colorLiteral(red: 0.737254902, green: 0.9058823529, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.768627451, green: 0.568627451, blue: 0.6941176471, alpha: 1)], locations: [0.2, 1.0])
    }
}
//MARK: - Configure Cell UI Public Method
extension QuatesListCell{
    func configCell(categoryLabelText: String){
        categoryLabel.text = categoryLabelText
        applyGradient()
    }
}

//MARK: - Constrains
extension QuatesListCell{
    private func setConstrains(){
        contentView.layer.cornerRadius = 16
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: categoryImage.leadingAnchor, constant: 12),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryImage.trailingAnchor , constant: -12),
            categoryLabel.bottomAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: -12)
        ])
    }
}
