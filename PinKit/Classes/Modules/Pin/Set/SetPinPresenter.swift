class SetPinPresenter: ManagePinPresenter {

    private let router: ISetPinRouter

    init(interactor: IPinInteractor, router: ISetPinRouter) {
        self.router = router
        super.init(interactor: interactor, pages: [.enter, .confirm])
    }

    override func viewDidLoad() {
        view?.set(title: "set_pin.title")

        for page in pages {
            switch page {
            case .enter: view?.addPage(withDescription: "set_pin.info")
            case .confirm: view?.addPage(withDescription: "pin.button.confirm")
            default: ()
            }
        }

        view?.showCancel()
    }

    override func onCancel() {
        router.notifyCancelled()
        router.close()
    }

    override func didSavePin() {
        router.close()
    }

}
