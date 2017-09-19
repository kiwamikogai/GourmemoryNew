import UIKit
import MapKit
import AVFoundation
import RealmSwift     //データベース用のライブラリを読み込んでるで
class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    private var myTextField: UITextField!
    
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput : AVCaptureStillImageOutput!
    // MKMapViewDelegate の追加
    
    let coordiate = CLLocationCoordinate2DMake(38.973599, 136.977116)
    
    var span = MKCoordinateSpanMake(24.0,0.4)
    
    var annotaion = MKPointAnnotation()
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var selectedImageView : UIImageView!
    
    var annotationData:Results<Kiwami>!
    
    var testManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        mapView.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x6AB9BE)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        let region = MKCoordinateRegionMake(coordiate, span)
        mapView.setRegion(region, animated: true)
        
        readKiwamiData()
        
        super.viewDidLoad()
        
        testManager.delegate = self as! CLLocationManagerDelegate
        testManager.startUpdatingLocation()
        testManager.requestWhenInUseAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readKiwamiData()
        mapView.reloadInputViews()
    }
    
    
    //保存したデータを読み込んで、ピン打つとこ！
    func readKiwamiData(){
        //realmに保存したデータを読み込んでいく!!
        
        //データベースの定義
        let realm = try! Realm()
        
        //保存されたKiwamiのデータが空じゃなければ
        if realm.objects(Kiwami.self) != nil {
            
            //Kiwamiクラスのデータの読み込み realm.object(クラス名.self)で読み込めるよ！
            annotationData = realm.objects(Kiwami.self)
            
            
            //annotationを追加しまくる
            for i in 0..<annotationData.count {
                
                let kiwami:Kiwami = annotationData[i]
                
                var annotaion = MKPointAnnotation()
                
                annotaion.coordinate = CLLocationCoordinate2DMake(kiwami.latitude, kiwami.longitude)
                annotaion.title = kiwami.shopname
                annotaion.subtitle = kiwami.text
                self.mapView.addAnnotation(annotaion)
            }
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            
            
            //センターに持ってきちゃう
            //            let rejion = MKCoordinateRegionMake(center, span)
            //            mapView.setRegion(rejion, animated:true)
            
            let annotation = MKPointAnnotation()
            annotaion.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            mapView.addAnnotation(annotation)
            
        }
    }
    
    
    
    /* ボタン追加したから要らないとこ
     
     
     @IBAction func cameraStart(sender : AnyObject) {
     
     let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
     
     if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
     let cameraPicker = UIImagePickerController()
     cameraPicker.sourceType = sourceType
     cameraPicker.delegate = self
     self.present(cameraPicker, animated: true, completion: nil)
     
     }
     
     }
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     
     if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
     self.imageView.image = pickedImage
     }
     picker.dismiss(animated: true, completion: {
     
     self.performSegue(withIdentifier: "toViewController2", sender: nil)
     })
     
     }
     @IBAction func buttonTapped(sender : AnyObject) {
     performSegue(withIdentifier: "toViewController2",sender: nil)
     
     }
     
     
     func imagePickerControllerDidCancel(picker: UIImagePickerController) {
     picker.dismiss(animated: true, completion: nil)
     }
     
     */
    
    //アラート出すならメソッドの中確認！！
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        if error != nil {
            showAlert(title: "きわみ", message: "Failed to save the picture.")
        } else {
            showAlert(title: "きわみ", message: "The picture was saved.")
        }
    }
    
    //アラート出すメソッド
    func showAlert(title: String, message: String) {
        let alertView = UIAlertView()
        alertView.title = title
        alertView.message = message
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    //画面遷移ないならここも要らんかな！現状呼ばれてないよ！
    override func prepare(
        for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController2" {
            let vc2: ViewController2 = segue.destination as! ViewController2
            
            //vc2.shopname = "self"
            vc2.coordiate2 = coordiate
            vc2.image = imageView.image
            self.imageView.image = nil
            
        }
        
    }
    
}
