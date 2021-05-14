import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var cargarndoLabel: UILabel!
    @IBOutlet weak var cargandoActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var colleccion: UICollectionView!
    
    // MARK: Properties
    private let imagenes: Array<String> = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
    ]
    
    private var anteriorImagen = 0
    private var contadorImagen = 0
    
    // MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        disenoBarra()
        
        if let layout = colleccion.collectionViewLayout as? InstagramLayout {
                layout.delegate = self
        }
        
        colleccion.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // MARK: Metodos
    private func disenoBarra() -> Void {
        if #available(iOS 13.0, *) {
            let app = UINavigationBarAppearance()
            app.backgroundColor = UIColor.red
            self.navigationController?.navigationBar.scrollEdgeAppearance = app
            self.navigationController?.navigationBar.compactAppearance = app
        }
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.red
    }

}

// MARK: DataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCellCollectionViewCell
        celda.llenarInfo(nombre: self.imagenes[indexPath.row])
        return celda
    }
    
}

// MARK: DataSourceFlowLayout
extension ViewController: InstagramLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeForViewAtIndexPath indexPath: IndexPath) -> Int {
        
        print("Anterior Imagen \(anteriorImagen)")
        
        switch anteriorImagen {
            case 0:
                contadorImagen += 1
                let numRandom = Int.random(in: 1...3)
                anteriorImagen = numRandom
                return numRandom
            case 1:
                if contadorImagen == 2 {
                    contadorImagen = 0
                    let nuevaImg = Int.random(in: 2...3)
                    anteriorImagen = nuevaImg
                    return nuevaImg
                } else {
                    contadorImagen += 1
                    anteriorImagen = 1
                    return 1
                }
            case 2:
                if contadorImagen == 1 {
                    contadorImagen = 0
                    anteriorImagen = 1
                    return 1
                } else {
                    contadorImagen += 1
                    anteriorImagen = 3
                    return 3
                }
            case 3:
                contadorImagen = 0
                let nuevaImg = Int.random(in: 1...2)
                anteriorImagen = nuevaImg
                return nuevaImg
            default:
                return 1
        }
        
    }
    
    func numberOfColumnsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
}

/* Extension Original
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tamanioPantalla: CGRect = UIScreen.main.bounds
        let filas: CGFloat = 2.0
        let ancho = (tamanioPantalla.width / filas) * 0.8
        
        return CGSize(width: ancho, height: CGFloat.random(in: ancho...ancho * 2))
    }
    
    // Agregamos espacio entre las lineas y agregamos margen de 10
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
}*/
