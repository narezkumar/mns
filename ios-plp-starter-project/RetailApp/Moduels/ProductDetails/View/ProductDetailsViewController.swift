import UIKit

class ProductDetailsViewController: UIViewController, ViewModelConfigurable {
  @IBOutlet private var imageView: UIImageView!
  @IBOutlet private var name: UILabel!
  @IBOutlet private var price: UILabel!
  @IBOutlet private var information: UILabel!

  private var viewModel: ProductDetailsViewModel?

    init() {
        super.init(nibName: ProductDetailsViewController.identifier(), bundle: Bundle(for: ProductDetailsViewController.self))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Initializers
    
    func setup(viewModel: ViewModel) {
        guard let viewModel = viewModel as? ProductDetailsViewModel else { return }
        self.viewModel = viewModel
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    bind()
  }

  deinit {
    viewModel?.name.unbind(self)
    viewModel?.information.unbind(self)
    viewModel?.image.unbind(self)
    viewModel?.price.unbind(self)
  }

  private func bind() {
    viewModel?.name.bind(self) { [weak self] name in
      self?.name.text = name
      self?.title = name
    }
    viewModel?.price.bind(self) { [weak self] price in
      self?.price.attributedText = price
    }
    viewModel?.information.bind(self) { [weak self] information in
      self?.information.text = information
    }
    viewModel?.image.bind(self) { [weak self] image in
      self?.imageView.image = image
    }
  }
}
