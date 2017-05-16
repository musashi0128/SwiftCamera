//
//  SNSViewController.swift
//  SwiftInstaCamera1
//
//  Created by 宮本一彦 on 2016/11/20.
//  Copyright © 2016年 宮本一彦. All rights reserved.
//

import UIKit
import Social

class SNSViewController: UIViewController {
    
    
    var endImage:UIImage = UIImage()
    
    // SNSシェア用
    var myComposeView: SLComposeViewController!
    
    @IBOutlet var endImageView: UIImageView!
    
    @IBOutlet var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endImageView.image = endImage
    }
    
    // キーボードを下げる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (textView.isFirstResponder) {
            textView.resignFirstResponder()
        }
    }
    
    @IBAction func save(_ sender: Any) {
        
        // 画像を保存する
        UIImageWriteToSavedPhotosAlbum(endImageView.image!, self, nil, nil)
        
        let alertController = UIAlertController(title: "保存が完了しました。", message: "OKボタンを押してください", preferredStyle: .alert)
        
        let okAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) -> Void in
            // 処理
        })
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func share(_ sender: Any) {
        
        // SNSへ投稿するメニュー画面
        // アラート
        
        let alertController = UIAlertController(title: "SNSへ投稿する", message: "投稿する場所を選んでください。", preferredStyle: .actionSheet)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{
            (action:UIAlertAction!) -> Void in
            // キャンセルボタンの処理を書く
        })
        
        let defaultAction1:UIAlertAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) -> Void in
            // Facebookの処理
            self.postFacebook()
        })
        
        let defaultAction2:UIAlertAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) -> Void in
            // Facebookの処理
            self.postTwitter()
        })
        
        let defaultAction3:UIAlertAction = UIAlertAction(title: "LINE", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) -> Void in
            // LINEの処理
            self.postLINE()
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction1)
        alertController.addAction(defaultAction2)
        alertController.addAction(defaultAction3)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // Twitterに投稿するメソッド
    func postTwitter() {
        
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        myComposeView.setInitialText(textView.text)
        
        myComposeView.add(endImageView.image)
        
        self.present(myComposeView, animated: true, completion: nil)
        
        // SNSへの投稿画面が自動的に立ち上がる

    }
    
    // Facebookniに投稿するメソッド
    func postFacebook() {
        
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        myComposeView.setInitialText(textView.text)
        
        myComposeView.add(endImageView.image)
        
        self.present(myComposeView, animated: true, completion: nil)
        
        // SNSへの投稿画面が自動的に立ち上がる

    }
    
    // LINEに投稿するメソッド
    func postLINE() {
        
        let pastBoard: UIPasteboard = UIPasteboard.general
        pastBoard.setData(UIImageJPEGRepresentation(endImageView.image!, 0.75)!,
                          forPasteboardType: "public.png")
        pastBoard.setValue(textView.text, forPasteboardType:textView.text)
        let lineUrlString: String = String(format: "line://msg/image/%@",
                                           pastBoard.name as CVarArg)
        UIApplication.shared.open(NSURL(string: lineUrlString)! as URL)
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        let alertController = UIAlertController(title: "本文は破棄されてしまいます。", message: "よろしいですか？", preferredStyle: .alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{
            (action:UIAlertAction!) -> Void in
            // キャンセルボタンの処理を書く
        })
        
        let okAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) -> Void in
            // 戻る
            self.navigationController?.popViewController(animated: true)
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
