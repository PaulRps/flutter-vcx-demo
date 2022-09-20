//
//  ConnectionInvitationDto.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class ConnectionInvitationDto: ToJson{
    var id: String?
    var type: String?
    var label: String?
    var imageUrl: String?
    var image_url: String?
    var serviceEndpoint: String?
    var routingKeys: Array<String>?
    var recipientKeys: Array<String>?
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case label = "label"
        case imageUrl = "imageUrl"
        case image_url = "image_url"
        case serviceEndpoint = "serviceEndpoint"
        case routingKeys = "routingKeys"
        case recipientKeys = "recipientKeys"
    }
    
    init(){}
    
    init(
        id: String?,
        type: String?,
        label: String?,
        imageUrl: String?,
        image_url: String?,
        serviceEndpoint: String?,
        routingKeys: Array<String>?,
        recipientKeys: Array<String>?
    ){
        self.id = id
        self.type = type
        self.label = label
        self.imageUrl = imageUrl
        self.image_url = image_url
        self.serviceEndpoint = serviceEndpoint
        self.routingKeys = routingKeys
        self.recipientKeys = recipientKeys
    }
    
    static func from(map: [String:Any]?) -> ConnectionInvitationDto {
        return ConnectionInvitationDto(
            id: map?["@id"] as? String,
            type: map?["@type"] as? String,
            label: map?["label"] as? String,
            imageUrl: map?["imageUrl"] as? String,
            image_url: map?["image_url"] as? String,
            serviceEndpoint: map?["serviceEndpoint"] as? String,
            routingKeys: map?["routingKeys"] as? Array<String>,
            recipientKeys: map?["recipientKeys"] as? Array<String>
        )
    }
    
}
