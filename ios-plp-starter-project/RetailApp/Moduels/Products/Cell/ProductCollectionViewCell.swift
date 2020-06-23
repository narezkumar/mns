//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

class ProductCollectionViewCell: UICollectionViewCell,ViewModelConfigurable {

    // MARK: Outlets

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var badgeImageView: UIImageView!

    // MARK: Properties

    var viewModel: ProductCollectionCellViewModel?
    
    // MARK: Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
         viewModel?.product.value = nil
     }
    
    // MARK: Public functions

    func setup(viewModel: ViewModel) {
        guard let viewModel = viewModel as? ProductCollectionCellViewModel else { return }
        self.viewModel = viewModel
        bind()
    }


}

// MARK: Private functions

private extension ProductCollectionViewCell {
    

    func bind() {
        self.nameLabel.text = viewModel?.name.value
        self.priceLabel.attributedText = viewModel?.price.value
        self.productImageView.image = viewModel?.image.value
        self.badgeImageView.image = viewModel?.badgeImage.value

        viewModel?.name.bind(self) { [weak self] name in
          self?.nameLabel.text = name
        }
        viewModel?.price.bind(self) { [weak self] price in
          self?.priceLabel.attributedText = price
        }
        viewModel?.image.bind(self) { [weak self] image in
          self?.productImageView.image = image
        }
        viewModel?.badgeImage.bind(self) { [weak self] image in
          self?.badgeImageView.image = image
        }
        self.priceLabel.sizeToFit()
        setNeedsLayout()
    }
}
