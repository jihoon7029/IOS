//
//  MemoFormVC.swift
//  My_Memory
//
//  Created by Kim Jihoon on 2018. 1. 2..
//  Copyright © 2018년 Kim_Jihoon. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var subject: String!

    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: "Hi", message: "내용을 입력하세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style:.default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        let data = MemoData()
        data.title = self.subject
        data.contents = self.contents.text
        data.image=preview.image
        data.regdate=Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        _=self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pick(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate=self
        picker.allowsEditing=true
        self.present(picker, animated: false)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.preview.image=info[UIImagePickerControllerEditedImage] as? UIImage
        
        picker.dismiss(animated: false)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15: contents.length)
        self.subject=contents.substring(with: NSRange(location: 0, length: length))
        self.navigationItem.title = subject
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate=self
        // Do any additional setup after loading the view.
    }

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
