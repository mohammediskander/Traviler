//
//  HomeRegularCell.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 20/12/2020.
//

import UIKit
import CoreLocation


class HomeRegularCell: UICollectionViewCell {
    var business: Business? = nil {
        didSet {
            if business != nil, business?.id != oldValue?.id {
                self.setupVenue()
            } else {
                self.resetView()
            }
        }
    }
    
    var suspenseView: SuspenseView? = nil
    private var suspenseChildView: UIView? = nil
    
    var imageSuspenseView: SuspenseView? = nil
    var imageSuspenseChildView: UIImageView? = nil
    
    var gradientView: UIView? = nil
    
    var businessName: Text? = nil
    var distance: Text? = nil
    var rating: Text? = nil
    var starImage: UIImageView? = nil
    
    // weather
    var weather: Text? = nil
    var weatherImageView: UIImageView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        if self.suspenseView != nil {
            if self.suspenseView?.superview != nil {
                self.suspenseView?.removeFromSuperview()
            }
            self.suspenseView = nil
        }
        
        self.suspenseView = SuspenseView(fallback: UIActivityIndicatorView())
        self.contentView.addSubview(suspenseView!)
        
        suspenseView?.setConstraints([
            .horizontal(padding: 0),
            .vertical(padding: 0)
        ])
        
        self.contentView.backgroundColor = Style.Colors.secondaryBackgroundColor
        self.contentView.layer.cornerRadius = 12.5
        self.contentView.layer.masksToBounds = true
    }
    
    func update(displaying image: UIImage?) {
        self.imageSuspenseChildView?.image = nil
        
        if let image = image {
            self.imageSuspenseChildView = UIImageView()
            self.imageSuspenseChildView?.contentMode = .scaleAspectFill
            self.imageSuspenseChildView?.image = image
            self.imageSuspenseView?.childView = self.imageSuspenseChildView
        } else {
            self.imageSuspenseView?.childView = nil
        }
    }
    
    func update(displaying weather: Current) {
        self.weather?.text = "\(weather.condition!.text!), \(weather.tempC!)°C"
        
        let weatherImage: UIImage?
        
        guard let weatherIconString = weather.condition?.icon, let weatherImageURL = URL(string: weatherIconString) else { return }
        
        let iconName = weatherImageURL.lastPathComponent.components(separatedBy: ".")[0]
        if weather.isDay == 1 {
            weatherImage = UIImage(named: "day-\(iconName)")
        } else {
            weatherImage = UIImage(named: "night-\(iconName)")
        }
        
        self.weatherImageView?.image = weatherImage
    }
    
    func resetView() {
        self.businessName?.removeFromSuperview()
        self.distance?.removeFromSuperview()
        self.gradientView?.removeFromSuperview()
        self.rating?.removeFromSuperview()
        self.weather?.removeFromSuperview()
        self.weatherImageView?.removeFromSuperview()
        
        self.imageSuspenseView?.removeFromSuperview()
        self.imageSuspenseView = nil
        
        self.imageSuspenseChildView?.removeFromSuperview()
        self.imageSuspenseChildView = nil
        
        self.weather = nil
        self.weatherImageView = nil
        self.rating = nil
        self.gradientView = nil
        self.businessName = nil
        self.distance = nil
        self.suspenseView?.childView = nil
        self.suspenseChildView = nil
    }
    
    func setupVenue() {
        
        if self.suspenseChildView != nil {
            if self.suspenseChildView?.superview != nil {
                self.suspenseChildView?.removeFromSuperview()
            }
            self.suspenseChildView = nil
        }
        
        self.suspenseChildView = UIView()
        
        if self.businessName != nil {
            self.resetView()
        }
        
        self.businessName = Text(self.business!.name!,color: .white,  size: 15, weight: .bold)
        self.businessName?.textAlignment = .left
        self.businessName?.numberOfLines = 0
        
        self.weather = Text("", color: Style.Colors.captionColor, size: 12)
        self.weatherImageView = UIImageView()
        
        if let latittude = self.business!.coordinates!.latitude, let longitude = self.business!.coordinates!.longitude {
            let userLatitude = UserDefaults.standard.double(forKey: "user.currentlocation.latitude")
            let userLongitude = UserDefaults.standard.double(forKey: "user.currentlocation.longitude")
            let distance = CLLocation(latitude: latittude, longitude: longitude).distance(from: CLLocation(latitude: userLatitude, longitude: userLongitude))
            self.distance = Text("\(String(format: "%.1f", distance.rounded(.up) / 1000)) km away", color: Style.Colors.captionColor, size: 12)
        } else {
            self.distance = Text("\(String(format: "%.1f", 0.rounded(.up) / 1000)) km away", color: Style.Colors.captionColor, size: 12)
        }
        
        self.rating = Text(String(business!.rating!), color: Style.Colors.goldColor, size: 12, weight: .bold)
        self.businessName?.removeFromSuperview()
        
        self.imageSuspenseView = SuspenseView(fallback: UIActivityIndicatorView())
        self.gradientView = UIView()
        
        self.suspenseChildView?.addSubviews(self.imageSuspenseView!, self.gradientView!, self.weather!, self.weatherImageView!, self.distance!, self.rating!, self.businessName!)
        self.suspenseView?.childView = suspenseChildView
        
        self.imageSuspenseView?.setConstraints([
            .horizontal(padding: 0),
            .vertical(padding: 0)
        ])
        
        self.gradientView?.setConstraints([
            .horizontal(padding: 0),
            .vertical(padding: 0)
        ])
        
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [UIColor.clear.cgColor, UIColor(hex: "#4A5E8B")!.cgColor]
        gradiantLayer.frame = self.bounds
        
        self.gradientView?.layer.addSublayer(gradiantLayer)
        
        self.weather?.setConstraints([
            .bottom(padding: 10, from: nil),
            .leading(padding: 10, from: nil),
            .trailing(padding: 10, from: weatherImageView?.leadingAnchor)
        ])
        
        self.weatherImageView?.setConstraints([
            .trailing(padding: 10, from: nil),
            .yAxis(padding: 0, from: weather?.centerYAnchor),
            .height(24),
            .width(24)
        ])
        self.weatherImageView?.contentMode = .scaleAspectFit
        
        self.distance?.setConstraints([
            .bottom(padding: 5, from: weather?.topAnchor),
            .leading(padding: 10, from: nil),
            .trailing(padding: 0, from: self.rating?.leadingAnchor)
        ])
        self.distance?.textAlignment = .left
        
        self.businessName?.setConstraints([
            .bottom(padding: 5, from: self.distance?.topAnchor),
            .leading(padding: 10, from: nil),
            .trailing(padding: 10, from: nil)
        ])
        
        self.rating?.setConstraints([
            .yAxis(padding: 0, from: self.distance?.centerYAnchor),
            .trailing(padding: 10, from: nil)
        ])
        self.rating?.textAlignment = .right
        
        self.update(displaying: nil)
        
        if self.business?.weather != nil {
            self.update(displaying: self.business!.weather!)
        }
    }
}
