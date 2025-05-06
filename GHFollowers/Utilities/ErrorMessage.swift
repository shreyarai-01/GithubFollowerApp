//
//  ErrorMessage.swift
//  GHFollowers
//
import Foundation
enum GFError:String, Error {
    case invaliedUsername = "This username created an invalid request. Please try again..."
    
    case unableToconnect = "Unable to complete your request. Please CHECK YOU INTERNET"
    case invalidResponse = "Invalid response from server. Try again .."
    case invalidData = "data received is invalid"
    case unableFavs = " Unable to save this in favourite"
    case alreadyINFavs = " Already exist in favourite"
}
