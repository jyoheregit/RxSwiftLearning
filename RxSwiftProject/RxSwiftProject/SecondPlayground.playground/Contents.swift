import UIKit
import RxSwift
import RxCocoa

// PublishSubject - values sent only after subscription
// BehaviorSubject - Needs an initail Value
// ReplaySubject
// BehaviorRelay

// PublishSubject - it will immediately publish values
// Sends events only those after subscription

func executePublishSubject() {
    print("-------Publish Subject--------")

    let firstPublishSubject = PublishSubject<Int>()

    firstPublishSubject.on(.next(1)) // We cannot use this method on an Observable

    firstPublishSubject.subscribe { (event) in
        print("first subscriber: \(event)")
    }

    firstPublishSubject.on(.next(2))

    firstPublishSubject.subscribe { (event) in
        print("second subscriber: \(event)")
    }

    firstPublishSubject.on(.next(3))
}

// BehaviorSubject - Needs an initail Value
// Inital value and any other values sent after subscription

func executeBehaviorSubject() {
    print("-------Behavior Subject--------")

    let firstBehaviorSubject = BehaviorSubject(value: 1)

    firstBehaviorSubject.subscribe { (event) in
        print("first subscriber: \(event)")
    }

    firstBehaviorSubject.on(.next(2))
    firstBehaviorSubject.on(.completed)
    firstBehaviorSubject.on(.next(3)) // not sent as completed is sent

    firstBehaviorSubject.subscribe { (event) in
        print("second subscriber: \(event)")
    }
}

// ReplaySubject
// Similar to Behavior Subject
// But, it has a buffer size. Future subscribers will be replayed the buffer size of elements

func executeReplaySubject() {

    print("-------Replay Subject--------")

    let firstReplaySubject = ReplaySubject<Int>.create(bufferSize: 2)

    firstReplaySubject.on(.next(0))
    firstReplaySubject.on(.next(-1))
    firstReplaySubject.on(.next(-2))

    firstReplaySubject.subscribe { (event) in
        print("first subscriber: \(event)")
    }

    firstReplaySubject.on(.next(1))
    firstReplaySubject.on(.next(2))
    firstReplaySubject.on(.next(3))
    firstReplaySubject.on(.next(4))

    firstReplaySubject.subscribe { (event) in
        print("second subscriber: \(event)")
    }

    firstReplaySubject.subscribe { (event) in
        print("third subscriber: \(event)")
    }
}

// Variables - It is deprecated
// Use BehaviorRelay instead from RxCocoa Framework
// BehaviorRelay is a wrapper around BehaviorSubject
// Unlike `BehaviorSubject` it can't terminate with error or completed.

func executeBehaviorRelay() {
    print("-------Behavior Relay --------")

    let firstBehaviorRelay = BehaviorRelay<Int>(value: 1)
    print(firstBehaviorRelay.value)
    
    firstBehaviorRelay.asObservable().subscribe { (event) in
        print("first subscriber: \(event)")
    }
    firstBehaviorRelay.accept(2) // no .on(.next(1)) can be used here
    
    firstBehaviorRelay.asObservable().subscribe { (event) in
        print("second subscriber: \(event)")
    }
}

//executePublishSubject()
//executeBehaviorSubject()
//executeReplaySubject()
executeBehaviorRelay()
