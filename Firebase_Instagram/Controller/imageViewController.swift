//
//  imageViewController.swift
//  Firebase_Instagram
//
//  Created by Irshadali Palsaniya on 05/07/19.
//  Copyright © 2019 Irshadali Palsaniya. All rights reserved.
//

import UIKit

class imageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var imageOne : UIImage?
    var story: String?
    
    var panRecognizer: UIPanGestureRecognizer?
    var pinchRecognizer: UIPinchGestureRecognizer?
    var rotateRecognizer: UIRotationGestureRecognizer?

    @IBOutlet weak var imageViewOut: UIImageView!
    @IBOutlet weak var ImageTextOut: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewOut.image = imageOne
        ImageTextOut.text = story
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    @IBAction func handlePinch(recognizer:UIPinchGestureRecognizer) {

        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }

    }
    @IBAction func handleRotate(recognizer:UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
 
}
