extension ExtraBrainClient {
    @available(*, deprecated, renamed: "CustomersController")
    public typealias Customers = CustomersController

    public struct CustomersController {
        let client: ExtraBrainClient

        public func all(completion: @escaping ExtraBrainClientResultCompletion<[Customer]>) {
            client.get(path: "/customers") {
                Responder<[Customer]>().respond($0, completion: completion)
            }
        }
    }
}
