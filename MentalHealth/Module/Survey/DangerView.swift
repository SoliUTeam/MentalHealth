//
//  DangerView.swift
//  MentalHealth
//
//  Created by Yoon on 6/25/24.
//

import UIKit

class DangerView: UIView {

    private let lowLabel: UILabel = {
        let label = UILabel()
        label.text = "Low"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let moderateLabel: UILabel = {
        let label = UILabel()
        label.text = "Moderate"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let highLabel: UILabel = {
        let label = UILabel()
        label.text = "High"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(lowLabel)
        addSubview(moderateLabel)
        addSubview(highLabel)

        // Add constraints
        NSLayoutConstraint.activate([
            lowLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            lowLabel.topAnchor.constraint(equalTo: topAnchor),
            lowLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            moderateLabel.leadingAnchor.constraint(equalTo: lowLabel.trailingAnchor),
            moderateLabel.topAnchor.constraint(equalTo: topAnchor),
            moderateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            moderateLabel.widthAnchor.constraint(equalTo: lowLabel.widthAnchor),

            highLabel.leadingAnchor.constraint(equalTo: moderateLabel.trailingAnchor),
            highLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            highLabel.topAnchor.constraint(equalTo: topAnchor),
            highLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            highLabel.widthAnchor.constraint(equalTo: lowLabel.widthAnchor),
        ])

        // Set corner radius
        layer.cornerRadius = 20
        layer.masksToBounds = true

        lowLabel.layer.cornerRadius = 20
        lowLabel.layer.masksToBounds = true
        moderateLabel.layer.masksToBounds = true
        highLabel.layer.cornerRadius = 20
        highLabel.layer.masksToBounds = true
    }
}
