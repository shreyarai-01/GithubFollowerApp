import Foundation

extension String{
    func convertTodate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier:"en-US-POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    func convertDisplay() -> String{
        guard let date = self.convertTodate() else { return " N/A"}
        
        return date.convertToMonethYearFormat()
    }
}
