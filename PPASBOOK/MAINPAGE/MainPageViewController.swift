import UIKit

class MainPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    let cellIdentifier = "MyCell"
    let data = ["slide1", "slide2", "slide3", "slide4", "slide5"]
    var imageSizes: [CGSize] = []

    @IBOutlet var fasiliti: UIButton!
    @IBOutlet var pinjaman: UIButton!
    @IBOutlet var kelas: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fasiliti.clipToB()
        pinjaman.clipToB()
        kelas.clipToB()

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

        // Membuat collectionView dengan layout yang sudah dibuat
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 200), collectionViewLayout: layout)
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
    
extension UIButton {
    func clipToB() {
        self.layoutIfNeeded()
        self.layer.cornerRadius =
        self.frame.height / 10
    }
}
