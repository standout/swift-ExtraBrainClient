# ExtraBrainClient

## Swift Package manager

Add it to your swift package using

```swift
.package(url: "https://github.com/standout/swift-ExtraBrainClient.git", from: "1.0.0"),
```

## TLDR examples

### Get task

```swift
let client = ExtraBrainClient(username: "asd@example.com", password: "****")
client.tasks.find(id: 123) { result in
    switch result {
    case .failure(let error):
        print(error.localizedDescription)
    case .success(let task):
        print(task.id)
        print(task.title)
        print(task.totalTime)
    }
}
```

## Documentation

### Create a client with your username and password

```swift
let client = ExtraBrainClient(username: "asd@example.com", password: "****")
```

### Tasks

#### Find task

```swift
client.tasks.find(id: 123) { result in
    // ...
}
```
