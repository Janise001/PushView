//
//  MineViewController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/8/29.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices
import AssetsLibrary
import AVKit
import AVFoundation

class HomeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let vedioLabel:LabelView = LabelView(text: "视频录入(AVCaptureDevice)")
    /// 录制视频Button
    let makeVedioButton: ButtonView = ButtonView(title: "录制视频")
    /// 获取相册视频Button
    let takeAlbumVedioButton: ButtonView = ButtonView(title: "获取相册视频")
    /// 获取app已拍摄视频
    let takeAppVedioButton: ButtonView = ButtonView(title: "获取app已拍摄视频")
    //--------------------------------------------------------------
    /// 语音录入Label
    let audioLabel:LabelView = LabelView(text: "语音录入")
    /// 录制单个语音按钮
    let takeSingleAudioButton: ButtonView = ButtonView(title: "录制单个语音")
    /// 录制多个语音按钮
    let takeMultipleAudioButton: ButtonView = ButtonView(title: "录制多个语音")
    //--------------------------------------------------------------
    /// 录屏功能Label
    let replayLabel:LabelView = LabelView(text: "录屏功能")
    /// 录制语音按钮
    let takeReplayButton: ButtonView = ButtonView(title: "开启录屏")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.vedioLabel)
        self.view.addSubview(self.makeVedioButton)
        self.view.addSubview(self.takeAlbumVedioButton)
        self.view.addSubview(self.takeAppVedioButton)
        self.view.addSubview(self.audioLabel)
        self.view.addSubview(self.takeSingleAudioButton)
        self.view.addSubview(self.takeMultipleAudioButton)
        makeVedioButton.addTarget(self, action: #selector(pushToFabricateVedio), for: .touchUpInside)
        takeAlbumVedioButton.addTarget(self, action: #selector(takeVideosFromAlbum), for: .touchUpInside)
        takeAppVedioButton.addTarget(self, action: #selector(takeVideosFromApp), for: .touchUpInside)
        takeSingleAudioButton.addTarget(self, action: #selector(takeSingleVideo), for: .touchUpInside)
        takeMultipleAudioButton.addTarget(self, action: #selector(takeMutiAudios), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vedioLabel.frame = CGRect(x: 20, y: 80, width: 0, height: 0)
        self.vedioLabel.sizeToFit()
        self.makeVedioButton.frame = CGRect(x: 20, y: 130, width: 0, height: 0)
        self.makeVedioButton.sizeToFit()
        self.takeAlbumVedioButton.frame = CGRect(x: 20, y: 180, width: 0, height: 0)
        self.takeAlbumVedioButton.sizeToFit()
        self.takeAppVedioButton.frame = CGRect(x: 20, y: 230, width: 0, height: 0)
        self.takeAppVedioButton.sizeToFit()
        self.audioLabel.frame = CGRect(x: 20, y: 280, width: 0, height: 0)
        self.audioLabel.sizeToFit()
        self.takeSingleAudioButton.frame = CGRect(x: 20, y: 330, width: 0, height: 0)
        self.takeSingleAudioButton.sizeToFit()
        self.takeMultipleAudioButton.frame = CGRect(x: 20, y: 380, width: 0, height: 0)
        self.takeMultipleAudioButton.sizeToFit()
    }
    /// 跳转至视频录制页
    @objc func pushToFabricateVedio() {
        let vc = MakeVedioController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// 从相册获取视频文件
    @objc func takeVideosFromAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [ kUTTypeMovie as String]
            
            self.present(imagePicker, animated: true, completion: nil)
        }else {
            print("相册访问失败")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pathURL = info[UIImagePickerControllerMediaURL] as! URL
        let path = pathURL.relativePath
        print("视频地址：\(path)")
        self.dismiss(animated: true, completion: nil)
        playTheVideo(pathURL,controller: self)
    }
    /// 获取通过app拍摄的视频
    @objc func takeVideosFromApp() {
        
    }
    /// 跳转至单个语音录入页面
    @objc func takeSingleVideo() {
        self.navigationController?.pushViewController(MakeSingleAudioController(), animated: true)
    }
    /// 跳转至多个语音录入页面
    @objc func takeMutiAudios() {
        self.navigationController?.pushViewController(MakeMultiAudioController(), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
//class Button:UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.
//    }
//}
