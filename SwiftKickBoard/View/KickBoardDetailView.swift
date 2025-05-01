import UIKit
import SnapKit

class KickBoardDetailView: UIView {

    enum KickBoardStatus {
        case available
        case rented
    }

    private let state = HistoryManager()

    private let idLabel = UILabel()
    private let kmLabel = UILabel()
    private let likeButton = UIButton()
    private let likeLabel = UILabel()
    private let priceBox = UIView()
    private let unlockLabel = UILabel()
    private let feeLabel = UILabel()
    private let bellButton = UIButton()
    private let rentButton = UIButton()

    private let statusLabel = UILabel()
    private let returnButton = UIButton()

    private var rentalStartTime: Date?
    private var rentalTimer: Timer?

    var actionButtonTapped: (() -> Void)?

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
        idLabel.font = Nanum.bold(16) ?? .boldSystemFont(ofSize: 16)
        idLabel.textColor = .gray
        idLabel.text = "#1"

        kmLabel.font = Nanum.light(14) ?? .systemFont(ofSize: 14)
        kmLabel.textColor = .gray
        kmLabel.text = "100Km 주행 가능"

        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        likeButton.imageView?.contentMode = .scaleAspectFit

        likeLabel.text = "찜하기"
        likeLabel.font = Nanum.light(12) ?? .systemFont(ofSize: 12)
        likeLabel.textColor = .darkGray
        likeLabel.textAlignment = .center

        priceBox.backgroundColor = UIColor.systemGray6
        priceBox.layer.cornerRadius = 12

        unlockLabel.text = "잠금해제 500원"
        unlockLabel.font = Nanum.light(14) ?? .systemFont(ofSize: 14)

        feeLabel.text = "분당요금 150원"
        feeLabel.font = Nanum.light(14) ?? .systemFont(ofSize: 14)

        bellButton.setImage(UIImage(systemName: "bell"), for: .normal)
        bellButton.tintColor = .white
        bellButton.backgroundColor = .black
        bellButton.layer.cornerRadius = 24

        rentButton.setTitle("이 기기 대여하기", for: .normal)
        rentButton.backgroundColor = .black
        rentButton.setTitleColor(UIColor.main, for: .normal)
        rentButton.titleLabel?.font = Nanum.bold(16) ?? .boldSystemFont(ofSize: 16)
        rentButton.layer.cornerRadius = 24
        rentButton.addTarget(self, action: #selector(didTapRentButton), for: .touchUpInside)

        statusLabel.font = Nanum.bold(40) ?? .boldSystemFont(ofSize: 40)
        statusLabel.textAlignment = .center
        statusLabel.isHidden = true

        returnButton.setTitle("기기 반납하기", for: .normal)
        returnButton.backgroundColor = .black
        returnButton.layer.cornerRadius = 24
        returnButton.setTitleColor(UIColor.main, for: .normal)
        returnButton.titleLabel?.font = Nanum.bold(16) ?? .boldSystemFont(ofSize: 16)
        returnButton.isHidden = true
        returnButton.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)

        [idLabel, kmLabel, likeButton, likeLabel, priceBox, bellButton, rentButton, statusLabel, returnButton].forEach { addSubview($0) }
        [unlockLabel, feeLabel].forEach { priceBox.addSubview($0) }

        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        kmLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(4)
            $0.leading.equalTo(idLabel)
        }

        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(36)
        }

        likeLabel.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.bottom).offset(-6)
            $0.centerX.equalTo(likeButton)
        }

        priceBox.snp.makeConstraints {
            $0.top.equalTo(kmLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        unlockLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(12)
        }

        feeLabel.snp.makeConstraints {
            $0.top.equalTo(unlockLabel.snp.bottom).offset(4)
            $0.leading.equalTo(unlockLabel)
        }

        bellButton.snp.makeConstraints {
            $0.top.equalTo(priceBox.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(48)
        }

        rentButton.snp.makeConstraints {
            $0.centerY.equalTo(bellButton)
            $0.leading.equalTo(bellButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(48)
        }

        statusLabel.snp.makeConstraints {
            $0.top.equalTo(kmLabel.snp.bottom).offset(40)
            $0.trailing.equalTo(returnButton.snp.trailing)
        }

        returnButton.snp.makeConstraints {
            $0.top.equalTo(statusLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }

    @objc private func didTapRentButton() {
        actionButtonTapped?()
    }

    @objc private func didTapReturnButton() {
        guard let start = rentalStartTime else { return }

        let interval = Int(Date().timeIntervalSince(start))
        let minutes = interval / 60
        let seconds = interval % 60
        let formattedTime = "\(minutes)분 \(seconds)초"

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let today = formatter.string(from: Date())

        let alert = UIAlertController(
            title: "반납하시겠습니까?",
            message: "이용시간 : \(formattedTime)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            HistoryManager().updateHistory(date: today, runTime: formattedTime)
            self.updateStatus(.available)
        }))

        if let viewController = findViewController() {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let r = responder {
            if let vc = r as? UIViewController {
                return vc
            }
            responder = r.next
        }
        return nil
    }

    func updateStatus(_ status: KickBoardStatus) {
        switch status {
        case .available:
            kmLabel.text = "100Km 주행 가능"
            [likeButton, likeLabel, priceBox, bellButton, rentButton].forEach { $0.isHidden = false }
            [statusLabel, returnButton].forEach { $0.isHidden = true }
            rentalTimer?.invalidate()
            rentalTimer = nil
            rentalStartTime = nil
            state.updateState(upState: false)

        case .rented:
            kmLabel.text = "100Km 주행 가능"
            [likeButton, likeLabel, priceBox, bellButton, rentButton].forEach { $0.isHidden = true }
            [statusLabel, returnButton].forEach { $0.isHidden = false }
            rentalStartTime = Date()
            updateRentalTime()
            startRentalTimer()
            state.updateState(upState: true)
        }

        print("현재 대여상태: \(state.fetchState())")
    }

    private func startRentalTimer() {
        rentalTimer?.invalidate()
        rentalTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateRentalTime()
        }
    }

    private func updateRentalTime() {
        guard let start = rentalStartTime else { return }

        let interval = Int(Date().timeIntervalSince(start))
        let minutes = interval / 60
        let seconds = interval % 60

        let timeText = "\(minutes)분 \(seconds)초"
        let fullText = "\(timeText) 이용 중"

        let attributed = NSMutableAttributedString(string: fullText)
        let timeRange = (fullText as NSString).range(of: timeText)
        let usageRange = (fullText as NSString).range(of: "이용 중")

        attributed.addAttributes([
            .foregroundColor: UIColor.main,
            .font: Nanum.bold(40) ?? .boldSystemFont(ofSize: 40)
        ], range: timeRange)

        attributed.addAttributes([
            .foregroundColor: UIColor.black,
            .font: Nanum.bold(40) ?? .boldSystemFont(ofSize: 40)
        ], range: usageRange)

        statusLabel.attributedText = attributed
    }

    func configure(with model: KickBoardModel) {
        let formattedID = String(format: "#%d", model.id)
        idLabel.text = formattedID
        kmLabel.text = "100Km 주행 가능"
    }
}
