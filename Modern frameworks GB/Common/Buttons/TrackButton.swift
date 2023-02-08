import Foundation
import UIKit

final class TrackButton: ButtonWithAction {
    enum ButtonState {
        case start
        case finish
    }
    
    // MARK: - Private Properties
    private var buttonState: ButtonState = .finish
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        updateAfterStateChanged()
    }
    
    func updateAfterStateChanged() {
        switch buttonState {
        case .start:
            setImage(UIImage(systemName: "location.slash.fill"), for: .normal)
            tintColor = .systemOrange
            layer.borderColor = UIColor.systemOrange.cgColor
            backgroundColor = .systemOrange.withAlphaComponent(0.15)
        case .finish:
            setImage(UIImage(systemName: "location.north.line.fill"), for: .normal)
            tintColor = .systemGreen
            layer.borderColor = UIColor.systemGreen.cgColor
            backgroundColor = .systemGreen.withAlphaComponent(0.15)
        }
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    func toggleState() {
        buttonState = buttonState == .start ? .finish : .start
        updateAfterStateChanged()
    }
    
    func getCurrentState() -> ButtonState {
        buttonState
    }
}
