//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Alexander Kaplan on 8/1/16.
//  Copyright © 2016 develop. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate{

    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    var pageIndex: Int!
    
    override func viewDidLoad() {
        pageIndex = 1
        _previewView = previewView
        delegate = self
        //self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.size.height)

        super.viewDidLoad()
  
    }

    override func viewDidAppear(_ animated: Bool) {
        //Guard statemnt is backward so it will only work if the condition is not met
        DataService.instance.currentPageIndex = 1

        guard FIRAuth.auth()?.currentUser != nil else{
            //load login VC
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }
    
    @IBAction func recordBtnPressed(_ sender: AnyObject) {
        toggleMovieRecording()
    }

    @IBAction func changeCameraBtnPressed(_ sender: AnyObject) {
        changeCamera()
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        cameraBtn.isEnabled = enable
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
    }
    
    func recordingHasStarted() {
        print("recording has started")
    }
    
    func canStartRecording() {
        print("can start recording")
    }
    
    func videoRecordingFailed(){
        
    }
    
    func videoRecordingComplete(_ videoURL: URL!){
        performSegue(withIdentifier:"ShowSendSnapVC", sender: ["videoURL":videoURL])
    }
    
    func snapshotFailed() {
        
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        performSegue(withIdentifier: "ShowSendSnapVC", sender: ["snapshotData":snapshotData])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let usersVC = segue.destinationViewController as? UserVC{
            if let videoDict = sender as? Dictionary<String,URL>{
                let url = videoDict["videoURL"]
                usersVC.videoURL = url
            }else if let snapDict = sender as? Dictionary<String,Data>{
                let snapData = snapDict["snapshotData"]
                usersVC.snapData = snapData
            }
        }
    }
}

