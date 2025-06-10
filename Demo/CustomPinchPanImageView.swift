//
//  CustomPinchPanImageView.swift
//  Demo
//
//  Created by Mateusz Siatrak on 10/06/2025.
//

import UIKit

class CustomPinchPanImageView: UIView {
    
    private let imageView = UIImageView()
    private var initialTransform = CGAffineTransform.identity
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
        setupGestures()
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "Image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor)
        ])
    }
    
    private func setupGestures() {
        // Pinch gesture
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        imageView.addGestureRecognizer(pinchGesture)
        
        // Pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        imageView.addGestureRecognizer(panGesture)
        
        // Double tap gesture
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
        
        // Allow simultaneous gestures
        pinchGesture.delegate = self
        panGesture.delegate = self
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            initialTransform = imageView.transform
        case .changed:
            let scale = gesture.scale
            imageView.transform = initialTransform.scaledBy(x: scale, y: scale)
        case .ended, .cancelled:
            // Constrain the scale
            let currentScale = sqrt(imageView.transform.a * imageView.transform.a + imageView.transform.c * imageView.transform.c)
            let minScale: CGFloat = 1.0
            let maxScale: CGFloat = 5.0
            
            if currentScale < minScale {
                UIView.animate(withDuration: 0.3) {
                    self.imageView.transform = self.imageView.transform.scaledBy(x: minScale/currentScale, y: minScale/currentScale)
                }
            } else if currentScale > maxScale {
                UIView.animate(withDuration: 0.3) {
                    self.imageView.transform = self.imageView.transform.scaledBy(x: maxScale/currentScale, y: maxScale/currentScale)
                }
            }
        default:
            break
        }
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .began:
            initialTransform = imageView.transform
        case .changed:
            imageView.transform = initialTransform.translatedBy(x: translation.x, y: translation.y)
        case .ended, .cancelled:
            // Optional: Add boundary constraints here
            break
        default:
            break
        }
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.imageView.transform = .identity
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension CustomPinchPanImageView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}