//
//  WelcomeViewController.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation
import UIKit

struct WelcomeViewControllerState {
    var isLoading: Bool = false {
        didSet { updater(self) }
    }
    
    var title: String {
        didSet { updater(self) }
    }
    
    var buttonTitle: String {
        didSet { updater(self) }
    }
    
    private var updater: (WelcomeViewControllerState) -> Void
    
    init(title: String, buttonTitle: String, updater: @escaping (WelcomeViewControllerState) -> Void) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.updater = updater
    }
}

struct WelcomeViewControllerActions {
    var requestButtonClick: () -> Void
}

final class WelcomeViewController: ViewController {
    
    private lazy var titleLabel: UILabel = { UILabel() }()
    private lazy var button: UIButton = { UIButton(type: .system) }()
    private lazy var indicatorView: UIActivityIndicatorView = { UIActivityIndicatorView(style: .medium) }()
    
    private let context: AstronomyContext
    private var actions: WelcomeViewControllerActions?
    private var state: WelcomeViewControllerState?
    
    init(context: AstronomyContext) {
        self.context = context
        
        super.init(nibName: nil, bundle: nil)
        
        actions = WelcomeViewControllerActions(
            requestButtonClick: { [weak self] in
                guard let self else { return }
//                let vc = AstronomyDescriptionViewController(context: context, astronomy: mockedAstronomy().first!)
//                let vc = AstronomyViewController(context: context, astronomy: mockedAstronomy())
//                self.navigationController?.pushViewController(vc, animated: true)
                self.state?.isLoading = true
                context.remote.fetchAll { result in
                    self.state?.isLoading = false
                    let vc = AstronomyViewController(context: context, astronomy: result)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        )
        state = WelcomeViewControllerState(
            title: "Astronomy Picture of the Day",
            buttonTitle: "Request",
            updater: { [weak self] state in
                guard let self else { return }
                state.isLoading ? self.indicatorView.startAnimating() : self.indicatorView.stopAnimating()
            }
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(button)
        view.addSubview(indicatorView)
        
        titleLabel.text = state?.title ?? ""
        titleLabel.font = .boldSystemFont(ofSize: 16)
        button.setTitle(state?.buttonTitle ?? "", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didButtonClicked), for: .touchUpInside)
        indicatorView.stopAnimating()
        indicatorView.hidesWhenStopped = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(center: view.bounds.center, size: titleLabel.sizeThatFits(view.bounds.size))
            .offset(y: -40)
        button.frame = CGRect(center: view.bounds.center, size: button.sizeThatFits(view.bounds.size))
        indicatorView.frame = CGRect(center: button.center, size: indicatorView.sizeThatFits(view.bounds.size))
            .offset(y: 100)
    }
    
    @objc
    private func didButtonClicked(_ sender: UIButton) {
        actions?.requestButtonClick()
    }
}

private func mockedAstronomy() -> [Astronomy] {
    return [
        Astronomy(
            title: "A Year of Extraterrestrial Fountains and Flows",
            description: "The past year was extraordinary for the discovery of extraterrestrial fountains and flows -- some offering new potential in the search for liquid water and the origin of life beyond planet Earth.. Increased evidence was uncovered that fountains spurt not only from Saturn's moon Enceladus, but from the dunes of Mars as well. Lakes were found on Saturn's moon Titan, and the residual of a flowing liquid was discovered on the walls of Martian craters. The diverse Solar System fluidity may involve forms of slushy water-ice, methane, or sublimating carbon dioxide. Pictured above, the light-colored path below the image center is hypothesized to have been created sometime in just the past few years by liquid water flowing across the surface of Mars.",
            copyright: "MGS, MSSS, JPL, NASA",
            url: "https://apod.nasa.gov/apod/image/0612/flow_mgs.jpg",
            apodSite: "D",
            date: "2006-12-31",
            mediaType: "image",
            hdurl: "https://apod.nasa.gov/apod/image/0612/flow_mgs_big.jpg"
        )
    ]
}
