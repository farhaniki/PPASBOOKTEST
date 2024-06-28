import UIKit

class MainPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    let cellIdentifier = "MyCell"
    let data = ["slide1", "slide2", "slide3", "slide4", "slide5"]
    var imageSizes: [CGSize] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mengisi array imageSizes dengan ukuran gambar
        for imageName in data {
            if let image = UIImage(named: imageName) {
                imageSizes.append(image.size)
            } else {
                // Jika gambar tidak ditemukan, tambahkan ukuran default
                imageSizes.append(CGSize(width: 100, height: 100))
            }
        }

        // Membuat layout untuk collectionView dengan scroll horizontal
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        // Mengatur tinggi dan posisi collectionView di bagian bawah
        let collectionViewHeight: CGFloat = 500
        let collectionViewY = view.frame.height - collectionViewHeight  // Menghitung nilai y
        
        // Membuat collectionView dengan layout yang sudah dibuat
        collectionView = UICollectionView(frame: CGRect(x: 0, y: collectionViewY, width: view.frame.width, height: collectionViewHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        // Menambahkan collectionView ke tampilan utama
        view.addSubview(collectionView)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCustomCollectionViewCell
        cell.imageView.image = UIImage(named: data[indexPath.item]) // Menggunakan nama gambar dari array data
        cell.imageView.frame = cell.contentView.bounds

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Mengatur ukuran cell berdasarkan ukuran gambar
        return imageSizes[indexPath.item]
    }
}

// Custom UICollectionViewCell untuk menampilkan gambar
class MyCustomCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Inisialisasi UIImageView di dalam sel
        imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFit // Sesuaikan dengan kebutuhan Anda
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
