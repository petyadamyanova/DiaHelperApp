//
//  API.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 22.02.24.
//

import Foundation

enum APIEndpoint {
    case registerUser
    case login
    case fetchMeals(userId: String)
    case addMeal(userId: String)
    case addGlucometerBloodSugarTest(userId: String)
    case deleteMeal(userId: String, mealId: String)
    case fetchTest(userId: String)
    case addStartTime(userId: String)
    case fetchStartTimes(userId: String)
    case updateUsername(userId: String)
    case updateEmail(userId: String)
    case updateNightscout(userId: String)
    case updateBirthDate(userId: String)
    case updateInsulinType(userId: String)
    case updatePumpModel(userId: String)
    case updateSensorModel(userId: String)
    case updateYearOfDiagnosis(userId: String)
    case addAppointment(userId: String)
    case fetchAppointments(userId: String)
    case deleteAppointment(userId: String, appointmentId: String)
    
    var rawValue: String {
        switch self {
        case .registerUser:
            return "/users/"
        case .login:
            return "/users/login"
        case .fetchMeals(let userId):
            return "/users/\(userId)/meals"
        case .addMeal(let userId):
            return "/users/\(userId)/meals"
        case .addGlucometerBloodSugarTest(let userId):
            return "/users/\(userId)/glucometer-tests"
        case .deleteMeal(let userId, let mealId):
            return "/users/\(userId)/meals/\(mealId)"
        case .addStartTime(let userId):
            return "/users/\(userId)/start-times"
        case .fetchTest(let userId):
            return "/users/\(userId)/glucometer-tests"
        case .fetchStartTimes(let userId):
            return "/users/\(userId)/start-times"
        case .updateUsername(let userId):
            return "/users/\(userId)/update-username"
        case .updateEmail(let userId):
            return "/users/\(userId)/update-email"
        case .updateNightscout(let userId):
            return "/users/\(userId)/update-nightscout"
        case .updateBirthDate(let userId):
            return "/users/\(userId)/update-birthdate"
        case .updateInsulinType(let userId):
            return "/users/\(userId)/update-insulin-type"
        case .updatePumpModel(let userId):
            return "/users/\(userId)/update-pump-model"
        case .updateSensorModel(let userId):
            return "/users/\(userId)/update-sensor-model"
        case .updateYearOfDiagnosis(let userId):
            return "/users/\(userId)/update-year-of-diagnosis"
        case .addAppointment(let userId):
            return "/users/\(userId)/appointments"
        case .fetchAppointments(let userId):
            return "/users/\(userId)/appointments"
        case .deleteAppointment(let userId, let appointmentId):
            return "/users/\(userId)/appointments/\(appointmentId)"
        }
    }
}

class API {
    static let baseURL = "http://localhost:8081"
    //static let baseURL = "http://138.68.92.11:8080"
    
    static func url(for endpoint: APIEndpoint, userId: String? = nil) -> URL? {
        let urlString = "\(baseURL)\(String(format: endpoint.rawValue, userId ?? ""))"
        return URL(string: urlString)
    }
}

enum NetworkError: Error {
    case invalidURL
    case encodingError
    case userNotFound
    case responseParsingFailed
    case invalidResponse
    case userAlreadyExists
    case invalidPassword
}

enum LoginError: Error {
    case userNotFound
    case invalidPassword
    case invalidEmailOrPassword
}

struct ErrorResponse: Codable {
    let error: String
}

