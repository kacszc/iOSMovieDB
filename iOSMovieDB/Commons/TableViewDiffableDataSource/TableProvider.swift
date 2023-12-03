//
//  TableDataSourceProvider.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import Foundation
import UIKit

enum OneSectionType {
    case main
}

class TableDataSourceProvider<Item: Hashable>: UITableViewDiffableDataSource<OneSectionType, Item> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<OneSectionType, Item>

    private(set) var snapshot: Snapshot = .init()

    func update(using items: [Item]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)

        apply(snapshot, animatingDifferences: true)
    }
}
