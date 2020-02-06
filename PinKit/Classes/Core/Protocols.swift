import RxSwift

public protocol IPinKit: class {
    var isPinSet: Bool { get }
    var isPinSetObservable: Observable<Bool> { get }
    func clear() throws

    var biometryEnabled: Bool { get set }

    var isLocked: Bool { get }
    func lock()
    func didEnterBackground()
    func willEnterForeground()

    var editPinModule: UIViewController { get }
    func setPinModule(delegate: ISetPinDelegate) -> UIViewController
    func unlockPinModule(delegate: IUnlockDelegate, enableBiometry: Bool, unlockMode: UnlockMode) -> UIViewController
}

public protocol ILockManager {
    var isLocked: Bool { get }
    func lock()
    func didEnterBackground()
    func willEnterForeground()
}

public protocol IUnlockDelegate: class {
    func onUnlock()
    func onCancelUnlock()
}

public protocol ILockProvider: class {
    var viewController: UIViewController? { get set }
    func lockScreenModule(delegate: IUnlockDelegate, appStart: Bool) -> UIViewController
}

protocol ILockRouter {
    func showUnlock(delegate: IUnlockDelegate, lockProvider: ILockProvider)
}

protocol IBiometricManager {
    func validate(reason: String)
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
