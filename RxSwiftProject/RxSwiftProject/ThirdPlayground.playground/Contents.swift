import Foundation
import RxSwift
import RxCocoa

// Transformation
// Map
// FlatMap
// FlatMapLatest

// Map

let disposeBag = DisposeBag()

let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

print("----------First Observable ---------")
let firstObservable = Observable<NSNumber>.of(1,2)

let transformedObservable : Observable<String?> = firstObservable
                                                        .map { (value) in
                                                            print("\(value) +++++")
                                                            return formatter.string(from: value)
                                                        }
transformedObservable
    .subscribe(onNext: { (value) in
        print(value ?? "No value")
    }).disposed(by: disposeBag)

print("----------Second Observable ---------")
let secondObservable : Observable<[Int]> = Observable.of([1,2,3])

secondObservable
    .map { (array) -> [Int] in
        array.map({ (value) in
            return value * 2
        })
    }
    .subscribe(onNext: { (value) in
        print(value)
    }).disposed(by: disposeBag)


// FlatMap
// An Observable sequence can itself have Observable properties that you want to subscribe to; flatMap can be
// used to reach into an Observable sequence to work with its Observable sequences.

print("----------FlatMap ---------")

struct Game {
    var price : BehaviorRelay<Double>
}

var game1 = Game(price: BehaviorRelay(value: 100))
var game2 = Game(price: BehaviorRelay(value: 200.50))

let gameSubject = PublishSubject<Game>()

gameSubject
    .flatMap { (game) in
        return game.price.asObservable() //making price as an observable
    }
    .subscribe(onNext: { (value) in
        print("Game Price FlatMap \(value)")
    }).disposed(by: disposeBag)

gameSubject
    .flatMapLatest { (game) in
        return game.price.asObservable() //making price as an observable
    }
    .subscribe(onNext: { (value) in
        print("Game Price FlatMapLatest \(value)")
    }).disposed(by: disposeBag)

gameSubject.onNext(game1)
game1.price.accept(150)

gameSubject.onNext(game2)
game2.price.accept(80)

game1.price.accept(250) // Changing game1 price here will have no effect. It will not be printed out. This is
// because flatMapLatest has already switched to the latest observable game2.










