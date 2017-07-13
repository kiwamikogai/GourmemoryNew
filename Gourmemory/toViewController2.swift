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
    
    override func viewDidLoad() {
        
        print()
        
        let region = MKCoordinateRegionMake(coordiate, span)
        mapView.setRegion(region, animated:true)
        
        textField.delegate = self
        annotaion.coordinate = CLLocationCoordinate2DMake(37.331652997806785, -122.03072304117417)
        
        annotaion.title = textField.text!
        annotaion.subtitle = ""
        
        self.mapView.addAnnotation(annotaion)
        
        super.viewDidLoad()
        
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
    
    func firstCam(){
    
        if isCamShown == false{
            cameraStart()
        }
        
        isCamShown = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        firstCam()
    }
    
    @IBAction func SaveKiwami(sender : AnyObject) {
        
        //ここにほぞんするためのこーどをかく
        //まず保存したい情報を抽出する
        let shopname = textField.text
        let shosai = shosaiTextView.text

        
        //Kiwamiオブジェクトでひとまとめにして保存
        let kiwami: Kiwami = Kiwami(shopname: shopname!, image: image, coordinate: annotaion.coordinate, text: shosai!, category: category, date: Date(), weekDay: "木曜")
//        kiwami.image =
//        kiwami.text
//        
        let dataSave: DataSave = DataSave()
        dataSave.save(newkiwami: kiwami)
        
        performSegue(withIdentifier: "toViewController3",sender: nil)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        annotaion.subtitle = dataList[row]
        category = dataList[row]
        print(dataList[row])
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.mapView.removeAnnotation(annotaion)
        
        annotaion.title = textField.text!
        
        self.mapView.addAnnotation(annotaion)
        
    }
    
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

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func returnButton (_ segue:UIStoryboardSegue){
//dismiss(animated: true, completion: self.performSegue(withIdentifier: "ViewController", sender: nil))
        dismiss(animated: true) {
            //nasi
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imageView.image = image
        
        self.dismiss(animated: true, completion: nil)
    }


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


}
