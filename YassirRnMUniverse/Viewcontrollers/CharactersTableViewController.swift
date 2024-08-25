//
//  CharactersTableViewController.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//

import UIKit
import Combine
import SwiftUI

class CharactersTableViewController: UITableViewController {
    var viewModel: CharacterViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = LocalizedStrings.charactersTitle
        setupView()
        bindViewModel()
        viewModel.fetchCharacters()
    }

    private func setupView() {
        // Custom header view
        let headerView = CharactersHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 60))
        headerView.filterControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)

        // Container view to hold the header view
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 60))
        containerView.addSubview(headerView)

        // Positioning header within the container
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60)
        ])

        tableView.tableHeaderView = containerView

        // Register custom cell
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: Constants.characterCellIdentifier)

        // Table view properties
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.cellHeight
    }

    @objc private func filterChanged(_ sender: UISegmentedControl) {
        viewModel.filterCharacters(by: sender.selectedSegmentIndex)
    }

    private func bindViewModel() {
        viewModel.charactersPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.characterCellIdentifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character)

        // Trigger pagination
        if indexPath.row == viewModel.characters.count - 1 {
            viewModel.fetchCharacters()
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.preservesSuperviewLayoutMargins = true
        cell.contentView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        let detailsView = CharacterDetailsView(character: character)
        let hostingController = UIHostingController(rootView: detailsView)
        navigationController?.pushViewController(hostingController, animated: true)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let alpha = max(0, 1 - (offset / 100))
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: Constants.largeTitleTextColor(withAlpha: alpha)
        ]
    }
}
