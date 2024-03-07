//
//  QuoteErrors.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//


import Foundation

enum QuoteErrors: String, Error{
    case invalidParamName = "Created an invalid request. Please try again"
    case unableToComplete = "Unable to complete request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server can not be decoded. Please try again"
    case invalidDataFromServer = " The The data received from the server was invalid. Please try again"
}
