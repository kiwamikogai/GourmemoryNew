//
//  toViewController2.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/04/04.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import RealmSwift     //データベース用のライブラリを読み込んでるで
import Photos
import AGEmojiKeyboard

//入力するとこ。センターボタン

//
class ViewController2 : UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, AGEmojiKeyboardViewDelegate, AGEmojiKeyboardViewDataSource{
    
    //var shopname : String!
    //var shosai : String!
    
    var category: String!
    var weakday: String!
    var coordiate2 : CLLocationCoordinate2D!
    var image : UIImage!
    let coordiate = CLLocationCoordinate2DMake(37.331652997806785, -122.03072304117417)
    let myLatitude: CLLocationDegrees = 37.331741
    let myLongitude: CLLocationDegrees = -122.030333
    let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    var span = MKCoordinateSpanMake(0.01 , 0.01)
    var annotaion = MKPointAnnotation()
    var x:MKAnnotation?
    var myPin:MKPointAnnotation = MKPointAnnotation()
    var cal = NSCalendar.current
    let now = NSDate()
    var isCamShown = false
    
    //var categoryData:Results<Category>?
    
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var textField1: UITextField!
    @IBOutlet var buttonImage: UIButton!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet var label: UILabel!
    
    let weekArray:[String] = ["さきね","日","月","火","水","木","金","土"]
    var categoryArray:[Category] = []
    
    var testManager:CLLocationManager = CLLocationManager()
    
    var mapAnnotationView:MKPinAnnotationView = MKPinAnnotationView()
    
    var num = 0
    
    //MARK: - normal
    
    //初回呼び出されるとこ
    override func viewDidLoad() {
        
        var image = UIImage(named:"Image-8")!.withRenderingMode(.alwaysTemplate)
        pinButton.setImage(image, for: .normal)

        mapView.delegate = self
        
        super.viewDidLoad()
        
        let emojiKeyboard = AGEmojiKeyboardView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216), dataSource: self)
        emojiKeyboard?.autoresizingMask = UIViewAutoresizing.flexibleWidth
        emojiKeyboard?.dataSource = self
        emojiKeyboard?.delegate = self
        emojiKeyboard?.backgroundColor = UIColor(rgb: 0xC7E5E7)
        emojiKeyboard?.segmentsBar.backgroundColor = UIColor.white
        emojiKeyboard?.segmentsBar.tintColor = UIColor(rgb: 0x6AB9BE)
        
        self.textfield2.inputView = emojiKeyboard
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x6AB9BE)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //navigationItem.leftBarButtonItem?.setBackgroundImage(UIImage(named: "ばつ.png"), for: .normal, barMetrics: .default)
        
        let region = MKCoordinateRegionMake(coordiate, span)
        mapView.setRegion(region, animated:true)
        mapView.delegate = self
        
        textField1.delegate = self
        annotaion.coordinate = CLLocationCoordinate2DMake(37.331652997806785, -122.03072304117417)
        
        annotaion.title = textField1.text!
        annotaion.subtitle = ""
        
        
        self.mapView.addAnnotation(annotaion)
        
        testManager.delegate = self
        testManager.startUpdatingLocation()
        testManager.requestWhenInUseAuthorization()
        
        
        //画面のラベルに日時表示
        let monthComp = Calendar.Component.month
        let month = NSCalendar.current.component(monthComp, from: NSDate() as Date)
        let dayComp = Calendar.Component.day
        let day = NSCalendar.current.component(dayComp, from: NSDate() as Date)
        let weekcomp = Calendar.Component.weekday
        //let timecomp = Calendar.Component.weekday
        let week = NSCalendar.current.component(weekcomp, from: NSDate() as Date)
        let weekText:String = weekArray[week]
        self.title = String(month) + "月" + String(day) + "日" + "("+weekText+")"
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let realm = RealmFactory.sharedInstance.realm()
        var category = Array(realm.objects(Category.self))
        
        if category.count == 0 {
            
            var cateDefault = Category()
            cateDefault.categoryName = "行った"
            cateDefault.colorCode = "FF5151"
            cateDefault.save()
            
            category = Array(realm.objects(Category.self))
            //return
        }
        
        categoryArray = category
        
        label.text = categoryArray[num].categoryName
        
