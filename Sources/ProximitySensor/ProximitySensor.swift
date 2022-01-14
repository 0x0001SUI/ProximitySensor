#if os(iOS)
import SwiftUI
import Combine

// MARK: - ProximityMonitoringState

/// A property wrapper type that can read and write a Boolean value
/// that indicates whether proximity monitoring is enabled.
@available(iOS 13, *)
@propertyWrapper
public struct ProximityMonitoringState: DynamicProperty {
    @StateObject private var model = Model()
    
    public init() {}
    
    @available(iOS 13, *)
    public var wrappedValue: Bool {
        get { projectedValue.wrappedValue }
        nonmutating set { projectedValue.wrappedValue = newValue }
    }
    
    @available(iOS 13, *)
    public var projectedValue: Binding<Bool> {
        Binding {
            model.value
        } set: { newValue in
            model.value = newValue
        }
    }
}


extension ProximityMonitoringState {
    private class Model: ObservableObject {
        @Published var value: Bool
        private var cancellable = Set<AnyCancellable>()
        private var device: UIDevice = .current
        
        init() {
            self.value = device.isProximityMonitoringEnabled
            
            self.device
                .publisher(for: \.isProximityMonitoringEnabled)
                .filter { $0 != self.value }
                .assign(to: \.value, on: self)
                .store(in: &cancellable)
            
            self.$value
                .filter { $0 != self.device.isProximityMonitoringEnabled }
                .sink { self.device.isProximityMonitoringEnabled = $0 }
                .store(in: &self.cancellable)
        }
    }
}


// MARK: - ProximityState

/// A property wrapper type that can read and write a Boolean value
/// that indicates whether the proximity sensor is close to the user.
@available(iOS 13, *)
@propertyWrapper
public struct ProximitySensorState: DynamicProperty {
    @StateObject private var model = Model()
    
    public init() {}
    
    @available(iOS 13, *)
    public var wrappedValue: Bool {
        get { projectedValue.wrappedValue }
        nonmutating set { projectedValue.wrappedValue = newValue }
    }
    
    @available(iOS 13, *)
    public var projectedValue: Binding<Bool> {
        Binding {
            model.value
        } set: { newValue in
            model.value = newValue
        }
    }
}


extension ProximitySensorState {
    private class Model: ObservableObject {
        @Published var value: Bool
        private var cancellable = Set<AnyCancellable>()
        private var device: UIDevice = .current
        
        init() {
            self.value = device.proximityState
            
            self.device
                .publisher(for: \.proximityState)
                .filter { $0 != self.value }
                .assign(to: \.value, on: self)
                .store(in: &self.cancellable)
        }
    }
}
#endif
