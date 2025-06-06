import UIKit

// “now” holds the exact current date and time and down to second (and sub-second) precision (2025-05-02 12:46:21 +0000)
let now1 = Date()
let now2 = Date.now // Same as above but easier to read
print("Current time is: \(now2)")

// The calendar we are using (can be Gregorian, Islamic, etc. — default is Gregorian)
let calender = Calendar.current

/*
 So how does Calendar.current know what my calendar is?
 Calendar.current is simply a pointer to the calendar the user has selected in their system settings
 */

print("------------------------------------------------")
// Components: We can extract different parts from a date, e.g year, month, day, hour
let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now2)
print("Year: \(components.year!)")
print("Month: \(components.month!)")
print("Day: \(components.day!)")
print("Hour: \(components.hour!)")
print("Minute: \(components.minute!)")
print("Seconds: \(components.second!)")

print("------------------------------------------------")

// Create a date from components (ex: April 21, 1993 at 14:00)
var dateComponents = DateComponents()
dateComponents.year = 1993
dateComponents.month = 4
dateComponents.day = 21
dateComponents.hour = 14

let myBirtday = calender.date(from: dateComponents)!
print("Born in: \(myBirtday)")
print("------------------------------------------------")

//Date formatting - customize it yourself
let formatter = DateFormatter()
formatter.dateStyle = .medium
formatter.timeStyle = .short
formatter.locale = Locale(identifier: "sv_SE")
let formattedDate = formatter.string(from: now2)
print("Formatted Date: \(formattedDate)")
print("------------------------------------------------")

// Add days to your time(you can add anything time related)
if let fiveDaysLater = calender.date(byAdding: .day, value: 5, to: now2) {
    print("Five days later: \(formatter.string(from: fiveDaysLater))")
}
print("------------------------------------------------")

//Difference between two dates
let futureDate = calender.date(byAdding: .day, value: 5, to: now2)!
let components2 = calender.dateComponents([.day], from: now2, to: futureDate)
print("Difference in days: \(components2.day ?? 0)")
print("------------------------------------------------")

// Check if a date is today
if calender.isDateInToday(now2) {
    print("Today!")
} else {
    print("Not today!")
}
print("------------------------------------------------")

// Check if a date is tomorrow
if let tomorrow = calender.date(byAdding: .day, value: 1, to: now2),
   calender.isDateInTomorrow(tomorrow) {
    print("The date for tomorrow is: \(tomorrow)")
} else { print("No days to see here!")}

print("------------------------------------------------")

// Start and end of the month
let startOfTheMonth = calender.date(from: calender.dateComponents([.year, .month], from: now1))!
print("Start of the month: \(startOfTheMonth)")

print("------------------------------------------------")

// Number of days in month
let range = calender.range(of: .day, in: .month, for: now1)!
print("Number of days in this month: \(range.count)")

print("------------------------------------------------")

// Get the time interval for the day
if let todayInterval = calender.dateInterval(of: .day, for: .now) {
    print("Start of the day: \(formatter.string(from: todayInterval.start))")
    print("End of the day: \(formatter.string(from: todayInterval.end))")
}

print("------------------------------------------------")

// Get the time interval for the week
if let weekInterval = calender.dateInterval(of: .weekOfYear, for: .now) {
    print("Start of the week: \(formatter.string(from: weekInterval.start))")
    print("End of the week: \(formatter.string(from: weekInterval.end))")
}

print("------------------------------------------------")

// Get the time interval for the month
if let monthInterval = calender.dateInterval(of: .month, for: .now) {
    print("Start of the month: \(formatter.string(from: monthInterval.start))")
    print("End of the month: \(formatter.string(from: monthInterval.end))")
}

print("------------------------------------------------")

if let monthInterval = calender.dateInterval(of: .month, for: .now) {
    
    let days = calender.dateComponents([.day], from: monthInterval.start, to: monthInterval.end).day!
    print("Number of days in this month: \(days)")
    
}



