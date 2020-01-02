import APIClient
import Foundation

public typealias ExtraBrainClientResult<Model> = Result<Model, Swift.Error>
public typealias ExtraBrainClientResultCompletion<Model> = (ExtraBrainClientResult<Model>) -> Void

public class ExtraBrainClient {
    private let username: String
    private let password: String
    private let apiClient: APIClient

    public lazy var tasks: TasksController = { TasksController(client: self) }()
    public lazy var customers: CustomersController = { CustomersController(client: self) }()
    public lazy var timeEntries: TimeEntriesController = { TimeEntriesController(client: self) }()

    public init(username: String,
                password: String,
                endpoint: String = "https://extrabrain.se",
                session: URLSession = .shared) {
        self.username = username
        self.password = password
        apiClient = APIClient(baseUrl: URL(string: endpoint)!, session: session)
    }

    func buildRequest(method: HTTPMethod, path: String) -> APIRequest {
        let auth = "\(username):\(password)".data(using: .utf8)!.base64EncodedString()

        let request = APIRequest(method: method, path: path)
        request.headers = [
            HTTPHeader(field: "Content-Type", value: "application/json;charset=UTF-8"),
            HTTPHeader(field: "Accept", value: "application/json"),
            HTTPHeader(field: "Authorization", value: "Basic \(auth)"),
        ]

        return request
    }

    func get(path: String,
             query queryItems: [URLQueryItem]? = nil,
             completion: @escaping APIClient.APIClientCompletion) {
        let request = buildRequest(method: .get, path: path)
        request.queryItems = queryItems

        apiClient.perform(request, completion)
    }

    func post(path: String, data: Data? = nil, completion: @escaping APIClient.APIClientCompletion) {
        let request = buildRequest(method: .post, path: path)
        request.body = data

        apiClient.perform(request, completion)
    }

    class Responder<T: Decodable> {
        func respond(_ result: APIResult<Data?>, completion: @escaping ExtraBrainClientResultCompletion<T>) {
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(response):
                do {
                    let task = try response.decode(to: T.self, keyDecodingStrategy: .convertFromSnakeCase).body
                    completion(.success(task))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
