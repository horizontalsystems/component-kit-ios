import StorageKit

class LockoutManager {
    private let unlockAttemptsKey = "unlock_attempts_keychain_key"
    private let lockTimestampKey = "lock_timestamp_keychain_key"

    private var secureStorage: ISecureStorage
    private var uptimeProvider: IUptimeProvider
    private var lockoutTimeFrameFactory: ILockoutUntilDateFactory

    private let lockoutThreshold = 5

    init(secureStorage: ISecureStorage, uptimeProvider: IUptimeProvider, lockoutTimeFrameFactory: ILockoutUntilDateFactory) {
        self.secureStorage = secureStorage
        self.uptimeProvider = uptimeProvider
        self.lockoutTimeFrameFactory = lockoutTimeFrameFactory
    }

}

extension LockoutManager: ILockoutManager {

    var unlockAttempts: Int {
        secureStorage.value(for: unlockAttemptsKey) ?? 0
    }

    var currentState: LockoutState {
        let uptime = uptimeProvider.uptime
        let lockoutTimestamp = secureStorage.value(for: lockTimestampKey) ?? uptime

        let unlockAttempts: Int = secureStorage.value(for: unlockAttemptsKey) ?? 0
        let unlockDate = lockoutTimeFrameFactory.lockoutUntilDate(failedAttempts: unlockAttempts, lockoutTimestamp: lockoutTimestamp, uptime: uptime)

        if unlockAttempts >= lockoutThreshold, Date().compare(unlockDate) == .orderedAscending {
            return .locked(till: unlockDate)
        } else {
            let failedAttempts: Int? = secureStorage.value(for: unlockAttemptsKey)
            let attemptsLeft = failedAttempts.map { failedAttempts -> Int in
                let attemptsLeft = lockoutThreshold - failedAttempts
                return attemptsLeft < 1 ? 1 : attemptsLeft
            }
            return .unlocked(attemptsLeft: attemptsLeft)
        }
    }

    func didFailUnlock() {
        let newValue = (secureStorage.value(for: unlockAttemptsKey) ?? 0) + 1
        try? secureStorage.set(value: newValue, for: unlockAttemptsKey)

        if newValue >= lockoutThreshold {
            try? secureStorage.set(value: uptimeProvider.uptime, for: lockTimestampKey)
        }
    }

    func dropFailedAttempts() {
        try? secureStorage.removeValue(for: unlockAttemptsKey)
    }

}
