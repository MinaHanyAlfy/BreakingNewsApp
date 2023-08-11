//
//  ErrorMessage.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-11.
//

import Foundation

enum ErrorMessage : String,Error {
    case InvalidData = "Sorry ,Something went wrong try agian."
    case InvalidRequest = "Sorry ,This url isn't good enough ,Try agian later."
    case InvalidResponse = " Server Error ,Modify your search and try agian."
}
