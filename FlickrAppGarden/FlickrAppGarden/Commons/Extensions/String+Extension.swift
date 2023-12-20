import Foundation

enum DateFormats: String {
    case universal = "MM/dd/yyyy"
}

extension String {
    func toDate(with format: DateFormats) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        guard let date = dateFormatter.date(from: self) else { return "" }

        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
}
