//
//  Holiday.swift
//  HolidayCalendar_1126
//
//  Created by Allie Kim on 2020/11/26.
//

import Foundation

// 가져와야하는 데이터(json)을 담기 위한 struct이다.

struct HolidayReponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
}


struct DateInfo: Decodable {
    var iso: String
}
