//
//  FavoritiesViewController.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit

class FavoritiesViewController: UIViewController {
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setConstrains()
        
        print("Done")
    }
}

//MARK: - Configure UITableView
private extension FavoritiesViewController{
    private func configureTableView() {
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.resuseID)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoritiesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.resuseID, for: indexPath) as? FavoriteCell else {return UITableViewCell()}
        //cell.selectionStyle = .none
        cell.configCell(quoteText: "fjsdks", author: "dsjfksdfj", category: "dkjfjdkf")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

//MARK: - Set Constrains
private extension FavoritiesViewController{
    func setConstrains(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
