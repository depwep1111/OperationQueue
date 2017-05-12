//
//  ViewController.swift
//  DispatchQueues
//
//  Created by tran trung thanh on 5/10/17.
//  Copyright © 2017 tran trung thanh. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    let imageURLs = ["http://www.xemanh.net/wp-content/uploads/2016/01/4-14494188890081.jpg", "http://www.xemanh.net/wp-content/uploads/2016/01/4-14494188890081.jpg", "http://www.xemanh.net/wp-content/uploads/2016/01/4-14494188890081.jpg", "http://www.xemanh.net/wp-content/uploads/2016/01/4-14494188890081.jpg"]
    
    class Downloader {
        
        class func downloadImageWithURL(_ url:String) -> UIImage! {
            
            let data = try? Data(contentsOf: URL(string: url)!)
            return UIImage(data: data!)
        }
    }

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    var queue = OperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Using Concurrent Dispatch Queues
    /*@IBAction func didClickOnStart(sender: AnyObject) {
        
        let queue = DispatchQueue.global(qos: .default)
        queue.async() { () -> Void in
            
            
            let img1 = Downloader.downloadImageWithURL(imageURLs[0])
            DispatchQueue.main.async(execute: {
                
                self.imageView1.image = img1
            })
            
        }
        queue.async() { () -> Void in
            
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView2.image = img2
            })
            
        }
        queue.async() { () -> Void in
            
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView3.image = img3
            })
            
        }
        queue.async() { () -> Void in
            
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView4.image = img4
            })
        }
    }*/
    //Using Serial Dispatch Queues
    /*@IBAction func didClickOnStart(sender: AnyObject) {
        
        let serialQueue = DispatchQueue(label: "com.appcoda.imagesQueue")
        
        serialQueue.async() { () -> Void in
            
            let img1 = Downloader .downloadImageWithURL(imageURLs[0])
            DispatchQueue.main.async(execute: {
                
                self.imageView1.image = img1
            })
            
        }
        serialQueue.async() { () -> Void in
            
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView2.image = img2
            })
            
        }
        serialQueue.async() { () -> Void in
            
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView3.image = img3
            })
            
        }
        serialQueue.async() { () -> Void in
            
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView4.image = img4
            })
        }
        
    }*/

    /*@IBAction func didClickOnStart(_ sender: AnyObject) {
        
 
            let img1 = Downloader.downloadImageWithURL(imageURLs[0])
            self.imageView1.image = img1
            
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            self.imageView2.image = img2
            
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            self.imageView3.image = img3
            
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            self.imageView4.image = img4
        
        
    }*/
    @IBAction func didClickOnStart(sender: AnyObject) {
        
        queue = OperationQueue()
        let operation1 = BlockOperation(block: {
            let img1 = Downloader.downloadImageWithURL(self.imageURLs[0])
            OperationQueue.main.addOperation({
                self.imageView1.image = img1
            })
        })
        
        operation1.completionBlock = {
            operation1.completionBlock = {
                print("Operation 1 completed, cancelled:\(operation1.isCancelled) ")
            }
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            let img2 = Downloader.downloadImageWithURL(self.imageURLs[1])
            OperationQueue.main.addOperation({
                self.imageView2.image = img2
            })
        })
        
        operation2.completionBlock = {
            print("Operation 2 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation2)
        
        
        let operation3 = BlockOperation(block: {
            let img3 = Downloader.downloadImageWithURL(self.imageURLs[2])
            OperationQueue.main.addOperation({
                self.imageView3.image = img3
            })
        })
        
        operation3.completionBlock = {
            print("Operation 3 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation3)
        
        let operation4 = BlockOperation(block: {
            let img4 = Downloader.downloadImageWithURL(self.imageURLs[3])
            OperationQueue.main.addOperation({
                self.imageView4.image = img4
            })
        })
        
        operation4.completionBlock = {
            print("Operation 4 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation4)
        
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }
    @IBAction func didClickOnCancel(sender: AnyObject) {
        
        self.queue.cancelAllOperations()
    }


}

