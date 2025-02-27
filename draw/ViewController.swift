//
//  ViewController.swift
//  draw
//
//  Created by Нуридин Сафаралиев on 2/5/25.
//

import UIKit

class DrawingViewController: UIViewController {
    
    private let drawingView = DrawingView()

    private let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let colorButtons: [UIButton] = {
        let colors: [UIColor] = [.red, .blue, .green, .black, .orange]
        return colors.map { color in
            let button = UIButton()
            button.backgroundColor = color
            button.layer.cornerRadius = 15
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            return button
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingView.frame = view.frame
        drawingView.backgroundColor = .white
        view.addSubview(drawingView)
        view.addSubview(clearButton)
        
        clearButton.addTarget(self, action: #selector(clearDrawing), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: colorButtons)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            clearButton.widthAnchor.constraint(equalToConstant: 200),
            clearButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -20)
        ])
        
        for (index, button) in colorButtons.enumerated() {
            button.addTarget(self, action: #selector(changeColor(_:)), for: .touchUpInside)
            button.tag = index
        }
    }
    
    @objc private func clearDrawing() {
        drawingView.clearDrawing()
    }

    @objc private func changeColor(_ sender: UIButton) {
        let colors: [UIColor] = [.red, .blue, .green, .black, .orange]
        drawingView.currentColor = colors[sender.tag]
    }
}
