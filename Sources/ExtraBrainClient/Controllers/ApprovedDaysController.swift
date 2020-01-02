extension ExtraBrainClient {
    public struct ApprovedDaysController: ClientController, ClientRESTAllAction {
        let client: ExtraBrainClient

        public func all(completion: @escaping ExtraBrainClientResultCompletion<[ApprovedDay]>) {
            client.get(path: "/approved_days") {
                Responder<[ApprovedDay]>().respond($0, completion: completion)
            }
        }
    }
}

protocol ClientController {
    var client: ExtraBrainClient { get }
}

public protocol ClientRESTAllAction {
    associatedtype Resource

    func all(completion: @escaping ExtraBrainClientResultCompletion<[Resource]>)
}
