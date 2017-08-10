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
import RealmSwift       //データベース用のライブラリを読み込んでるで

//入力するとこ。センターボタン

class ViewController2 : UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    let dataList = ["スイーツ","朝ごはん","小腹","和食","洋食"]
    //var shopname : String!
    //var shosai : String!
    var categoryPickerView: UIPickerView!
    var category: String!
    var coordiate2 : CLLocationCoordinate2D!
    var image : UIImage!
    let coordiate = CLLocationCoordinate2DMake(37.331652997806785, -122.03072304117417)
    let myLatitude: CLLocationDegrees = 37.331741
    let myLongitude: CLLocationDegrees = -122.030333
    let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    var span = MKCoordinateSpanMake(0.01 , 0.01)
    var annotaion = MKPointAnnotation()
    var myPin:MKPointAnnotation = MKPointAnnotation()
    var cal = NSCalendar.current
    let now = NSDate()
    var isCamShown = false
    
    @IBOutlet var imageView2 : UIImageView!
    @IBOutlet var mapView : MKMapView!
    @IBOutlet var selectedImageView : UIImageView!
    @IBOutlet var textField : UITextField!
    @IBOutlet var dateLabel : UILabel!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var shosaiTextView : UITextView!
    
    let weekArray:[String] = ["さきね","日","月","火","水","木","金","土"]
    
    var pickerView : UIPickerView!
    var testManager:CLLocationManager = CLLocationManager()
    
    
    
    //MARK: - normal
    
    //初回呼び出されるとこ
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let region = MKCoordinateRegionMake(coordiate, span)
        mapView.setRegion(region, animated:true)
        
        textField.delegate = self
        annotaion.coordinate = CLLocationCoordinate2DMake(37.331652997806785, -122.03072304117417)
        
        annotaion.title = textField.text!
        annotaion.subtitle = ""
        
        self.mapView.addAnnotation(annotaion)
        
        
        
        testManager.delegate = self
        testManager.startUpdatingLocation()
        testManager.requestWhenInUseAuthorization()
        
        categoryPickerView = UIPickerView(frame: CGRect(x: 200, y: 0, width: self.view.frame.width - 200, height: 100))
        categoryPickerView.center.y = self.view.center.y - 160
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self as! UIPickerViewDataSource
        categoryPickerView.selectRow(1, inComponent: 0, animated: true)
        
        self.view.addSubview(categoryPickerView)
        imageView2.image = image
        
        
        //画面のラベルに日時表示
        let monthComp = Calendar.Component.month
        let month = NSCalendar.current.component(monthComp, from: NSDate() as Date)
        let dayComp = Calendar.Component.day
        let day = NSCalendar.current.component(dayComp, from: NSDate() as Date)
        let weekcomp = Calendar.Component.weekday
        let week = NSCalendar.current.component(weekcomp, from: NSDate() as Date)
        let weekText:String = weekArray[week]
        dateLabel.text = String(month) + "月" + String(day) + "日" + "("+weekText+")"
        //        print(weekday)
        //        print(weekdays[weekday])
        
    }
    
    //画面が表示されるたび最初に呼ばれるとこ
    override func viewDidAppear(_ animated: Bool) {
        firstCam()
    }
    
    
    
    //データのセーブ。保存ボタンが押されたら呼ばれる
    @IBAction func SaveKiwami(sender : AnyObject) {
        
        //ここにほぞんするためのこーどをかく
        //まず保存したい情報を抽出する
        let shopname = textField.text
        let shosai = shosaiTextView.text
        
        
        //画像のリサイズ。そのままだと大きすぎるから小さくする
        var smallImage = image.resize(image: image, width: Int(image.size.width/2.0), height: Int(image.size.height/2.0))
        
        //画像をData型に変換する。画像そのままだと保存できないんよ
        var saveImage = UIImagePNGRepresentation(smallImage)
        
        
        //データベースの定義
        let realm = try! Realm()
        
        //kiwamiオブジェクトの設定
        let kiwami: Kiwami = Kiwami()
        kiwami.shopname = shopname!
//        kiwami.image = image!
        kiwami.imageData = saveImage
        kiwami.latitude = annotaion.coordinate.latitude
        kiwami.longitude = annotaion.coordinate.longitude
        kiwami.text = shosai!
        kiwami.category = category
        kiwami.date = Date()
        kiwami.weekDay = "木曜"
        
        //データベースに保存 try! realm.writeで書き込みモード
        try! realm.write {
            //realm.add(保存するクラス)でクラス名に応じて保存できるで
            realm.add(kiwami)
            print("保存できたで")
        }
        
        
        //保存できたら画面消す
        dismiss(animated: true) {
        }
        

        
        
        //Kiwamiオブジェクトでひとまとめにして保存
        /*
        let kiwami: Kiwami = Kiwami(shopname: shopname!, image: image, coordinate: annotaion.coordinate, text: shosai!, category: category, date: Date(), weekDay: "木曜")
        kiwami.image =
        kiwami.text
        
        let dataSave: DataSave = DataSave()
        dataSave.save(newkiwami: kiwami)
        */
        
        
        //画面遷移なかったからコメントアウトしといた
        /*
        performSegue(withIdentifier: "toViewController3",sender: nil)
        */
        
    }
    
    
    //MARK: - pickerView
    
    //列の数 横にいくつに分けるか
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    //行数の設定
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    //1行に表示する内容の設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    //選択されたら呼び出されるメソッド
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        annotaion.subtitle = dataList[row]
        category = dataList[row]
        print(dataList[row])
    }
    
    
    //MARK: - textField
    
    
    //textFieldに入力おわったら呼ばれるやつ
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.mapView.removeAnnotation(annotaion)
        
        annotaion.title = textField.text!
        
        self.mapView.addAnnotation(annotaion)
        
    }
    
    
    //MARK: - Camera
    
    
    //カメラの起動を1回だけにするとこ
    func firstCam(){
        if isCamShown == false{
            cameraStart()
        }
        isCamShown = true
        
    }

    //カメラの起動するとこ
    func cameraStart() {
        
        print("cameraStart")
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        
    }
    
    //imagePickerで撮った画像をViewController2に渡すとこ
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imageView.image = image
        
        self.dismiss(animated: true, completion: nil)
    }

    
    //imagePicerを呼び出したけどキャンセルした時動くとこ
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    
    //ほっとくとこ。メモリ管理系
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
