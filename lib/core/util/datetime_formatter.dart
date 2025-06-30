import 'package:intl/intl.dart';

/// Date & Time formatting utility
class DateTimeFormatter {
  /// Attempts to parse a date string using a specific pattern.
  static DateTime? tryParse(String dateString, String pattern) {
    try {
      return DateFormat(pattern).parse(dateString);
    } on FormatException {
      return null;
    }
  }

  /// Format a DateTime using a DatePattern
  static String formatDate(DateTime dateTime, DatePattern pattern) {
    final patternString = datePatterns[pattern];
    if (patternString == null) {
      throw ArgumentError('Date pattern not found.');
    }
    return DateFormat(patternString).format(dateTime);
  }

  /// Format a DateTime using a TimePattern
  static String formatTime(DateTime dateTime, TimePattern pattern) {
    final patternString = timePatterns[pattern];
    if (patternString == null) {
      throw ArgumentError('Time pattern not found.');
    }
    return DateFormat(patternString).format(dateTime);
  }

  /// Convert a date string from one DatePattern to another
  static String? convertDatePattern(
    String input, {
    required DatePattern from,
    required DatePattern to,
  }) {
    final fromPattern = datePatterns[from];
    final toPattern = datePatterns[to];
    if (fromPattern == null || toPattern == null) return null;

    final parsed = tryParse(input, fromPattern);
    return parsed != null ? DateFormat(toPattern).format(parsed) : null;
  }

  /// Convert a time string from one TimePattern to another
  static String? convertTimePattern(
    String input, {
    required TimePattern from,
    required TimePattern to,
  }) {
    final fromPattern = timePatterns[from];
    final toPattern = timePatterns[to];
    if (fromPattern == null || toPattern == null) return null;

    final parsed = tryParse(input, fromPattern);
    return parsed != null ? DateFormat(toPattern).format(parsed) : null;
  }

  /// Format to a map of all [DatePattern] results
  static Map<DatePattern, String> formatDateToAllPatterns(DateTime dateTime) {
    return {
      for (final pattern in DatePattern.values)
        pattern: formatDate(dateTime, pattern),
    };
  }

  /// Format to a map of all [TimePattern] results
  static Map<TimePattern, String> formatTimeToAllPatterns(DateTime dateTime) {
    return {
      for (final pattern in TimePattern.values)
        pattern: formatTime(dateTime, pattern),
    };
  }
}

enum DatePattern {
  /// ISO 8601 format: 2023-05-09
  iso8601,

  /// US standard format: 05/09/2023
  us,

  /// European standard format: 09/05/2023
  european,

  /// Day with abbreviated month and year: 09-May-2023
  dayMonthAbbrYearDash,

  /// Day with abbreviated month and year: 9 May 2023
  dayMonthAbbrYearSpace,

  /// Day with full month and year: 9 May 2023
  dayMonthFullYearSpace,

  /// Locale-aware short format: May 9, 2023
  localeShort,

  /// Locale-aware long format: May 9, 2023
  localeLong,

  /// Weekday, day, and abbreviated month: Tue, 9 May 2023
  weekdayDayMonthAbbr,

  /// Full weekday, day, and full month: Tuesday, 9 May 2023
  weekdayDayMonthFull,
}

/// A map that provides the string pattern for each [DatePattern] enum value.
const Map<DatePattern, String> datePatterns = {
  DatePattern.iso8601: 'yyyy-MM-dd',
  DatePattern.us: 'MM/dd/yyyy',
  DatePattern.european: 'dd/MM/yyyy',
  DatePattern.dayMonthAbbrYearDash: 'dd-MMM-yyyy',
  DatePattern.dayMonthAbbrYearSpace: 'd MMM yyyy',
  DatePattern.dayMonthFullYearSpace: 'd MMMM yyyy',
  DatePattern.localeShort: 'yMMMd',
  DatePattern.localeLong: 'yMMMMd',
  DatePattern.weekdayDayMonthAbbr: 'E, d MMM yyyy',
  DatePattern.weekdayDayMonthFull: 'EEEE, d MMMM yyyy',
};

/// A utility function to demonstrate the use of the enum and map.
String formatDate(DateTime dateTime, DatePattern pattern) {
  final patternString = datePatterns[pattern];
  if (patternString == null) {
    throw ArgumentError('Pattern not found in the map.');
  }
  return DateFormat(patternString).format(dateTime);
}