//        pinButton.setImage(UIImage(named: "image-8"), for: .normal)
        pinButton.tintColor = UIColor(hex: categoryArray[0].colorCode!)
        //image.tintColer = categoryArray[0].colorCode
    }
    
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func tappedPinButton(sender:UIButton){
    
        print("tapped pin button")
        
        label.text = categoryArray[num].categoryName
        if let colorCode = categoryArray[num].colorCode{
            pinButton.tintColor = UIColor(hex: colorCode)
        }
        
//        pinButton.tintColor = UIColor(hex: categoryArray[num].colorCode!)
        num += 1
        
        if num == categoryArray.count{
            num = 0
        }
        
    }
    
    //MARK: - AGEmojiKeyboardViewDataSource
    //AGEmojiKeyboardViewDataSource キーボードの初期設定するところ
    func emojiKeyboardView(_ emojiKeyboardView: AGEmojiKeyboardView!, imageForSelectedCategory category: AGEmojiKeyboardViewCategoryImage) -> UIImage! {
        
        return emojiSilhouette(category: category)
    }
    
    func emojiKeyboardView(_ emojiKeyboardView: AGEmojiKeyboardView!, imageForNonSelectedCategory category: AGEmojiKeyboardViewCategoryImage) -> UIImage! {
        
        return emojiSilhouette(category: category)
    }
    
    //ここで絵文字キーボードのシルエット
    func emojiSilhouette(category: AGEmojiKeyboardViewCategoryImage) -> UIImage!{
        var emojiImage:UIImage! = UIImage()
        
        switch category {
        case .recent:
            emojiImage = "💭".image()
            
        case .face:
            emojiImage = "👷".image()
            
        case .bell:
            emojiImage = "🔔".image()
            
        case .flower:
            emojiImage = "🐱".image()
            
        case .car:
            emojiImage = "🚗".image()
            
        case .characters:
            emojiImage = "♣️".image()
        default:
            break
        }
        
        return emojiImage
        
    }
    
    func backSpaceButtonImage(for emojiKeyboardView: AGEmojiKeyboardView!) -> UIImage! {
        return "🔙".image()
    }
    
    
    //キーボードの動きを見るところ。ここでtextfieldとかに文字を入れる
    func emojiKeyBoardView(_ emojiKeyBoardView: AGEmojiKeyboardView!, didUseEmoji emoji: String!) {
        if (textfield2.text?.characters.count)! <= 2{
            self.textfield2.text?.append(emoji)
        }
        
    }
    
    //ここも必ずかくこと。空っぽでもこのメソッドないとエラーでる
    func emojiKeyBoardViewDidPressBackSpace(_ emojiKeyBoardView: AGEmojiKeyboardView!) {
        if (textfield2.text?.characters.count)! >= 1{
            var str:String = self.textfield2.text!
            str = str.substring(to: str.index(before: str.endIndex))
            self.textfield2.text = str
        }
        
    }
    
    
    
    //データのセーブ。保存ボタンが押されたら呼ばれる
    
    @IBAction func imageAlert(_ sender: Any) {
        
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle:  UIAlertControllerStyle.actionSheet)
        
        let action1 = UIAlertAction(title: "カメラ起動", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("アクション１をタップした時の処理")
            self.cameraStart()
            
        })
        let action2 = UIAlertAction(title: "ライブラリーから", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("アクション２をタップした時の処理")
            self.Library()
        })
        
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func SaveKiwami(sender : AnyObject) {
        
        if textField1.text == "" {
            
            let alertController = UIAlertController(title: "エラー", message: "店名が未記入です", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            //アラートを表示
            present(alertController, animated: true, completion: nil)
            
            print("OK")
            
            return
            
        }
        
        self.textfield2.becomeFirstResponder()  //これを消す
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            //キーボード以外のところをタップするとキーボードを閉じる
            if textField1.isFirstResponder {
                
                textField1.resignFirstResponder()
                
            }
            
            //キーボード以外のところをタップするとキーボードを閉じる
            if textField1.isFirstResponder{
                textField1.resignFirstResponder()
            }
            
        }
        
        //まず保存したい情報を抽出する
        let shopname = textField1.text
        
        //画像のリサイズ。そのままだと大きすぎるから小さくする
        let smallImage = image.resize(image: image, width: Int(image.size.width/2.0), height: Int(image.size.height/2.0))
        
        //画像をData型に変換する。画像そのままだと保存できないんよ
        let saveImage = UIImagePNGRepresentation(smallImage)
        
        //データベースの定義
        let realm = try! Realm()
        
        var cate = Category()
        cate.categoryName = "aaa"
        cate.colorCode = "FFFFFF"
        cate.id = 
        
        //kiwamiオブジェクトの設定
        let kiwami: Kiwami = Kiwami()
        kiwami.id = Kiwami.findAll().count+1
        kiwami.shopname = shopname!
        kiwami.imageData = saveImage
        kiwami.latitude = annotaion.coordinate.latitude
        kiwami.longitude = annotaion.coordinate.longitude
        kiwami.categoryId = categoryArray[num].id
        kiwami.date = Date()
        kiwami.weekDay = self.title
        
        kiwami.save()
        
        //データベースに保存 try! realm.writeで書き込みモード
//        try! realm.write {
//            //realm.add(保存するクラス)でクラス名に応じて保存できるで
//            realm.add(kiwami)
//            print("保存できたで")
//        }
        
        
        //保存できたら画面消す
        dismiss(animated: true) {
        }
    }
    
    //textFieldに入力おわったら呼ばれるやつ
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.mapView.removeAnnotation(annotaion)
        
        annotaion.title = textField.text!
        
        self.mapView.addAnnotation(annotaion)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinView = MKPinAnnotationView()
        
        mapAnnotationView = pinView
        
        return mapAnnotationView
        
    }
    
    //カメラの起動を1回だけにするとこ
    func firstCam(){
        if isCamShown == false{
            cameraStart()
        }
        isCamShown = true
        
    }
    
    func cameraStart() {
        
        print("cameraStart")
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        
    }
    
    func Library(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let picker = UIImagePickerController()
            picker.modalPresentationStyle = UIModalPresentationStyle.popover
            picker.delegate = self
            // UINavigationControllerDelegateとUIImagePickerControllerDelegateを実装する
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            self.present(picker, animated: true, completion: nil)
        }
        
        print("cameraStart")
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    
    //imagePickerで撮った画像をViewController2に渡すとこ
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        let referenceURL = info[UIImagePickerControllerReferenceURL]
        
        buttonImage.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        buttonImage.setBackgroundImage(image, for: .normal)// = image
        buttonImage.setTitle("", for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //imagePicerを呼び出したけどキャンセルした時動くとこ
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //画面タッチされたら動くとこ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //戻るボタン押されたら画面消すとこ
    @IBAction func returnButton (_ segue:UIStoryboardSegue){
        
        dismiss(animated: true) {
            //nasi
        }
    }
    
    //アラート出すとこ
    
    func showAlert(title: String, message: String) {
        let alertView = UIAlertView()
        alertView.title = title
        alertView.message = message
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    //mapのとこ
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            
            let rejion = MKCoordinateRegionMake(center, span)
            mapView.setRegion(rejion, animated:true)
            
            let annotation = MKPointAnnotation()
            annotaion.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            mapView.addAnnotation(annotation)
            
        }
    }
}
