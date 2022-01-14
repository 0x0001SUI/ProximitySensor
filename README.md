# ProximitySensor

Property wrappers for using the Proximity Sensor from the SwiftUI app.

```swift
import SwiftUI
import ProximitySensor

struct ContentView: View {
    @ProximityMonitoringState private var isProximityMonitoringEnabled: Bool
    @ProximitySensorState private var isProximitySensorClose: Bool
    
    var body: some View {
            Form {
                Toggle("Proximity Monitoring", isOn: $isProximityMonitoringEnabled)
            }
            .onChange(of: isProximitySensorClose) { _ in
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
    }
}
```
