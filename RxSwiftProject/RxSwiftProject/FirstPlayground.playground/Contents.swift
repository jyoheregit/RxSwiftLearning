import Foundation
import RxSwift

print("------- First Observable --------")

var firstObservable = Observable.of(1, 2) // of - many values

print("------ First Subscriber ---------")
firstObservable.subscribe { event in
    print(event)
}

print("------- Second Subscriber --------")
firstObservable.subscribe { event in
    switch event {
    case .next(let value):
        print(value)
    case .error(let error):
        print(error)
    case .completed:
        print(event)
    }
}

print("------- Third Subscriber --------")
firstObservable.subscribe ( onNext: {
    print($0)
})

print("------- Second Observable --------")

var secondObservable = Observable.just("One") // just - single value

secondObservable.subscribe({ event in
    print(event.element ?? "Value is nil") // element gives the element, for completed the value is nil
})

print("-------Long subscribe method -------")

secondObservable.subscribe(onNext: { (value) in
    print(value)
}, onError: { error in
    print(error)
}, onCompleted: {
    print("completed")
}, onDisposed: {
    print("Disposed")
})

//All parameters are optional in the above method as a default value is assigned
let subscription = secondObservable.subscribe()

print("-------Long subscribe method with trailing closure -------")

secondObservable.subscribe(onNext: { (value) in
    print(value)
}, onError: { (error) in
    print(error)
}, onCompleted: {
    print("C")
}) { // Trailing closure syntax
    print("D")
}

// Third observable

print("------- Third Observable --------")

let thirdObservable = Observable.from([1, 2, 3, 4]) // from - array values

thirdObservable.subscribe { (event) in
    print(event)
}

