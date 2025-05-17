//
//  ErrorMessage.swift
//  GHFollowers
//
import Foundation
enum GFError:String, Error {
    case invaliedUsername       = "This username created an invalid request. Please try again..."
    case unableToconnect        = "Unable to complete your request. Please CHECK YOUR INTERNET"
    case invalidResponse        = "Invalid response from server. Try again .."
    case invalidData            = "Data received is invalid"
    case unableFavs             = "Unable to save this in favourite"
    case alreadyINFavs          = "Already exists in favourite"
}
