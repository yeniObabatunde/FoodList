//
//  FoodDetailView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 26/02/2025.
//

import UIKit

class FoodDetailView: UIView {
  
    var onBackButtonTapped: (() -> Void)?
    var onFavoriteButtonTapped: (() -> Void)?
    var onShareButtonTapped: (() -> Void)?

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerContainerView: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemRed
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var paginationLabel: UILabel = {
        let label = UILabel()
        label.text = "1/10"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var healthyTagView: UIView = {
        let view = createTagView(text: "healthy")
        return view
    }()
    
    lazy var vegetarianTagView: UIView = {
        let view = createTagView(text: "vegetarian")
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nutritionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.1)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nutritionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Nutrition"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var caloriesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var caloriesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "flame.fill")
        imageView.tintColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addNotesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add notes", for: .normal)
        button.setImage(UIImage(systemName: "plus.square.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Fixed component (below scroll)
    lazy var removeFromCollectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove from collection", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(headerContainerView)
        headerContainerView.addSubview(imageView)
        imageView.addSubview(imageLoadingIndicator)
        addSubview(backButton)
        addSubview(favoriteButton)
        addSubview(shareButton)
        addSubview(paginationLabel)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(tagsStackView)
        tagsStackView.addArrangedSubview(healthyTagView)
        tagsStackView.addArrangedSubview(vegetarianTagView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(nutritionContainerView)
        nutritionContainerView.addSubview(nutritionTitleLabel)
        nutritionContainerView.addSubview(caloriesView)
        caloriesView.addSubview(caloriesImageView)
        caloriesView.addSubview(caloriesLabel)
        contentView.addSubview(notesLabel)
        contentView.addSubview(addNotesButton)

        addSubview(removeFromCollectionButton)
        
        setupConstraints()
        setupActions()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            imageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            
            imageLoadingIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            imageLoadingIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            favoriteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -12),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            shareButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            shareButton.widthAnchor.constraint(equalToConstant: 40),
            shareButton.heightAnchor.constraint(equalToConstant: 40),
            
            paginationLabel.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: -16),
            paginationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            paginationLabel.widthAnchor.constraint(equalToConstant: 40),
            paginationLabel.heightAnchor.constraint(equalToConstant: 24),
        ])

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: removeFromCollectionButton.topAnchor, constant: -16),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            recipeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            tagsStackView.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 12),
            tagsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tagsStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: tagsStackView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nutritionContainerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            nutritionContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nutritionContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nutritionTitleLabel.topAnchor.constraint(equalTo: nutritionContainerView.topAnchor, constant: 20),
            nutritionTitleLabel.leadingAnchor.constraint(equalTo: nutritionContainerView.leadingAnchor, constant: 16),
            nutritionTitleLabel.trailingAnchor.constraint(equalTo: nutritionContainerView.trailingAnchor, constant: -16),
            
            caloriesView.topAnchor.constraint(equalTo: nutritionTitleLabel.bottomAnchor, constant: 15),
            caloriesView.leadingAnchor.constraint(equalTo: nutritionContainerView.leadingAnchor, constant: 16),
            caloriesView.trailingAnchor.constraint(equalTo: nutritionContainerView.trailingAnchor, constant: -16),
            caloriesView.bottomAnchor.constraint(equalTo: nutritionContainerView.bottomAnchor, constant: -25),
            
            caloriesImageView.leadingAnchor.constraint(equalTo: caloriesView.leadingAnchor),
            caloriesImageView.centerYAnchor.constraint(equalTo: caloriesView.centerYAnchor),
            caloriesImageView.widthAnchor.constraint(equalToConstant: 16),
            caloriesImageView.heightAnchor.constraint(equalToConstant: 16),
            
            caloriesLabel.leadingAnchor.constraint(equalTo: caloriesImageView.trailingAnchor, constant: 8),
            caloriesLabel.centerYAnchor.constraint(equalTo: caloriesView.centerYAnchor),
            caloriesLabel.trailingAnchor.constraint(equalTo: caloriesView.trailingAnchor),
            
            notesLabel.topAnchor.constraint(equalTo: nutritionContainerView.bottomAnchor, constant: 20),
            notesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            addNotesButton.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 8),
            addNotesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addNotesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            removeFromCollectionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            removeFromCollectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            removeFromCollectionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            removeFromCollectionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    private func createTagView(text: String) -> UIView {
        let tagView = UIView()
        tagView.backgroundColor = UIColor.systemGray5
        tagView.layer.cornerRadius = 12
        tagView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        tagView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 6),
            label.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -6)
        ])
        
        return tagView
    }
    
    @objc private func backButtonTapped() {
        onBackButtonTapped?()
    }
    
    @objc private func favoriteButtonTapped() {
        onFavoriteButtonTapped?()
    }
    
    @objc private func shareButtonTapped() {
        onShareButtonTapped?()
    }
    
    func configure(with food: FoodModelDatum) {
        recipeNameLabel.text = food.name
        descriptionLabel.text = food.description
        caloriesLabel.text = "\(food.calories ?? 0) Calories"
        paginationLabel.text = "1/\(food.imageURL?.count ?? 0)"
        if let imageUrl = food.imageURL?[0] {
            loadCachedImage(from: imageUrl)
        }
    }
    
    private func loadCachedImage(from url: URL?) {
        guard let url = url else { return }
        imageLoadingIndicator.startAnimating()
        Task {
            do {
                let image = try await ImageLoadingService.shared.loadImage(from: url)
                await MainActor.run {
                    UIView.transition(with: imageView,
                                      duration: 0.3,
                                      options: .transitionCrossDissolve) { [weak self] in
                        self?.imageView.image = image
                        self?.imageLoadingIndicator.stopAnimating()
                    }
                }
            } catch {
                await MainActor.run {
                    self.imageView.image = UIImage(named: "defaultImage")
                    self.imageLoadingIndicator.stopAnimating()
                }
            }
        }
    }
}
