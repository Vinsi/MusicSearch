//
//  Utility.swift
//  DailyRail
//
//  Created by Vinsi on 27/12/2021.
//

import Foundation
import UIKit

extension UIResponder {

    static var identifier: String {
        return "\(self)"
    }
}

extension DateFormatter {
    fileprivate static let shared = { () -> DateFormatter in
        let dateFormatter =  DateFormatter()
        let timeZone: String? = try? AppSettings().getValue(for: .timeZone)
            dateFormatter.timeZone = .init(identifier: timeZone ?? "")
        return dateFormatter
    }()
}

extension DateComponentsFormatter {
    fileprivate static let shared = DateComponentsFormatter()
}

extension Int {
    var secondsToTimeString: String? {
        guard self > 1 else {
            return "-"
        }
        let formatter = DateComponentsFormatter.shared
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full
        return formatter.string(from: TimeInterval(self))
    }
}

extension Date {
    
    enum APPDateFormat: String {
        case appDisplay = "MMM d, h:mm a"
        case withMicroSecond = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
        case withOutMicroSecond = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case logFormat = "HH:mm:ss"
    }

    func toString(format: APPDateFormat) -> String {
        DateFormatter.shared.dateFormat = format.rawValue
        return DateFormatter.shared.string(from: self)
    }
    
    init?(date: String, format: APPDateFormat) {
        DateFormatter.shared.dateFormat = format.rawValue
        guard let date = DateFormatter.shared.date(from: date) else {
            return nil
        }
        self = date
    }
}
