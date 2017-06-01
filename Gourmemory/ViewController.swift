//
//  ViewController.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/02/02.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit

import MapKit

import AVFoundation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    private var myTextField: UITextField!
    
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput : AVCaptureStillImageOutput!
    // MKMapViewDelegate の追加
    
    let coordiate = CLLocationCoordinate2DMake(37.331652997806785, -122.03072304117417)
    
    var span = MKCoordinateSpanMake(0.01 , 0.01)
    
    var annotaion = MKPointAnnotation()
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var mapView:MKMapView!
    @IBOutlet var selectedImageView : UIImageView!
    
    var testManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        let region = MKCoordinateRegionMake(coordiate, span)
        mapView.setRegion(region, animated:true)
        
        annotaion.coordinate = CLLocationCoordinate2DMake(37.331652997806785, -122.03072304117417)
        annotaion.title = "ラーメン屋"
        
        annotaion.subtitle = "豚骨系"
        self.mapView.addAnnotation(annotaion)
        
        super.viewDidLoad()
        
        testManager.delegate = self as! CLLocationManagerDelegate
        testManager.startUpdatingLocation()
        testManager.requestWhenInUseAuthorization()
        
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        if error != nil {
            showAlert(title: "きわみ", message: "Failed to save the picture.")
        } else {
            showAlert(title: "きわみ", message: "The picture was saved.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertView = UIAlertView()
        alertView.title = title
        alertView.message = message
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController2" {
            let vc2: ViewController2 = segue.destination as! ViewController2
            
            vc2.shopname = "self"
            vc2.coordiate2 = coordiate
            vc2.image = imageView.image
            self.imageView.image = nil
            
        }
        
    }
    
}