/// An enumeration of common time formatting styles.
enum TimePattern {
  /// Standard 12-hour format with AM/PM: 4:07 PM
  standard12Hour,

  /// Padded 12-hour format with AM/PM: 04:07 PM
  padded12Hour,

  /// Standard 12-hour format with seconds: 4:07:03 PM
  standard12HourWithSeconds,

  /// Standard 24-hour format (military time): 16:07
  standard24Hour,

  /// Standard 24-hour format with seconds: 16:07:03
  standard24HourWithSeconds,

  /// Locale-aware 12-hour format (skeleton): 4:07 PM
  locale12Hour,

  /// Locale-aware 24-hour format (skeleton): 16:07
  locale24Hour,

  /// Locale-aware 12-hour format with seconds (skeleton): 4:07:03 PM
  locale12HourWithSeconds,

  /// Locale-aware 24-hour format with seconds (skeleton): 16:07:03
  locale24HourWithSeconds,
}

/// A map that provides the string pattern for each [TimePattern] enum value.
const Map<TimePattern, String> timePatterns = {
  TimePattern.standard12Hour: 'h:mm a',
  TimePattern.padded12Hour: 'hh:mm a',
  TimePattern.standard12HourWithSeconds: 'h:mm:ss a',
  TimePattern.standard24Hour: 'HH:mm',
  TimePattern.standard24HourWithSeconds: 'HH:mm:ss',
  TimePattern.locale12Hour: 'jm',
  TimePattern.locale24Hour: 'Hm',
  TimePattern.locale12HourWithSeconds: 'jms',
  TimePattern.locale24HourWithSeconds: 'Hms',
};

/// A utility function to demonstrate the use of the enum and map.
String formatTime(DateTime dateTime, TimePattern pattern) {
  final patternString = timePatterns[pattern];
  if (patternString == null) {
    throw ArgumentError('Pattern not found in the map.');
  }
  return DateFormat(patternString).format(dateTime);
}


/* 
Date Formats
| Format Pattern      | Example Output         | Description                      |
| ------------------- | ---------------------- | -------------------------------- |
| `yMd`               | `6/30/2025`            | Short, locale-specific date      |
| `yMMMd`             | `Jun 30, 2025`         | Medium format date               |
| `yMMMMd`            | `June 30, 2025`        | Long format with full month name |
| `yyyy-MM-dd`        | `2025-06-30`           | ISO 8601 format                  |
| `dd/MM/yyyy`        | `30/06/2025`           | Common international format      |
| `MM/dd/yyyy`        | `06/30/2025`           | US format                        |
| `EEEE, MMM d, yyyy` | `Monday, Jun 30, 2025` | Full weekday with full date      |
| `d MMMM yyyy`       | `30 June 2025`         | Day, full month, year            |

Time Formats
| Format Pattern | Example Output | Description        |
| -------------- | -------------- | ------------------ |
| `jm`           | `5:08 PM`      | 12-hour format     |
| `Hm`           | `17:08`        | 24-hour format     |
| `h:mm a`       | `5:08 PM`      | 12-hour with AM/PM |
| `HH:mm:ss`     | `17:08:00`     | Full 24-hour time  |
| `hh:mm:ss a`   | `05:08:00 PM`  | Full 12-hour time  |

Common Format Tokens
| Token  | Description        | Example  |
| ------ | ------------------ | -------- |
| `y`    | Year               | `2025`   |
| `M`    | Month (1-12)       | `6`      |
| `MM`   | Month, 2-digit     | `06`     |
| `MMM`  | Month, abbreviated | `Jun`    |
| `MMMM` | Month, full name   | `June`   |
| `d`    | Day                | `30`     |
| `dd`   | Day, 2-digit       | `30`     |
| `E`    | Weekday (short)    | `Mon`    |
| `EEEE` | Weekday (full)     | `Monday` |
| `H`    | Hour (0–23)        | `17`     |
| `h`    | Hour (1–12)        | `5`      |
| `m`    | Minute             | `08`     |
| `s`    | Second             | `00`     |
| `a`    | AM/PM              | `PM`     |

*/