extension ExtraBrainClient {
    @available(*, deprecated, renamed: "TasksController")
    public typealias Tasks = TasksController

    public struct TasksController {
        let client: ExtraBrainClient

        public func find(id taskId: Int, completion: @escaping ExtraBrainClientResultCompletion<Task>) {
            client.get(path: "/tasks/\(String(describing: taskId))") {
                Responder<Task>().respond($0, completion: completion)
            }
        }
    }
}
