//
//  HolidayRequest.swift
//  HolidayCalendar_1126
//
//  Created by Allie Kim on 2020/11/26.
//

import Foundation

// error enum을 생성한다.
enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
}

// API에 요청하기 위한 request struct를 생성한다.
struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "c2d98a48b88c8527fb8f527783b7c32c2cdfaa9f"

    init(countryCode: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = formatter.string(from: date)
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
    }

    // completion handler의 Result<T,T> : success 또는 failure의 값을 보여주는
    // A value that represents either a success or a failure, including an associated value in each case.
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            // 데이터가 없는 경우
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayReponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                // 데이터를 정제 할 수 없는 경우
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
