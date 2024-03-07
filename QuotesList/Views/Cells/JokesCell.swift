//
//  JokesCell.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import UIKit

final class JokesCell: UITableViewCell {
    static let resuseID = "JokesCell"
    
    private let jokeLabel = UILabel()
    
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
        configLabel(label: jokeLabel, sizeText: 16, weithText: .regular, lines: 0, alignment: .left, color: .black)
    }
    
    private func configLabel(label: UILabel, sizeText: CGFloat, weithText: UIFont.Weight, lines: Int, alignment: NSTextAlignment, color: UIColor){
        label.textAlignment = alignment
        label.textColor = color
        label.numberOfLines = lines
        label.font = .systemFont(ofSize: sizeText, weight: weithText)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        jokeLabel.text = nil
    }
}

//MARK: - Configure Cell UI
extension JokesCell{
    func configCell(jokeText: String){
        jokeLabel.text = jokeText
    }
}

//MARK: - Constrains
extension JokesCell{
    private func setConstrains(){
        contentView.addSubview(backView)
        backView.addSubview(jokeLabel)
        
        NSLayoutConstraint.activate([
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                        
            jokeLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 4),
            jokeLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -4),
            jokeLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -4),
            jokeLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 4),
        ])
    }
}
