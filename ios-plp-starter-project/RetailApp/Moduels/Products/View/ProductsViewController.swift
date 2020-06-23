//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

final class ProductsViewController: UICollectionViewController, ViewModelConfigurable {
    // MARK: Properties
    
    private var viewModel: ProductsViewModel?
    // MARK: Initializers
    
    init() {
        super.init(nibName: ProductsViewController.identifier(), bundle: Bundle(for: ProductsViewController.self))
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View hierarchy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupCollectionView()
        getOffers()
        //getProductsUsingConcurrent()
    }
    
    // MARK: Initializers
    
    func setup(viewModel: ViewModel) {
        guard let viewModel = viewModel as? ProductsViewModel else { return }
        self.viewModel = viewModel
    }
}

// MARK: - Setup
extension ProductsViewController {

    private func setUp(){
        self.title = "Tops"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: ProductCollectionViewCell.typeName, bundle: Bundle(for: ProductCollectionViewCell.self)), forCellWithReuseIdentifier: ProductCollectionViewCell.typeName)
        collectionView.dataSource = viewModel?.dataSource
    }
    
    private func getOffers(_ userId : String = "1"){
        self.viewModel?.getOffers(userId) { [weak self] in
            guard let self = self else { return }
            ///in global thread
            self.getProducts()
        }
    }
    
    private func getProducts(){
        self.viewModel?.getProducts(){ [weak self] in
            guard let self = self else { return }
            //in main thread
            self.collectionView.dataSource = self.viewModel?.dataSource
            self.collectionView.reloadData()
        }
    }
    
    ///tried another approach using concurrency
    private func getProductsUsingConcurrent(){
        self.viewModel?.getProductsUsingConcurrent(){ [weak self] in
            guard let self = self else { return }
            self.collectionView.dataSource = self.viewModel?.dataSource
            self.collectionView.reloadData()
        }
    }
}


// MARK: - Collection View
extension ProductsViewController {

    // MARK: - Navigation
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = viewModel?.product(for: indexPath) else { return }
        let request = Request(id: product.id, price: product.price, name: product.name)
        viewModel?.navigator?.showProductDetails(for: request, listingImage: nil)
    }

}

// MARK: - Flow Layout

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let numberofItem: CGFloat = 2
        let collectionViewWidth = self.collectionView.bounds.width
        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
        return CGSize(width: width, height: 310)
    }
}
