protocol ISetPinRouter {
    func notifyCancelled()
    func close()
}

public protocol ISetPinDelegate {
    func didCancelSetPin()
}
