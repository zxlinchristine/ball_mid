
import UIKit

class DetailViewController: UIViewController {
    
   // @IBOutlet var ballImageView: UIImageView!

    @IBOutlet weak var BallImageView: UIImageView!
    var ballImageName = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        BallImageView.image = UIImage(named: ballImageName)
        
    
    }
        static func generateData( sourceArray: inout [Ball]) {
            sourceArray = [
                Ball(name: "baseball", image: "baseball_photo.jpg"),
                Ball(name: "basketball", image: "basketball_photo.jpg"),
                Ball(name: "football", image: "football_photo.jpg"),
                Ball(name: "other",  image: "other_photo.jpg"),
            ]
        }
        
   
}
