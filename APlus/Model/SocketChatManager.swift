//
//  SocketChatManager.swift
//  agsChat
//
//  Created by MAcBook on 10/06/22.
//

import Foundation
import SocketIO


class SocketChatManager {

    // MARK: - Properties
    static let sharedInstance = SocketChatManager()
    private var manager : SocketManager?
    public var socket : SocketIOClient?
    
    /*let specs: SocketIOClientConfiguration = [.connectParams(["access_token": token]), .log(true), .forceNew(true), .selfSigned(true), .forcePolling(true), .secure(true), .reconnects(true), .forceWebsockets(true), .reconnectAttempts(3), .reconnectWait(3), .security(SSLSecurity(usePublicKeys: true)), .sessionDelegate(self)]  //  */
    
    fileprivate var socketHandlerArr = [((()->Void))]()
    typealias ObjBlock = @convention(block) () -> ()
    
    
    // MARK: - Life Cycle
    init() {
        initializeSocket()
        socket?.connect()
        setupSocketEvents()
        setup()
    }
    
    func stop() {
        socket?.removeAllHandlers()
    }

    // MARK: - Socket Setup
    func initializeSocket() {
        //
        //let manager = SocketManager(socketURL: URL(string: "http://14.99.147.156:5000")!, config: [.log(true), .compress])
        //private var manager = SocketManager(socketURL: URL(string: "http://192.168.1.94:5000")!, config: [.log(true), .compress,])
//        manager = SocketManager(socketURL: URL(string: "http://192.168.1.94:5000")!, config: [.log(true), .compress, .reconnects(true)])
        
        manager = SocketManager(socketURL: URL(string: "http://3.139.188.226:5000")!, config: [.log(true), .compress, .reconnects(true)])
        self.socket = manager?.defaultSocket
        
    }
    
    func establishConnection() {
        if !(Network.reachability.isReachable) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.establishConnection()
            }
            return
        } else {
            socket?.connect()
        }
    }
    
    func connectSocket(handler:(()->Void)? = nil) {
        if socket == nil {
            self.initializeSocket()
        }
        if self.socket?.status != .connected {
            handler?()
            return
        } else {
            if let handlr = handler {
                if self.socketHandlerArr.contains(where: { (handle) -> Bool in
                    let obj1 = unsafeBitCast(handle as ObjBlock, to: AnyObject.self)
                    let obj2 = unsafeBitCast(handlr as ObjBlock, to: AnyObject.self)
                    return obj1 === obj2
                }) {
                    self.socketHandlerArr.append(handlr)
                }
            }
            
            if self.socket?.status != .connecting {
                self.socket?.connect()
            }
        }
    }
    
    func closeConnection() {
        socket?.disconnect()
    }
    
    func setupSocketEvents() {
        
        socket?.on("receive-message", callback: { (data, ack) in
            print(data)
        })
        
        /*
        socket.on("allChat") { (data, ack) in
            guard let dataInfo = data.first else { return }
//            if let response : allChatUser = try? SocketParser.convert(data: dataInfo) {
//                print("Now this chat has \(response.numUsers) users.")
//            }
        }
        
        socket.on("user left") { (data, ack) in
            guard let dataInfo = data.first else { return }
//            if let response: SocketUserLeft = try? SocketParser.convert(data: dataInfo) {
//                print("User '\(response.username)' left...")
//                print("Now this chat has \(response.numUsers) users.")
//            }
        }   //  */
    }

    func setup(){
        socket?.on(clientEvent: .connect){ (data,ack) in
            print("Hey Socket Connected")
        }
        socket?.on(clientEvent: .disconnect){ (data,ack) in
            print("Socket Disconnect")
        }
        socket?.on(clientEvent: .reconnect){ (data,ack) in
            print("Event: Trying to reconnect \(data)")
        }
        socket?.on(clientEvent: .ping){ (data,ack) in
            print("Event: Socket pinged\(data)")
        }
        socket?.on(clientEvent: .error){ (data,ack) in
            print("Event: Error, ERROR Occured \(data)")
        }
        socket?.on(clientEvent: .reconnectAttempt){ (data,ack) in
            print("Event: Reconnection Attempt Occured \(data)")
        }
        socket?.on(clientEvent: .pong){ (data,ack) in
            print("Event: Socket ponged\(data)")
        }
    }
    
    // MARK: - Socket Emits
    func register(user: String) {
        socket?.emit("join", user)
    }
    
    func send(message: String) {
        if Network.reachability.isReachable {
            socket?.emit("send-message", message)
        }
    }
    
    func connectToServerWithNickname(nickname: String, completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
        socket?.emit("connectUser", "abc")
        
        socket?.on("userList") { ( dataArray, ack) -> Void in
            completionHandler(dataArray[0] as! [[String: AnyObject]])
        }
    }   //  */
}
