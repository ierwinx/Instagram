import UIKit

class PhotoCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagen: UIImageView!
    
    public func llenarInfo(nombre: String) {
        imagen.image = UIImage(named: nombre)
    }
    
}
