import UIKit
import Foundation

protocol SelectUserViewDelegate: class {
    func selectUserView(selectUserView: SelectUserView, didTapUserButton user: User)
}

class SelectUserView: UIView {
    
    private let margin: CGFloat = 10.0
    private let marginVertical: CGFloat = 2.0
    private var participants: Participants!
    private var buttons: [UIButton] = []
    
    weak var delegate: SelectUserViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with participants: Participants) {
        self.participants = participants
        let stackView = UIStackView()
        stackView.fillEquallyHorizontal(spacing: 5.0)
        for user in participants.getUsers() {
            let button = UserButton()
            stackView.addArrangedSubview(button)
            button.decorate(with: user)
            button.addTarget(self, action: #selector(SelectUserView.didTapUserButton(button:)), for: .touchUpInside)
            buttons.append(button)
            print(button.frame)
        }
        self.addSubview(stackView)
        stackView.pinTo(superView: self, constant: 0)
    }
    
    func didTapUserButton(button: UserButton) {
        clearSelectButtons()
        button.isSelected = true
        if let user = button.user {
            delegate?.selectUserView(selectUserView: self, didTapUserButton: user)
        }
    }
    
    func clearSelectButtons() {
        for button in buttons {
            button.isSelected = false
        }
    }
}

class UserButton: UIButton {
    
    var user: User?
    
    func decorate(with user: User) {
        self.user = user
        setTitle(user.name, for: .normal)
        backgroundColor = .blue
        setTitle("✓ \(user.name)", for: .selected)
    }
    
}
