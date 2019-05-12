import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

print("******* startWith *******")
let observable = Observable.of("two", "three", "four")
observable
    .startWith("zero", "one")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("******* concat *******")
// just add
var observable1 = Observable.of("one", "two", "three")
var observable2 = Observable.of("1", "2", "3")
let concatObservable : Observable<String>  = Observable.concat(observable1, observable2)
concatObservable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("******* merge *******")
// according to the order in which it appears
var observable3 = Observable.of("one", "two", "three")
var observable4 = Observable.of("1", "2", "3", "4", "5")
let mergeObservable : Observable<String> = Observable.merge(observable3, observable4)
mergeObservable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("******* zip *******")
// interleave to zip as in a zip
var observable5 = Observable.of("one", "two", "three")
var observable6 = Observable.of("1", "2", "3", "4", "5")
let zipObservable : Observable<(String, String)> = Observable.zip(observable5, observable6)
zipObservable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("******* combineLatest *******")
// Latest from each of the observable
var observable7 = Observable.of("one", "two", "three")
var observable8 = Observable.of("1", "2", "3", "4", "5")
let combineObservable : Observable<(String, String)> = Observable.combineLatest(observable7, observable8)
combineObservable
    .subscribe(onNext: { (value : (String, String)) in
        print(value.0 + " " + value.1)
    })
    .disposed(by: disposeBag)


print()

let publishSubject1 = PublishSubject<String>()
let publishSubject2 = PublishSubject<String>()

let clObservable : Observable<(String, String)> = Observable.combineLatest(publishSubject1,
                                                                           publishSubject2)
clObservable
    .subscribe(onNext: { (value : (String, String)) in
        print(value.0 + " " + value.1)
    },
    onCompleted : {
        print("completed")
    })
    .disposed(by: disposeBag)

publishSubject1.onNext("C")
publishSubject2.onNext("D")
publishSubject1.onNext("E")
publishSubject1.onNext("F")
publishSubject2.onNext("G")


print("******* withLatestFrom *******")
var observable9 = Observable.of("one", "two", "three", "four" , "five")
var observable10 = Observable.of("1", "2", "3")
let combinObservable : Observable<String> = observable10.withLatestFrom(observable9)
combinObservable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
