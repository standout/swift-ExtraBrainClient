import Foundation
import APIClient

public typealias ExtraBrainClientResult<Model> = Result<Model, Swift.Error>
public typealias ExtraBrainClientResultCompletion<Model> = (ExtraBrainClientResult<Model>) -> Void

public class ExtraBrainClient {
    private let username: String
    private let password: String
    private let apiClient: APIClient
    
    lazy public var tasks: Tasks = { Tasks(client: self) }()

    public init(username: String, password: String) {
        self.username = username
        self.password = password
        self.apiClient = APIClient(baseUrl: URL(string: "https://extrabrain.se")!)
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
    
    func get(path: String, completion: @escaping APIClient.APIClientCompletion) {
        apiClient.perform(buildRequest(method: .get, path: path), completion)
    }
    
    public struct Tasks {
        let client: ExtraBrainClient
        
        public func find(id taskId: Int, completion: @escaping ExtraBrainClientResultCompletion<Task>) {
            client.get(path: "/tasks/\(String(describing: taskId))") { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let response):
                    do {
                        let task = try response.decode(to: Task.self, keyDecodingStrategy: .convertFromSnakeCase).body
                        completion(.success(task))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
