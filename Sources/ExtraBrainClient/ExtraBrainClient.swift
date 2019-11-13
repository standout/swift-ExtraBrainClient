import Foundation
import APIClient

public typealias ExtraBrainClientResult<Model> = Result<Model, Swift.Error>
public typealias ExtraBrainClientResultCompletion<Model> = (ExtraBrainClientResult<Model>) -> Void

public class ExtraBrainClient {
    private let username: String
    private let password: String
    private let apiClient: APIClient
    
    lazy public var tasks: TasksController = { TasksController(client: self) }()
    lazy public var customers: CustomersController = { CustomersController(client: self) }()
    lazy public var timeEntries: TimeEntriesController = { TimeEntriesController(client: self) }()

    public init(username: String,
                password: String,
                endpoint: String = "https://extrabrain.se") {
        self.username = username
        self.password = password
        self.apiClient = APIClient(baseUrl: URL(string: endpoint)!)
    }
    
    
    func buildRequest(method: HTTPMethod, path: String) -> APIRequest {
        let auth = "\(username):\(password)".data(using: .utf8)!.base64EncodedString()
        
        let request = APIRequest(method: method, path: path)
        request.headers = [
            HTTPHeader(field: "Content-Type", value: "application/json;charset=UTF-8"),
            HTTPHeader(field: "Accept", value: "application/json"),
            HTTPHeader(field: "Authorization", value: "Basic \(auth)")
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
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                do {
                    let task = try response.decode(to: T.self, keyDecodingStrategy: .convertFromSnakeCase).body
                    completion(.success(task))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
}
