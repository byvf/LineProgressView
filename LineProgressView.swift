//
//  LineProgressView.swift
//  LineProgressView
//
//  Created by Vladyslav Filippov on 23.02.2021.
//

import UIKit

class ProgressValueObserve: NSObject {
    @objc dynamic var progress: CGFloat = 0.5
}

@IBDesignable
class LineProgressView: UIView {
    
    private let proressLayer = CALayer()
    @objc let progressObserve = ProgressValueObserve()
    
    var observationProgress: NSKeyValueObservation?
    
    @IBInspectable
    var progress: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var backgroundColorDI: UIColor? {
        didSet {
            backgroundColor = backgroundColorDI
        }
    }
    
    @IBInspectable var progressColorDI: UIColor? {
        didSet {
            proressLayer.backgroundColor = progressColorDI?.cgColor
        }
    }
        
    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        proressLayer.frame = progressRect
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(proressLayer)
        obserProgress()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.addSublayer(proressLayer)
        obserProgress()
    }
    
    private func obserProgress() {
        observationProgress = observe(\LineProgressView.progressObserve.progress, options: [.new]) { (view, change) in
            guard let changeProgress = change.newValue else {
                self.progress = 0.5
                return
            }
            self.progress = changeProgress
        }
    }
    
}
