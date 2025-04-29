import UIKit
import NMapsMap

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = NMFMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(mapView)
    }
}
