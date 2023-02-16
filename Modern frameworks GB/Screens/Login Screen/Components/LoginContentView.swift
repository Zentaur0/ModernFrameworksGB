import UIKit
import SnapKit

final class LoginContentView: UIScrollView {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private let textFieldsContainer = UIStackView()
    private let buttonsContainer = UIStackView()
    private let loginTextField = TextField()
    private let passwordTextField = TextField()
    private let enterButton = ButtonWithAction()
    private let registerButton = ButtonWithAction()
    
    private var loginModel: LoginContentView.Model {
        LoginContentView.Model(
            login: loginTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    // MARK: - Public Methods
    func setEnterButtonAction(_ action: @escaping (LoginContentView.Model) -> Void) {
        enterButton.setButtonAction {
            action(self.loginModel)
        }
    }
    
    func setRegisterButtonAction(_ action: @escaping (LoginContentView.Model) -> Void) {
        registerButton.setButtonAction {
            action(self.loginModel)
        }
    }
}

// MARK: - Private Methods
private extension LoginContentView {
    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupTitleLabel()
        setupTextFieldsContainer()
        setupButonsContainer()
        setupLoginTextField()
        setupPasswordTextField()
        setupEnterButton()
        setupRegisterButton()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        textFieldsContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        buttonsContainer.snp.makeConstraints {
            $0.top.equalTo(textFieldsContainer.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        textFieldsContainer.arrangedSubviews.forEach { subview in
            subview.snp.makeConstraints {
                $0.height.equalTo(40)
            }
        }
        
        buttonsContainer.arrangedSubviews.forEach { subview in
            subview.snp.makeConstraints {
                $0.height.equalTo(40)
            }
        }
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(textFieldsContainer)
        addSubview(buttonsContainer)
        
        textFieldsContainer.addArrangedSubview(loginTextField)
        textFieldsContainer.addArrangedSubview(passwordTextField)
        
        buttonsContainer.addArrangedSubview(enterButton)
        buttonsContainer.addArrangedSubview(registerButton)
    }
    
    func setupTitleLabel() {
        titleLabel.text = "Login"
        titleLabel.textAlignment = .center
    }
    
    func setupTextFieldsContainer() {
        textFieldsContainer.axis = .vertical
        textFieldsContainer.distribution = .fill
        textFieldsContainer.spacing = 10
    }
    
    func setupButonsContainer() {
        buttonsContainer.axis = .vertical
        buttonsContainer.distribution = .fill
        buttonsContainer.spacing = 10
    }
    
    func setupLoginTextField() {
        loginTextField.placeholder = "Login"
    }
    
    func setupPasswordTextField() {
        passwordTextField.placeholder = "Password"
    }
    
    func setupEnterButton() {
        enterButton.setTitle("Enter", for: .normal)
        enterButton.backgroundColor = .systemRed
    }
    
    func setupRegisterButton() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemPurple
    }
}
