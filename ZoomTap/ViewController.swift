//
//  ViewController.swift
//  ZoomTap
//
//  Created by techmaster on 11/4/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var ViewScroll: UIScrollView!
    var photo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let imgView = UIImageView(image: UIImage(named: "fanartChaosKnight.jpg"))
        imgView.frame = CGRect(x: 0, y: 0, width: ViewScroll.frame.size.width, height: ViewScroll.frame.size.height)
        imgView.isUserInteractionEnabled = true
        imgView.isMultipleTouchEnabled = true
        imgView.contentMode = .scaleAspectFit
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(doubleTap)
        singleTap.require(toFail: doubleTap)
        
        photo = imgView
        ViewScroll.contentSize = CGSize(width: imgView.bounds.width, height: imgView.bounds.height)
//        ViewScroll.minimumZoomScale = 0.5
//        ViewScroll.maximumZoomScale = 2
        
        self.ViewScroll.addSubview(imgView)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photo
    }
    
    @IBAction func sliderZoom(_ sender: UISlider) {
        var scale = 2*CGFloat(sender.value*2)
        photo.frame = CGRect(x: 0, y: 0, width: ViewScroll.frame.size.width * scale, height: ViewScroll.frame.size.height * scale)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func singleTap(_ gesture: UIGestureRecognizer) {
        let position = gesture.location(in: photo)
        zoomImg(ViewScroll.zoomScale * 2, center: position)
    }
  
    func doubleTap(_ gesture: UIGestureRecognizer) {
        let position = gesture.location(in: photo)
        zoomImg(ViewScroll.zoomScale * 0.5, center: position)
    }
    
    func zoomImg(_ scale: CGFloat, center: CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = ViewScroll.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        ViewScroll.zoom(to: zoomRect, animated: true)
    }
}

