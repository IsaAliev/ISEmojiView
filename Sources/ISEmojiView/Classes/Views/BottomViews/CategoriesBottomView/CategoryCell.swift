//
//  ISEmojiCategoryCell.swift
//  ISEmojiView
//
//  Created by Beniamin Sarkisyan on 01/08/2018.
//

import Foundation
import UIKit

private let HighlightedBackgroundViewSize = CGFloat(30)

internal class CategoryCell: UICollectionViewCell {
    
    // MARK: - Private variables
    
    private var highlightedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = EmojiViewConfig.categorySelectionIndicatorColor
        view.isHidden = true
        return view
    }()
    
    private lazy var emojiImageView: UIImageView = {
        let emojiImageView = UIImageView()
        emojiImageView.contentMode = .center
        emojiImageView.tintColor = EmojiViewConfig.categoryNoSelectionTintColor
        return emojiImageView
    }()
    
    // MARK: - Override functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override var isHighlighted: Bool {
        didSet {
            highlightedBackgroundView.isHidden = !isHighlighted
            emojiImageView.tintColor = isHighlighted ? EmojiViewConfig.categorySelectionTintColor : EmojiViewConfig.categoryNoSelectionTintColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            highlightedBackgroundView.isHidden = !isSelected
            emojiImageView.tintColor = isSelected ? EmojiViewConfig.categorySelectionTintColor : EmojiViewConfig.categoryNoSelectionTintColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = min(HighlightedBackgroundViewSize, contentView.bounds.width)
        highlightedBackgroundView.frame.size.width = size
        highlightedBackgroundView.frame.size.height = size
        highlightedBackgroundView.frame.origin.x = contentView.center.x - size/2
        highlightedBackgroundView.frame.origin.y = contentView.center.y - size/2
        
        highlightedBackgroundView.layer.cornerRadius = highlightedBackgroundView.frame.width/2
        
        emojiImageView.frame = contentView.bounds
    }
    
    // MARK: - Internal functions
    
    internal func setEmojiCategory(_ category: Category) {
        let image: UIImage?
        
        image = UIImage(named: category.iconName, in: Bundle.podBundle, compatibleWith: nil)
        emojiImageView.image = image?.withRenderingMode(.alwaysTemplate)
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        contentView.addSubview(highlightedBackgroundView)
        contentView.addSubview(emojiImageView)
    }
    
}
