//
//  FooterView.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 12.09.2022.
//

import UIKit

class FooterView: UIView {
    
    // MARK: - Private properties
    
    private var loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func showLoader() {
        loader.startAnimating()
        loadingLabel.text = "LOADING"
    }
    
    func hideLoader() {
        loader.stopAnimating()
        loadingLabel.text = ""
    }
    
    // MARK: - Private methods
    
    private func addSubviews() {
        addSubview(loadingLabel)
        addSubview(loader)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            loader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8)
        ])
        
    }
    
}
