//
//  QuoteDetailViewController.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    private let presenter: QuoteDetailPresenter
    
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)
    private let categoryLabel = UILabel()
    private let quoteLabel = UILabel()
    private let authorLabel = UILabel()
    private let favoriteButton = UIButton()
    private let backView = UIView()
    private let stack = UIStackView()
    
    init(presenter: QuoteDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configActivityIndecator()
        setConstraints()
        setUpUIElements()
        addActionButtons()
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getData()
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
    
    func setUpUIElements(){
        configLabel(label: categoryLabel, sizeText: 24, weithText: .bold, lines: 1, color: .black)
        configLabel(label: authorLabel, sizeText: 20, weithText: .semibold, lines: 1, color: .black)
        configLabel(label: quoteLabel, sizeText: 16, weithText: .regular, lines: 0, color: .black)
        configButton(button: favoriteButton, symbol: "star.fill")
        configView(view: backView, radius: 15, isHidden: true)
        configStack(stack: stack)
    }
    
    func addActionButtons(){
        favoriteButton.addTarget(nil, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    func configButton(button: UIButton, symbol: String){
        button.setBackgroundImage(UIImage(systemName: symbol), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    func configView(view: UIView, radius: CGFloat, isHidden: Bool){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.5)
        view.isHidden = isHidden
        view.layer.cornerRadius = radius
    }
    
    func configLabel(label: UILabel, sizeText: CGFloat, weithText: UIFont.Weight, lines: Int, color: UIColor){
        label.textAlignment = .center
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
    
    @objc func favoriteTapped(){
        presenter.saveFavorities()
    }
}

//MARK: - SetUp Constrains
private extension QuoteDetailViewController {
    func setConstraints() {
        view.addSubview(backView)
        view.addSubview(activityIndicator)
        view.addSubview(favoriteButton)
        backView.addSubview(stack)
        backView.addSubview(favoriteButton)
        stack.addArrangedSubview(categoryLabel)
        stack.addArrangedSubview(authorLabel)
        stack.addArrangedSubview(quoteLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backView.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: 5),
            
            favoriteButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
            favoriteButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            
            stack.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
            stack.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            stack.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            stack.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5),
        ])
    }
}
//MARK: - Set QuotesListVCProtocol
extension QuoteDetailViewController: QuoteDetailVCProtocol{
    func hideBackView() {
        DispatchQueue.main.async {
            self.backView.isHidden = false
        }
    }
    
    func addTextToLabel() {
        DispatchQueue.main.async {
            self.authorLabel.text = self.presenter.textArray[0].author
            self.categoryLabel.text = self.presenter.textArray[0].category.capitalized
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
