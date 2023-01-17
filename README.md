# ⚙️ URLStringBuilder
Utility to simplify making a URL String with parameters.

## Usage

URL string from simple key/value.

```swift
import URLStringBuilder

let someURL: "https://github.com/hackenbacker"

let urlString = URLStringBuilder(baseURL: someURL)
                  .append(key: "key1", value: "hello")
                  .append(key: "key2", value: "world")
                  .build()
// https://github.com/hackenbacker?key1=hello&key2=world
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
let list: [String] = [
    "Foo", "Bar", "Moo"
] 

let urlString = URLQueryBuilder(baseURL: someURL)
   .forEach(list) {
     $0.append(key: "text". value: $1)
   }
   .build()
// https://github.com/hackenbacker?text=Foo&text=Bar&text=Moo
```
