//
//  FavoriteCell.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    static let resuseID = "FavoriteCell"
    
    private let quoteTextLabel = UILabel()
    private let authorLabel = UILabel()
    private let categoryLabel = UILabel()
    private let stack = UIStackView()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUIElements()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUIElements(){
        configLabel(label: quoteTextLabel, sizeText: 14, weithText: .regular, lines: 0, alignment: .left, color: .black)
        configLabel(label: authorLabel, sizeText: 16, weithText: .semibold, lines: 0, alignment: .center, color: .black)
        configLabel(label: categoryLabel, sizeText: 16, weithText: .bold, lines: 0, alignment: .center, color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        configStack(stack: stack)
    }
    
    private func configLabel(label: UILabel, sizeText: CGFloat, weithText: UIFont.Weight, lines: Int, alignment: NSTextAlignment, color: UIColor){
        label.textAlignment = alignment
        label.textColor = color
        label.numberOfLines = lines
        label.font = .systemFont(ofSize: sizeText, weight: weithText)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configStack(stack: UIStackView){
        stack.alignment = .center
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.spacing = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        quoteTextLabel.text = nil
        authorLabel.text = nil
        categoryLabel.text = nil
    }
}

//MARK: - Configure Cell UI
extension FavoriteCell{
    func configCell(quoteText: String, author: String, category: String){
        configQuoteTextLabel(quoteText: quoteText)
        configAuthorLabel(author: author)
        configCategoryLabel(category: category)
    }
    
    private func configQuoteTextLabel(quoteText: String){
        quoteTextLabel.text = quoteText
    }
    
    private func configAuthorLabel(author: String){
        authorLabel.text = author
    }
    
    private func configCategoryLabel(category: String){
        categoryLabel.text = "From: " + category.capitalized
    }
}

//MARK: - Constrains
extension FavoriteCell{
    private func setConstrains(){
        contentView.addSubview(backView)
        stack.addArrangedSubview(authorLabel)
        stack.addArrangedSubview(categoryLabel)
        backView.addSubview(stack)
        backView.addSubview(quoteTextLabel)
        
        NSLayoutConstraint.activate([
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            stack.topAnchor.constraint(equalTo: backView.topAnchor, constant: 4),
            stack.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 4),
            stack.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -2),
            stack.widthAnchor.constraint(equalToConstant: 120),
            
            quoteTextLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 2),
            quoteTextLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -4),
            quoteTextLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -2),
            quoteTextLabel.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 2),
        ])
    }
}
