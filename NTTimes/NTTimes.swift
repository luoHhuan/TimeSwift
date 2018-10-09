//
//  NTTimes.swift
//  NTProgram
//
//  Created by rp.wang on 2018/10/9.
//  Copyright © 2018年 Luoh. All rights reserved.
//

import Foundation

extension String{
    /**
     时间转时间戳
     NSInteger
     */
    func dateTimeTOtimestamp(dateTime : String) -> NSInteger {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormmater.date(from: dateTime)
        let dateStamp : TimeInterval = date!.timeIntervalSince1970
        let dateStr : NSInteger = NSInteger(dateStamp)
        return  dateStr
    }
}

extension NSInteger{
    /**
     时间戳转时间
     string返回
     */
    func timestampTOdateTime(timeStamp : NSInteger) -> String {
        let timeInter : TimeInterval = TimeInterval(timeStamp)
        let date = NSDate (timeIntervalSince1970: timeInter)
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dformatter.string(from: date as Date)
        return time
    }
}

extension NSDate{
    /**
     传入Date 获取是这周的星期几
     得到星期
     */
    func weekdayStringFromDate(timeDate : Date) -> String {
        let weekdays:NSArray = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: timeDate as Date)
        return weekdays.object(at: theComponents.weekday!) as! String
    }
}

class NTTimes {
    
    /**
        获取当前时间
        返回字符串格式
     */
    func getDateFromNow() -> String {
        ///获取当前时间
        let dateFromNow = Date()
        ///创建一个dateFormmater作为桥梁进行字符串转换
        let dateFormmater = DateFormatter()
        ///DateFormatter对象的string方法执行转换（参数dateFromNow为当前获取的时间）
        ///设置时间格式
        dateFormmater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        ///设置字符串进行转换
        let dateNowString = dateFormmater.string(from: dateFromNow)
        ///返回字符串格式的当前时间
        return dateNowString
    }
    
    /**
        获取当前时间的 年、月、日、时、分、秒
        皆以NSInteger形式返回
     */
    func getYearMonthDayAndClock() -> (year:NSInteger, month:NSInteger, day:NSInteger, hour:NSInteger, mins:NSInteger, second:NSInteger) {
        ///获取日历信息
        let calen : Calendar = Calendar(identifier: .gregorian)
        var comps : DateComponents = DateComponents()
        comps = calen.dateComponents([.year, .month, .day, .hour, .minute, .second], from:Date())
        
        return (comps.year!,comps.month!,comps.day!,comps.hour!,comps.minute!,comps.second!)
    }
    
    /**
        获取当前时间戳
        string返回
     */
    func getTimestamp() -> NSInteger {
        let dateNow = NSDate()
        let timeInterval : TimeInterval = dateNow.timeIntervalSince1970
        let timeStamp : NSInteger = NSInteger(timeInterval)
        return timeStamp
    }
    
    /**
        时间转时间戳
        NSInteger
     */
    func dateTimeTOtimestamp(dateTime : String) -> NSInteger {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormmater.date(from: dateTime)
        let dateStamp : TimeInterval = date!.timeIntervalSince1970
        let dateStr : NSInteger = NSInteger(dateStamp)
        return  dateStr
    }
    
    /**
        时间戳转时间
        string返回
     */
    func timestampTOdateTime(timeStamp : NSInteger) -> String {
        let timeInter : TimeInterval = TimeInterval(timeStamp)
        let date = NSDate (timeIntervalSince1970: timeInter)
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = dformatter.string(from: date as Date)
        return time
    }
    
    /**
        时间戳转日期 判断当前时间是 昨天、今天、
        传时间戳
        返回时间列表
     */
    func dealTimeString(timeStamp : TimeInterval) -> String {
        //如果服务端返回的时间戳精确到毫秒，需要除以1000,否则不需要
//        let timeDate = getNowDateFromatAnDate(Date(timeIntervalSince1970: timeStamp/1000))
        let timeDate = Date(timeIntervalSince1970: timeStamp)
        let dformatter = DateFormatter()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(timeDate) {
            ///今天
            dformatter.dateFormat = "今天 HH:mm"
            return dformatter.string(from: timeDate)
        }else if calendar.isDateInYesterday(timeDate){
            ///昨天
            dformatter.dateFormat = "昨天 HH:mm"
            return dformatter.string(from: timeDate)
        }else if calendar.isDateInTomorrow(timeDate){
            ///明天
            dformatter.dateFormat = "明天"
            return dformatter.string(from: timeDate)
        }else if calendar.isDateInWeekend(timeDate){
            //是同一周
            let week = weekdayStringFromDate(timeDate: timeDate)
            dformatter.dateFormat = "\(week) HH:mm"
            return dformatter.string(from: timeDate)
        }else{
            dformatter.dateFormat = "yyyy-MM-dd HH:mm"
            return dformatter.string(from: timeDate)
        }
    }
    
    /**
        传入Date 获取是这周的星期几
        得到星期
     */
    func weekdayStringFromDate(timeDate : Date) -> String {
        let weekdays:NSArray = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: timeDate as Date)
        return weekdays.object(at: theComponents.weekday!) as! String
    }
    
//    /**
//        根据本地时区转换
//     */
//    func getNowDateFromatAnDate(_ anyDate: Date?) -> Date {
//        //设置源日期时区
//        let sourceTimeZone = NSTimeZone(abbreviation: "UTC")
//        //或GMT
//        //设置转换后的目标日期时区
//        let destinationTimeZone = NSTimeZone.local as NSTimeZone
//        //得到源日期与世界标准时间的偏移量
//        var sourceGMTOffset: Int? = nil
//        if let aDate = anyDate {
//            sourceGMTOffset = sourceTimeZone?.secondsFromGMT(for: aDate)
//        }
//        //目标日期与本地时区的偏移量
//        var destinationGMTOffset: Int? = nil
//        if let aDate = anyDate {
//            destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: aDate)
//        }
//        //得到时间偏移量的差值
//        let interval = TimeInterval((destinationGMTOffset ?? 0) - (sourceGMTOffset ?? 0))
//        //转为现在时间
//        var destinationDateNow: Date? = nil
//        if let aDate = anyDate {
//            destinationDateNow = Date(timeInterval: interval, since: aDate)
//        }
//        return destinationDateNow!
//    }
}
