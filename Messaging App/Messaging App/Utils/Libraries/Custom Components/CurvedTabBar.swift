//
//  CurvedTabBar.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 11.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

protocol MiddleButtonDelegate {
    func middleButtonTapped()
}

class CurvedTabBar: UITabBar {
    
    // MARK: - Properties
    
    private var shapeLayer: CALayer?
    
    var middleButtonDelegate: MiddleButtonDelegate?
    
    lazy var keyWindow: UIWindow? = {
         if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }()
    
    // MARK: - Lifecycle
    
    override func draw(_ rect: CGRect) {
        addShape()
        
        addMiddleButton()
        updateItemTitlePosition()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height += 15
        return sizeThatFits
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    
    // MARK: - Initialization
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        // The below 4 lines are for shadow above the bar.
        // you can skip them if you do not want a shadow
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    
    func createPath() -> CGPath {
    
        let height: CGFloat = (self.frame.height - keyWindow!.safeAreaInsets.bottom) * 0.8
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        // start top left
        path.move(to: CGPoint(x: 0, y: 0))
        
        // the beginning of the trough
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0))

        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: centerWidth + 0, y: 0),
                      controlPoint2: CGPoint(x: centerWidth - 55, y: height - 5))

        path.addCurve(to: CGPoint(x: centerWidth + height * 2, y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 55, y: height - 5),
                      controlPoint2: CGPoint(x: centerWidth - 0, y: 0))

        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }
    
    func addMiddleButton() {
        let middleBtnSize = (self.frame.height - keyWindow!.safeAreaInsets.bottom) * 0.9
        let middleBtn = UIButton(frame: CGRect(x: (self.bounds.width - middleBtnSize) / 2, y: -10, width: middleBtnSize, height: middleBtnSize))
        middleBtn.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
        middleBtn.setImage(#imageLiteral(resourceName: "tabBarSendLetterIcon.png"), for: .normal)
        middleBtn.contentMode = .scaleAspectFill
        addSubview(middleBtn)
    }
    
    @objc func middleButtonTapped() {
        middleButtonDelegate?.middleButtonTapped()
    }
    
    func updateItemTitlePosition() {
        guard let items = items else { return }
        
        items.forEach { (item) in
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -12.0)
        }
    }
}
