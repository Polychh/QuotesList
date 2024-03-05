//
//  QuoteDetailViewController.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    var presenter: QuoteDetailPresenter!
    
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)
    private let categoryLabel = UILabel()
    private let quoteLabel = UILabel()
    private let authorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configActivityIndecator()
        setConstraints()
        setUpLabels()
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.starActivityIndicator()
    }
}

//MARK: - SetUp UI
private extension QuoteDetailViewController {
    func configActivityIndecator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .blue
    }
    
    func setUpLabels(){
        configLabel(label: categoryLabel, sizeText: 24, weithText: .bold, lines: 1, color: .black)
        configLabel(label: authorLabel, sizeText: 20, weithText: .semibold, lines: 1, color: .black)
        configLabel(label: quoteLabel, sizeText: 16, weithText: .regular, lines: 0, color: .black)
    }
    
    
    func configLabel(label: UILabel, sizeText: CGFloat, weithText: UIFont.Weight, lines: Int, color: UIColor){
        label.textAlignment = .center
        label.textColor = color
        label.numberOfLines = lines
        label.font = .systemFont(ofSize: sizeText, weight: weithText)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - SetUp Constrains
private extension QuoteDetailViewController {
    func setConstraints() {
        view.addSubview(activityIndicator)
        view.addSubview(categoryLabel)
        view.addSubview(authorLabel)
        view.addSubview(quoteLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            
            quoteLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}


//MARK: - Set QuotesListVCProtocol
extension QuoteDetailViewController: QuoteDetailVCProtocol{
    func addTextToLabel() {
        DispatchQueue.main.async {
            self.authorLabel.text = self.presenter.textArray[0].author
            self.categoryLabel.text = self.presenter.textArray[0].category
            self.quoteLabel.text = self.presenter.textArray[0].quote
        }
    }
    
    func activityIndicStart() {
        activityIndicator.startAnimating()
    }
    
    func activityIndicStop() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        
    }
}
