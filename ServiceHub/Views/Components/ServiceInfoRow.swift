import SwiftUI

struct ServiceInfoRow: View {

    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(icon)
                .resizable()
                .frame(width: 22, height: 22)

            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(value)
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }
    }
}
