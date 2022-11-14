//
//  ConnectionTagsDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class ConnectionTagsDto: ToJson{
    var invitationKey: String?
    var state: String?
    var theirDid: String?
    var requestId: String?
    var myDid: String?
    var theirLabel: String?
    var theirVerkey: String?
    var imageUrl: String?
    var image_url: String?
    var serviceEndpoint: String?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case invitationKey = "invitation_key"
        case state = "state"
        case theirDid = "their_did"
        case requestId = "request_id"
        case myDid = "my_did"
        case theirLabel = "their_label"
        case theirVerkey = "their_verkey"
        case imageUrl = "imageUrl"
        case image_url = "image_url"
        case serviceEndpoint = "serviceEndpoint"
        case createdAt = "createdAt"
    }
    
    init(
        state : String?,
        requestId : String?,
        theirLabel : String?,
        theirVerkey : String?,
        invitationKey : String?,
        imageUrl : String?,
        image_url :String?,
        serviceEndpoint : String?=nil,
        theirDid: String? = nil,
        myDid: String?=nil,
        createdAt: String? = nil
    ){
        self.state = state
        self.requestId = requestId
        self.theirLabel = theirLabel
        self.theirVerkey = theirVerkey
        self.invitationKey = invitationKey
        self.imageUrl = imageUrl
        self.image_url = image_url
        self.serviceEndpoint = serviceEndpoint
        self.theirDid = theirDid
        self.myDid = myDid
        self.createdAt = createdAt
    }
    
    static func from(tags: [String : String], invitation: ConnectionInvitationDto) -> ConnectionTagsDto {
        let connectionTag =  JsonUtil.fromDictionary(tags, ConnectionTagsDto.self)!
        connectionTag.requestId = invitation.id
        connectionTag.theirLabel = invitation.label
        connectionTag.theirVerkey = invitation.routingKeys?[0] ?? ""
        connectionTag.invitationKey = invitation.recipientKeys![0]
        connectionTag.imageUrl = invitation.imageUrl
        connectionTag.image_url = invitation.image_url
        connectionTag.serviceEndpoint = invitation.serviceEndpoint
        
        return connectionTag
    }
    
    static func from(invitation: ConnectionInvitationDto, serializedConnection: String) -> ConnectionTagsDto {
        let tags = from(serializedConnection: serializedConnection)
        return ConnectionTagsDto(
            state: ConnectionStateEnum.INITIALIZED.value,
            requestId: invitation.id,
            theirLabel: invitation.label,
            theirVerkey: invitation.routingKeys?[0] ?? "",
            invitationKey: invitation.recipientKeys![0],
            imageUrl: invitation.imageUrl,
            image_url: invitation.image_url,
            serviceEndpoint: invitation.serviceEndpoint,
            theirDid: tags.theirDid,
            myDid: tags.myDid
        )
    }
    
    static func from(serializedConnection: String) -> ConnectionTagsDto {
        
        let connectionDict = JsonUtil.toDictionary(serializedConnection)
        let conData = connectionDict!["data"] as! [String: Any]
        let myDid = conData["pw_did"] as! String
        
        let conState = connectionDict!["state"] as! [String: Any]
        let conInvitee = conState["Invitee"] as! [String: Any]
        let conInviteeCompleted = conInvitee["Completed"] as! [String: Any]
        let didDoc = conInviteeCompleted["did_doc"] as! [String: Any]
        let id = didDoc["id"] as! String
        let theirDid = id.split(separator: ":").map {
            String($0)
        }
        let service = didDoc["service"] as? [String:Any]
        let recipientKey = service?["recipientKeys"] as? [String]
        
        return ConnectionTagsDto(
            state: ConnectionStateEnum.FINISHED.value,
            requestId: nil,
            theirLabel: nil,//TODO: find way to get label
            theirVerkey: nil,
            invitationKey: recipientKey?[0] as? String,
            imageUrl: nil,
            image_url: nil,
            serviceEndpoint: service?["serviceEndpoint"] as? String,
            theirDid: theirDid[2],
            myDid: myDid,
            createdAt: nil
        )
    }
    
}
