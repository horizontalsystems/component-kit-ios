import RxSwift
import LocalAuthentication

class BiometryManager: IBiometryManager {
    private let disposeBag = DisposeBag()

    private let subject = PublishSubject<BiometryType>()

    var biometryType: BiometryType? {
        didSet {
            if let biometryType = biometryType, oldValue != biometryType {
                subject.onNext(biometryType)
            }
        }
    }

    private var biometryTypeSingle: Single<BiometryType> {
        Single<BiometryType>.create { observer in
            var authError: NSError?
            let localAuthenticationContext = LAContext()

            //Some times canEvaluatePolicy responses for too long time leading to stuck in settings controller.
            //Sending this request to background thread allows to show controller without biometric setting.
            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                switch localAuthenticationContext.biometryType {
                case .faceID: observer(.success(.faceId))
                case .touchID: observer(.success(.touchId))
                default: observer(.success(.none))
                }
            } else {
                observer(.success(.none))
            }

            return Disposables.create()
        }
    }

    var biometryTypeObservable: Observable<BiometryType> {
        subject.asObservable()
    }

    func refresh() {
        biometryTypeSingle
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe(onSuccess: { [weak self] biometryType in
                    self?.biometryType = biometryType
                })
                .disposed(by: disposeBag)
    }

}
