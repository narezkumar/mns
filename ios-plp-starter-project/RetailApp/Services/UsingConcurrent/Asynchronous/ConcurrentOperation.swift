//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.


import Foundation

class ConcurrentOperation: Operation {
    private let concurrentQueue = DispatchQueue(label: "ConcurrentOperation", attributes: .concurrent)

    enum State: String {
        case ready = "Ready", executing = "Executing", finished = "Finished"
        
        fileprivate var keyPath: String {
            "is" + rawValue
        }
    }
    
    private var _state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: _state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: _state.keyPath)
        }
    }
    
    var state: State {
        get {
            concurrentQueue.sync { self._state }
        }
        set(value) {
            concurrentQueue.sync {
                self._state = value
            }
        }
    }
}


extension ConcurrentOperation {
    //: NSOperation Overrides
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    
    override var isAsynchronous: Bool {
        true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        main()
        state = .executing
    }
    
    override func cancel() {
        state = .finished
    }
}
