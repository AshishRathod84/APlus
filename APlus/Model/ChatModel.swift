//
//  ChatModel.swift
//  agsChat
//
//  Created by MAcBook on 10/06/22.
//

import Foundation

public struct allChatUser : Codable {
    var userName : String?
    var userDisName : String?
    var chatUserImg : String?
    var lastChatMsg : String?
    var lastMsgTime : String?
    var unreadMsg : String?
}

public struct allGrupUser : Codable {
    var userImg : String?
    var userName : String?
    var isSelected : Bool? = false
    var userDisName : String?
}

public struct allUser : Codable {
    var userImg : String?
    var userName : String?
    var userDisName : String?
}

public struct chatMessage {
    var msgDate : String
    var chatMsg : [userChat]
}

public struct userChat : Codable {
    //var userImg : String?       //  remove
    var userName : String?
    //var userDisName : String?   //  remove
    var msg : String?
    //var img : String?           //  remove
    var msgTime : String?
    var msgDate : String?
    var isSend : Bool?
    var isMine : Bool?
    var isImage : Bool?
    var isVideo : Bool?
}
