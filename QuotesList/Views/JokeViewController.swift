//
//  JokesViewController.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import UIKit

class JokeViewController: UIViewController {
    private let presenter: JokePresenterProtocol
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)
    
    init(presenter: JokePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configActivityIndecator()
        setConstrains()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getData()
        presenter.starActivityIndicator()
    }
}

//MARK: - Configure UIElements
private extension JokeViewController{
    func configActivityIndecator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .blue
    }
    
    func configureTableView() {
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JokesCell.self, forCellReuseIdentifier: JokesCell.resuseID)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension JokeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.jokeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JokesCell.resuseID, for: indexPath) as? JokesCell else {return UITableViewCell()}
        let data = presenter.jokeArray[indexPath.row]
        cell.selectionStyle = .none
        cell.configCell(jokeText: data.joke)
        return cell
    }
}
//MARK: - Set FavoritiesVCProtocol
extension JokeViewController: JokePresenterVCProtocol{
    func reloadTableview() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func activityIndicStart() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func activityIndicStop() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

//MARK: - Set Constrains
private extension JokeViewController{
    func setConstrains(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

