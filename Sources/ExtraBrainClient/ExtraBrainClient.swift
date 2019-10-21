import Foundation
import APIClient

public typealias ExtraBrainClientResult<Model> = Result<Model, Swift.Error>
public typealias ExtraBrainClientResultCompletion<Model> = (ExtraBrainClientResult<Model>) -> Void

public class ExtraBrainClient {
    private let username: String
    private let password: String
    private let apiClient: APIClient
    
    lazy public var tasks: Tasks = { Tasks(client: self) }()
    lazy public var customers: Customers = { Customers(client: self) }()
    lazy public var timeEntries: TimeEntries = { TimeEntries(client: self) }()

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
    
    func post(path: String, data: Data? = nil, completion: @escaping APIClient.APIClientCompletion) {
        let request = buildRequest(method: .post, path: path)
        request.body = data

        apiClient.perform(request, completion)
    }
    
    public struct Tasks {
        let client: ExtraBrainClient
        
        public func find(id taskId: Int, completion: @escaping ExtraBrainClientResultCompletion<Task>) {
            client.get(path: "/tasks/\(String(describing: taskId))") {
                Responder<Task>().respond($0, completion: completion)
            }
        }
    }
    
    public struct Customers {
        let client: ExtraBrainClient
        
        public func all(completion: @escaping ExtraBrainClientResultCompletion<[Customer]>) {
            client.get(path: "/customers") {
                Responder<[Customer]>().respond($0, completion: completion)
            }
        }
    }
    
    public struct TimeEntries {
        let client: ExtraBrainClient
        
        struct TimeEntryRequestWrapper: Encodable {
            let timeEntry: TimeEntry
        }
        
        public func create(_ timeEntry: TimeEntry, completion: @escaping ExtraBrainClientResultCompletion<TimeEntry>) {
            let coder = JSONEncoder()
            coder.keyEncodingStrategy = .convertToSnakeCase
            
            let requestWrapper = TimeEntryRequestWrapper(timeEntry: timeEntry)
            
            let data = try! coder.encode(requestWrapper)

            client.post(path: "/time_entries", data: data) {
                Responder<TimeEntry>().respond($0, completion: completion)
            }
        }
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
