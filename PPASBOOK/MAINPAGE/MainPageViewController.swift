import UIKit

class MainPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Properties for the main collectionView (bottom)
    var collectionView: UICollectionView!
    let cellIdentifier = "MyCell"
    let data = ["slide1", "slide2", "slide3", "slide4", "slide5"]
    var imageSizes: [CGSize] = []
    
    // Properties for the top collectionView
    var topCollectionView: UICollectionView!
    let topCellIdentifier = "TopCell"
    let topData = ["top1", "top2", "top3"]
    var topImageSizes: [CGSize] = []
    
    // Outlets from storyboard
    @IBOutlet var bg: UIView!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure background view and images
        bg.clipToBg()
        image1.clipToImage()
        image2.clipToImage()
        image3.clipToImage()
        
        // Setup main collectionView (bottom)
        setupMainCollectionView()
        
        // Setup top collectionView
        setupTopCollectionView()
    }
    
    // MARK: - Setup CollectionViews
    
    func setupMainCollectionView() {
        // Fill imageSizes array with image sizes
        for imageName in data {
            if let image = UIImage(named: imageName) {
                imageSizes.append(image.size)
            } else {
                // If image not found, add default size
                imageSizes.append(CGSize(width: 100, height: 100))
            }
        }
        
        // Create layout for main collectionView (bottom)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5 // Horizontal spacing between items
        layout.minimumLineSpacing = 5 // Vertical spacing between rows
        
        // Calculate position and size of main collectionView
        let collectionViewHeight: CGFloat = 245
        let tabBarHeight: CGFloat = 83  // Adjust according to your tab bar height
        let collectionViewY = view.frame.height - collectionViewHeight - tabBarHeight
        
        // Create main collectionView with the created layout
        collectionView = UICollectionView(frame: CGRect(x: 0, y: collectionViewY, width: view.frame.width, height: collectionViewHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 10 // Corner radius for collectionView
        
        // Add collectionView to main view
        view.addSubview(collectionView)
    }
    
    func setupTopCollectionView() {
        // Fill topImageSizes array with image sizes for top collectionView
        for imageName in topData {
            if let image = UIImage(named: imageName) {
                topImageSizes.append(image.size)
            } else {
                // If image not found, add default size
                topImageSizes.append(CGSize(width: 100, height: 100))
            }
        }
        
        // Create layout for top collectionView
        let topLayout = UICollectionViewFlowLayout()
        topLayout.scrollDirection = .horizontal
        topLayout.minimumInteritemSpacing = 5
        topLayout.minimumLineSpacing = 5
        
        // Calculate position and size of top collectionView
        let topCollectionViewHeight: CGFloat = 190
        let topCollectionViewY: CGFloat = 200 // Adjust according to desired position
        
        // Create top collectionView with the created layout
        topCollectionView = UICollectionView(frame: CGRect(x: 0, y: topCollectionViewY, width: view.frame.width, height: topCollectionViewHeight), collectionViewLayout: topLayout)
        topCollectionView.backgroundColor = .white
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        topCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: topCellIdentifier)
        topCollectionView.clipsToBounds = true
        topCollectionView.layer.cornerRadius = 10 // Corner radius for topCollectionView
        
        // Add topCollectionView to main view
        view.addSubview(topCollectionView)
    }
    
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return topData.count
        } else {
            return data.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellIdentifier, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCustomCollectionViewCell
            cell.imageView.image = UIImage(named: data[indexPath.item])
            cell.imageView.frame = cell.contentView.bounds
            return cell
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView {
            return topImageSizes[indexPath.item]
        } else {
            return imageSizes[indexPath.item]
        }
    }
}

// Custom UICollectionViewCell to display images
class MyCustomCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialize UIImageView inside the cell
        imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFit // Adjust as needed
        imageView.layer.cornerRadius = 10 // Corner radius for imageView inside cell
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}

// Extensions for UIView and UIImageView
extension UIView {
    func clipToBg() {
        self.layoutIfNeeded()
        self.layer.borderColor = UIColor.systemTeal.cgColor
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius = self.frame.height / 10
        self.clipsToBounds = true
    }
}

extension UIImageView {
    func clipToImage() {
        self.layoutIfNeeded()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
