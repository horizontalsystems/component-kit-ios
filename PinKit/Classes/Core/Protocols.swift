import RxSwift

public protocol IPinKit: class {
    func set(delegate: IPinKitDelegate?)

    var isPinSet: Bool { get }
    var isPinSetObservable: Observable<Bool> { get }
    var biometryType: BiometryType? { get }
    var biometryTypeObservable: Observable<BiometryType> { get }
    func clear() throws

    var biometryEnabled: Bool { get set }

    var isLocked: Bool { get }
    func lock()
    func didFinishLaunching()
    func didEnterBackground()
    func willEnterForeground()

    var editPinModule: UIViewController { get }
    func setPinModule(delegate: ISetPinDelegate) -> UIViewController
    func unlockPinModule(delegate: IUnlockDelegate, biometryUnlockMode: BiometryUnlockMode, insets: UIEdgeInsets, cancellable: Bool, autoDismiss: Bool) -> UIViewController
}

public protocol ILockManager: AnyObject {
    var delegate: IPinKitDelegate? { get set }
    var isLocked: Bool { get }
    func lock()
    func didEnterBackground()
    func willEnterForeground()
}

public protocol IUnlockDelegate: class {
    func onUnlock()
    func onCancelUnlock()
}

protocol IBiometricManager {
    func validate(reason: String)
}

protocol IBiometryManager {
    var biometryType: BiometryType? { get }
    var biometryTypeObservable: Observable<BiometryType> { get }
    func refresh()
}

protocol BiometricManagerDelegate: class {
    func didValidate()
    func didFailToValidate()
}

public protocol IPinManager: class {
    var isPinSet: Bool { get }
    var biometryEnabled: Bool { get set }
    func store(pin: String) throws
    func validate(pin: String) -> Bool
    func clear() throws

    var isPinSetObservable: Observable<Bool> { get }
}

protocol ICurrentDateProvider {
    var currentDate: Date { get }
}

protocol ILockoutUntilDateFactory {
    func lockoutUntilDate(failedAttempts: Int, lockoutTimestamp: TimeInterval, uptime: TimeInterval) -> Date
}

protocol ILockoutManager {
    var unlockAttempts: Int { get }
    var currentState: LockoutState { get }
    func didFailUnlock()
    func dropFailedAttempts()
}

protocol IOneTimeTimer {
    var delegate: IPeriodicTimerDelegate? { get set }
    func schedule(date: Date)
}

protocol IPeriodicTimerDelegate: class {
    func onFire()
}

protocol IUptimeProvider {
    var uptime: TimeInterval { get }
}

public protocol IPinKitDelegate: AnyObject {
    func onLock(delegate: IUnlockDelegate)
}
