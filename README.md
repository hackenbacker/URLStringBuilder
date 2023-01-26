# ⚙️ URLStringBuilder
[![Swift](https://img.shields.io/badge/Swift-5.7-darkorange?style=flat-square)](https://img.shields.io/badge/Swift-5.7-darkorange?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-darkorange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-darkorange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2015.0%20or%20lator-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS%2015.0%20or%20lator-yellowgreen?style=flat-square)
[![CI](https://github.com/hackenbacker/URLStringBuilder/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/hackenbacker/URLStringBuilder/actions/workflows/main.yml)

Utility to simplify making a URL String with parameters.

---

## Usage

URL string from simple key/value.

```swift
import URLStringBuilder

let someURL: "https://github.com/hackenbacker"

let urlString = URLStringBuilder(baseURL: someURL)
   .append(key: "key1", value: "hello")
   .append(key: "key2", value: 5)
   .build()
// https://github.com/hackenbacker?key1=hello&key2=5
```

URL string with url encoding.

```swift
import URLStringBuilder

let someURL: "https://github.com/hackenbacker"

let urlString = URLQueryBuilder(baseURL: someURL)
   .append(key: "text". value: "This is a pen.", with: .urlEncoding)
   .build()
// https://github.com/hackenbacker?text=This%20is%20a%20pen.
```

URL string with condition.

```swift
import URLStringBuilder

let someURL: "https://github.com/hackenbacker"
let condition: Bool = true

let urlString = URLQueryBuilder(baseURL: someURL)
   .appendIf(condition == true,  key: "text". value: "TRUE")
   .appendIf(condition == false, key: "text". value: "FALSE")
   .build()
// https://github.com/hackenbacker?text=TRUE
```

URL string with Sequence.

```swift
import URLStringBuilder

let someURL: "https://github.com/hackenbacker"
let list: [String] = ["source", "target"]

let urlString = URLQueryBuilder(baseURL: someURL)
   .append(key: "text", values: list)
   .build()
// https://github.com/hackenbacker?text=source&text=target
```

URL string with forEach iteration.

```swift
import URLStringBuilder

let someURL: "https://github.com/hackenbacker"
let list: [(key: String, value: String)] = [
   (key: "source", value: "EN"),
   (key: "target", value: "JA")
] 

let urlString = URLQueryBuilder(baseURL: someURL)
   .forEach(list) {
     $0.append(key: $1.key, value: $1.value)
   }
   .build()
// https://github.com/hackenbacker?source=EN&target=JA
```

