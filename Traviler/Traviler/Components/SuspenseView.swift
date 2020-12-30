//
//  SuspenseView.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import UIKit

class SuspenseView: UIView {
    var fallback: UIActivityIndicatorView?
    weak var childView: UIView? = nil {
        didSet {
            if childView != nil, childView != oldValue {
                self.done()
            } else {
                self.setupFallback()
            }
        }
    }
    
    convenience init(fallback: UIActivityIndicatorView = UIActivityIndicatorView()) {
        self.init()
        self.fallback = fallback
        setupFallback()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupFallback(){
        guard let fallback = fallback else { return }
        
        if fallback.superview != nil {
            fallback.removeFromSuperview()
        }
        
        self.addSubview(fallback)
        fallback.setConstraints([
            .horizontal(padding: 0),
            .vertical(padding: 0)
        ])
        fallback.startAnimating()
    }
    
    public func done() {
        guard let fallback = fallback else { return }
        
        fallback.stopAnimating()
        fallback.removeFromSuperview()
        
        self.setupView()
    }
    
    private func setupView() {
        guard let childView = self.childView else { return }
        
        if childView.superview != nil {
            childView.removeFromSuperview()
        }
        self.addSubview(childView)
        
        childView.setConstraints([
            .horizontal(padding: 0),
            .vertical(padding: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
