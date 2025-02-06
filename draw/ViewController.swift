//
//  ViewController.swift
//  draw
//
//  Created by Нуридин Сафаралиев on 2/5/25.
//

import UIKit

class DrawingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawingView = DrawingView(frame: view.frame)
        drawingView.backgroundColor = .yellow
        view.addSubview(drawingView)
    }
}
