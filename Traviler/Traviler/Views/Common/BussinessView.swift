//
//  BussinessView.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 20/12/2020.
//

import UIKit
import CoreLocation

protocol BusinessViewDelegate: AnyObject {
    func handleOptionButtonTapped(_ sender: UIButton)
}

class BusinessView: UIView {
    
    weak var delegate: BusinessViewDelegate?
    
    var swipeIndicator: UIView?
    
    // MARK:- Header
    private var titleLabel: Text?
    private var optionButton: UIButton?
    private var categoryLabel: Text?
    private var priceLabel: Text?
    private var priceDisabledLabel: Text?
    private var ratingLabel: Text?
    private var distanceLabel: Text?
    
    var business: Business? {
        didSet {
            self.setupView()
        }
    }
    
    // MARK:- Sections
    var photosSection: SectionView?
    var tipsSection: SectionView?
    
    private func setupView() {
        self.backgroundColor = Style.Colors.backgroundColor
        self.swipeIndicator = UIView()
        
        // create all views and add it to superview
        self.titleLabel = Text(self.business!.name!, size: 28, weight: .bold)
        self.categoryLabel = Text(self.business!.categories?.first?.title! ?? "Unspecified", color: Style.Colors.secondayColor)
        self.priceLabel = Text(String.repeat("$", times: UInt(self.business!.price?.count ?? 4)), color: Style.Colors.secondayColor)
        self.priceDisabledLabel = Text(String.repeat("$", times: 4 - UInt(self.business!.price?.count ?? 4)), color: Style.Colors.disabledColor)
        self.ratingLabel = Text(String(self.business!.rating!), color: Style.Colors.goldColor, weight: .black)
        
        if let latittude = self.business?.coordinates!.latitude, let longitude = self.business?.coordinates!.longitude {
            let userLatitude = UserDefaults.standard.double(forKey: "user.currentlocation.latitude")
            let userLongitude = UserDefaults.standard.double(forKey: "user.currentlocation.longitude")
            let distance = CLLocation(latitude: latittude, longitude: longitude).distance(from: CLLocation(latitude: userLatitude, longitude: userLongitude))
            self.distanceLabel = Text("\(String(format: "%.1f", distance.rounded(.up) / 1000)) km away", color: Style.Colors.secondayColor)
        } else {
            self.distanceLabel = Text("\(String(format: "%.1f", 0.rounded(.up) / 1000)) km away", color: Style.Colors.secondayColor)
        }
        
        self.optionButton = UIButton(type: .custom)
        
        self.optionButton?.addTarget(nil, action: #selector(self.handleOptionButtonTapped(_:)), for: .touchUpInside)
        
        self.addSubviews(
            self.swipeIndicator!,
            self.titleLabel!,
            self.categoryLabel!,
            self.priceLabel!,
            self.priceDisabledLabel!,
            self.ratingLabel!,
            self.distanceLabel!,
            self.optionButton!
        )
        
        // setup swipe indicator
        self.swipeIndicator?.setConstraints([
            .height(4),
            .width(UIScreen.main.bounds.width * 0.10),
            .top(padding: 14, from: nil),
            .xAxis(padding: 0, from: nil)
        ])
        
        self.swipeIndicator?.layer.cornerRadius = 2
        self.swipeIndicator?.backgroundColor = UIColor(hex: "#D1D1D1")!

        self.optionButton?.imageView?.contentMode = .scaleAspectFit
        self.optionButton?.setConstraints([
            .top(padding: 12, from: self.swipeIndicator?.bottomAnchor),
            .trailing(padding: 14, from: nil)
        ])
        
        self.titleLabel?.setConstraints([
            .top(padding: 12, from: self.swipeIndicator?.bottomAnchor),
            .leading(padding: 14, from: nil),
            .trailing(padding: 10, from: optionButton?.leadingAnchor)
        ])
        self.titleLabel?.numberOfLines = 0
        
        self.optionButton?.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        
        self.categoryLabel?.setConstraints([
            .top(padding: 0, from: self.titleLabel?.bottomAnchor),
            .leading(padding: 0, from: self.titleLabel?.leadingAnchor),
        ])
        
        self.priceLabel?.setConstraints([
            .leading(padding: 10, from: self.categoryLabel?.trailingAnchor),
            .yAxis(padding: 0, from: self.categoryLabel?.centerYAnchor)
        ])
        
        self.priceDisabledLabel?.setConstraints([
            .leading(padding: 0, from: self.priceLabel?.trailingAnchor),
            .yAxis(padding: 0, from: self.categoryLabel?.centerYAnchor)
        ])
        
        self.ratingLabel?.setConstraints([
            .leading(padding: 10, from: self.priceDisabledLabel?.trailingAnchor),
            .yAxis(padding: 0, from: self.priceDisabledLabel?.centerYAnchor)
        ])
        
        self.distanceLabel?.setConstraints([
            .leading(padding: 0, from: self.categoryLabel?.leadingAnchor),
            .top(padding: 0, from: self.priceLabel?.bottomAnchor)
        ])
        
        self.setupSections()
    }
    
    @objc private func handleOptionButtonTapped(_ sender: UIButton) {
        self.delegate?.handleOptionButtonTapped(sender)
    }
    
    private func setupSections() {
        self.setupPhotosSection()
        self.setupTipsSection()
    }
    
    private func setupPhotosSection() {
        self.photosSection = SectionView(header: "Photos", view: SuspenseView(fallback: UIActivityIndicatorView()))
        
        self.addSubviews(self.photosSection!)
        
        self.photosSection?.setConstraints([
            .top(padding: 20, from: self.distanceLabel?.bottomAnchor),
            .horizontal(padding: 0),
            .height(250)
        ])
    }
    
    private func setupTipsSection() {
        self.tipsSection = SectionView(header: "Tips", view: SuspenseView(fallback: UIActivityIndicatorView()))
        
        self.addSubviews(self.tipsSection!)
        
        self.tipsSection?.setConstraints([
            .top(padding: 20, from: self.photosSection?.bottomAnchor),
            .horizontal(padding: 0),
            .bottom(padding: 0, from: nil)
        ])
    }
    
}
