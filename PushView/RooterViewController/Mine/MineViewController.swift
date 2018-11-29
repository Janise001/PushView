//
//  HomeViewController.swift
//  PushView
//
//  Created by 吴丽娟 on 2018/8/29.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
import Alamofire
class MineViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //选择语句
    let tipLabel:UILabel = UILabel()
    //collectionView
    var collectionView:UICollectionView?
    var flowLayout:UICollectionViewFlowLayout?
    //选中图片数组
    var images:[UIImage] = []{
        didSet {
            self.collectionView?.reloadData()
        }
    }
    //选择图片按钮（跳转至相册选择，最多只允许选择三张图片）
    let chooseBtn:UIButton = UIButton()
    //图片选择器
    let photoPicker:UIImagePickerController = UIImagePickerController()
    //图片上传按钮
    let uploadBtn:UIButton = UIButton()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "imgaeCell", for: indexPath)
        if cell == nil {
            cell = UICollectionViewCell()
        }
        let imageView:UIImageView = UIImageView(image: self.images[indexPath.item])
        imageView.frame = CGRect(x: 10, y: 10, width: 50, height: 80)
        cell?.addSubview(imageView)
        return cell!
    }
    let uploadURL = "http://192.168.111.234:8080/emall/uploadAction"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tipLabel.text = "请选择三张图片"
        self.chooseBtn.setTitle("选择图片", for: .normal)
        self.chooseBtn.setTitleColor(Color.tinColor, for: .normal)
        
        self.flowLayout = UICollectionViewFlowLayout()
        
        self.view.addSubview(self.tipLabel)
        self.tipLabel.frame = CGRect(x: 20, y: 100, width: 0, height: 0)
        self.tipLabel.sizeToFit()
        
        self.view.addSubview(self.chooseBtn)
        self.chooseBtn.frame = CGRect(x: 20, y: 120, width: 0, height: 0)
        self.chooseBtn.sizeToFit()
        self.chooseBtn.addTarget(self, action: #selector(openAlbum), for: .touchUpInside)
        
        self.collectionView = UICollectionView(frame: CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width-40, height: 300), collectionViewLayout: self.flowLayout!)
        self.collectionView?.backgroundColor = Color.white
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.flowLayout?.itemSize = CGSize(width: 100, height: 160)
        self.view.addSubview(self.collectionView!)
        self.collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "imgaeCell")
        
        self.collectionView?.sizeToFit()
        self.collectionView?.layer.borderWidth = 1
        self.collectionView?.layer.borderColor = Color.tinColor.cgColor
        
        self.photoPicker.sourceType = .photoLibrary
        self.photoPicker.delegate = self
        
        self.uploadBtn.setTitle("上传图片", for: .normal)
        self.uploadBtn.setTitleColor(Color.tinColor, for: .normal)
        self.uploadBtn.addTarget(self, action: #selector(uploadImages), for: .touchUpInside)
        self.uploadBtn.frame = CGRect(x: 20, y: 500, width: 0, height: 0)
        self.uploadBtn.sizeToFit()
        self.view.addSubview(self.uploadBtn)
    }
    @objc func uploadImages(){

                Alamofire.upload(
                    multipartFormData: { multipartFormData in
                        if let imageData = UIImage.dataWithImage(self.images[0]) {
                            multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                        }else {
                            return
                        }
                },to: uploadURL,encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        //连接服务器成功后，对json的处理
                        upload.responseJSON { response in
                            //解包
                            guard let result = response.result.value else { return }
                            print("json:\(result)")
                        }
                        //获取上传进度
                        upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                            print("图片上传进度: \(progress.fractionCompleted)")
                        }
                    case .failure(let encodingError):
                        //打印连接失败原因
                        print(encodingError)
                    }
                })
    }
    @objc func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            
            //设置媒体类型
            //            picker.mediaTypes = [kCICategoryVideo as String,kCIAttributeTypeImage as String]
            //设置允许编辑
            self.photoPicker.allowsEditing = true
            
            //指定图片控制器类型
            self.photoPicker.sourceType = .photoLibrary
            
            //            //弹出控制器,显示界面
            self.present(self.photoPicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView.init(title: "读取相册错误!", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    //实现图片控制器代理方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //查看info对象
        print(info)
        
        //获取选择的原图
        let originImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //赋值，图片视图显示图片
        self.images.append(originImage)
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: nil)
    }
    
    //取消图片控制器代理
    //    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    //
    //        //图片控制器退出
    //        picker.dismiss(animated: true, completion: nil)
    //    }
    
    //    @objc func pushToView(){
    //        let pushView = PushViewController()
    //        self.navigationController?.pushViewController(pushView, animated: true)
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension UIImage {
    public static func dataWithImage(_ image:UIImage) -> Data? {
        var scale:CGFloat = 1.0
        var data:Data? = {
            var data:Data?
            repeat {
                if let tempData = image.scaleData(scale) {
                    data = tempData
                }else {
                    return data
                }
                scale -= 0.3
            } while (data?.count ?? 0) > 1024 * 1024  && scale >= 0
            return data
        }()
        if data == nil {
            data = UIImagePNGRepresentation(image)
        }
        return data
    }
    public func scaleData(_ scale:CGFloat) -> Data? {
        //        if let tempData = UIImageHEICRepresentation(self, scale) {
        //            return tempData
        //        }else
        if let tempData = UIImageJPEGRepresentation(self, scale) {
            return tempData
        }else {
            return nil
        }
    }
}
