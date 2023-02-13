import Foundation
import UIKit

class ButtonWithAction: UIButton {
    
    // MARK: - Private Properties
    private var action: EmptyClosure?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        addActionTarget()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    // MARK: - Public Methods
    func setButtonAction(_ action: @escaping EmptyClosure) {
        self.action = action
    }
    
    // MARK: - Private Methods
    private func addActionTarget() {
        self.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    }
    
    @objc private func onButtonTap() {
        action?()
    }
}
