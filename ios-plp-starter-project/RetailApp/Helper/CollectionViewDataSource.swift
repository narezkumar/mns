//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

final class CollectionViewDataSource<Model, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    typealias CellConfigurator = (Model, Cell) -> Void

    var models: [Model] = []

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.item]
        let cell: Cell = collectionView.dequeueCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(model, cell)
        return cell
    }

}

extension CollectionViewDataSource where Model == Product {

    static func make(for podcasts: [Product],
                     userOffers: UserOffers,
                     servicesProvider: ServicesProvider,
                     reuseIdentifier: String = ProductCollectionViewCell.typeName) -> CollectionViewDataSource {

        return CollectionViewDataSource(models: podcasts, reuseIdentifier: reuseIdentifier,
                                        cellConfigurator: { podcast, cell in
            let cellViewModel = ProductCollectionCellViewModel(product: podcast, userOffers:userOffers,servicesProvider:servicesProvider)
            if let cell = cell as? ProductCollectionViewCell {
                cell.setup(viewModel: cellViewModel)
            }
            cell.layoutIfNeeded()
        })

    }

}
