# ExtraBrainClient

## TLDR examples

### Get task

```swift
let client = ExtraBrainClient(username: "asd@example.com", password: "****")
client.tasks.find(id: 123) { result in
    switch result {
    case .failure(let error):
        print(error)
    case .success(let task):
        print(task.id)
        print(task.title)
        print(task.totalTime)
    }
}
```
