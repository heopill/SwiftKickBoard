import UIKit
import SnapKit

class KickBoardDetailView: UIView {

    private let numberLabel = UILabel()
    private let kmLabel = UILabel()
    private let likeButton = UIButton()
    private let likeLabel = UILabel()
    private let priceBox = UIView()
    private let unlockLabel = UILabel()
    private let feeLabel = UILabel()
    private let bellButton = UIButton()
    private let rentButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 4

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        // Title
        numberLabel.font = .boldSystemFont(ofSize: 16)
        numberLabel.textColor = .gray
        numberLabel.text = "#0001"

        // Distance Info
        kmLabel.font = .systemFont(ofSize: 14)
        kmLabel.textColor = .gray
        kmLabel.text = "@@Km 주행 가능"

        // Like Button
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        likeButton.imageView?.contentMode = .scaleAspectFit
        
        likeLabel.text = "찜하기"
        likeLabel.font = .systemFont(ofSize: 12)
        likeLabel.textAlignment = .center
        likeLabel.textColor = .darkGray

        // Price Box
        priceBox.backgroundColor = UIColor.black
        priceBox.layer.cornerRadius = 12

        unlockLabel.text = "잠금해제 500원"
        unlockLabel.font = .systemFont(ofSize: 14)

        feeLabel.text = "분당요금 150원"
        feeLabel.font = .systemFont(ofSize: 14)

        // Bell Button
        bellButton.setImage(UIImage(systemName: "bell"), for: .normal)
        bellButton.tintColor = .white
        bellButton.backgroundColor = .black
        bellButton.layer.cornerRadius = 24

        // Rent Button
        rentButton.setTitle("이 기기 대여하기", for: .normal)
        rentButton.backgroundColor = .black
        rentButton.setTitleColor(.white, for: .normal)
        rentButton.layer.cornerRadius = 24
        rentButton.titleLabel?.font = .boldSystemFont(ofSize: 16)

        // Add subviews
        [numberLabel, kmLabel, likeButton, likeLabel, priceBox, bellButton, rentButton].forEach { addSubview($0) }
        [unlockLabel, feeLabel].forEach { priceBox.addSubview($0) }

        // Constraints
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        kmLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(4)
            make.leading.equalTo(numberLabel)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(36)
        }

        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(-6)
            make.centerX.equalTo(likeButton)
        }

        priceBox.snp.makeConstraints { make in
            make.top.equalTo(kmLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }

        unlockLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
        }

        feeLabel.snp.makeConstraints { make in
            make.top.equalTo(unlockLabel.snp.bottom).offset(4)
            make.leading.equalTo(unlockLabel)
        }

        bellButton.snp.makeConstraints { make in
            make.top.equalTo(priceBox.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(48)
        }

        rentButton.snp.makeConstraints { make in
            make.centerY.equalTo(bellButton)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(bellButton.snp.trailing).offset(21)
            make.height.equalTo(48)
        }
    }
}
