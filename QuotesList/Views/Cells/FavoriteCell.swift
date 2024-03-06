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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUIElements()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUIElements(){
        configLabel(label: quoteTextLabel, sizeText: 14, weithText: .regular, lines: 0, alignment: .left)
        configLabel(label: authorLabel, sizeText: 16, weithText: .semibold, lines: 0, alignment: .center)
        configLabel(label: categoryLabel, sizeText: 16, weithText: .bold, lines: 0, alignment: .center)
        configStack(stack: stack)
    }
    
    private func configLabel(label: UILabel, sizeText: CGFloat, weithText: UIFont.Weight, lines: Int, alignment: NSTextAlignment){
        label.textAlignment = alignment
        label.textColor = .black
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
        stack.addArrangedSubview(authorLabel)
        stack.addArrangedSubview(categoryLabel)
        contentView.addSubview(stack)
        contentView.addSubview(quoteTextLabel)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            stack.widthAnchor.constraint(equalToConstant: 120),
            quoteTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            quoteTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            quoteTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            quoteTextLabel.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 2),
        ])
    }
}
