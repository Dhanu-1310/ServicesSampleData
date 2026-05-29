import SwiftUI
import MapKit

struct MapSectionView: View {

    private static let serviceCoordinate = CLLocationCoordinate2D(
        latitude: 12.97306013789475,
        longitude: 80.25126129344224
    )

    private static let region = MKCoordinateRegion(
        center: serviceCoordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        Group {
            if #available(iOS 17, *) {
                Map(initialPosition: .region(Self.region)) {
                    Marker("Chennai", coordinate: Self.serviceCoordinate)
                }
            } else {
                Map(
                    coordinateRegion: .constant(Self.region),
                    annotationItems: [Annotation(coordinate: Self.serviceCoordinate)]
                ) { item in
                    MapMarker(coordinate: item.coordinate, tint: .red)
                }
            }
        }
        .frame(height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .allowsHitTesting(false)
        .overlay {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { openInMaps() }
        }
    }

    private func openInMaps() {
        let placemark = MKPlacemark(coordinate: Self.serviceCoordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Chennai"
        mapItem.openInMaps()
    }

    private struct Annotation: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }
}
