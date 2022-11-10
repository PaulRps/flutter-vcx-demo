//
//  AriesConnectionRepository.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

class AriesConnectionRepository {
    private final let logger = CustomLogger(context: AriesConnectionRepository.self)
    private final var cancellables: Set<AnyCancellable>
    private final let connectionRecordRepository: AriesConnectionRecordRepository
    private final let connectionPort: ConnectionPort

    init(
            connectionPort: ConnectionPort = AriesConnectionAdapter(),
            connectionRecordRepository: AriesConnectionRecordRepository = AriesConnectionRecordRepository()
    ) {
        cancellables = Set()
        self.connectionRecordRepository = connectionRecordRepository
        self.connectionPort = connectionPort
    }

    func connectionCreateWithInvite(
            invitation: ConnectionInvitationDto,
            inviteId: String
    ) -> Future<NSNumber, Error> {
        connectionPort.connectionCreateWithInvite(inviteId: inviteId, invitation: invitation)
    }

    func createConnection(withSourceId: String) -> Future<NSNumber, Error> {
        connectionPort.create(sourceId: withSourceId)
    }

    func connectionConnect(
            connectionHandle: NSNumber,
            connectionOptions: ConnectionOptionsDto
    ) -> Future<String, Error> {
        connectionPort.connectionConnect(
                connectionHandle: connectionHandle,
                connectionOptions: connectionOptions
        )
    }

    func getConnectionInvitationDetails(connectionHandle: NSNumber) -> Future<String, Error> {
        connectionPort.inviteDetails(connectionHandle: connectionHandle)
    }

    func updateConnectionState(connectionHandle: NSNumber) -> Future<AriesFinishedState, Error> {
        connectionPort.updateState(connectionHandle: connectionHandle)
    }

    func getSerializedConnection(connectionHandle: NSNumber) -> Future<String, Error> {
        connectionPort.getSerializedConnection(connectionHandle: connectionHandle)
    }

    func getConnectionHandleByPwDid(pairwiseDid: String) -> Future<NSNumber, Error> {
        Future { promise in
            self.connectionRecordRepository.findConnectionByDid(did: pairwiseDid)
                    .map { record in
                        record?.value
                    }
                    .flatMap({ serializedConnection in
                        self.connectionPort.getConnectionHandle(serializedConnection: serializedConnection)
                    })
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): promise(.failure(error))
                        }
                    }, receiveValue: { connectionHandle in
                        promise(.success(connectionHandle))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func getConnectionHandle(serializedConnection: String) -> Future<NSNumber, Error> {
        connectionPort.getConnectionHandle(serializedConnection: serializedConnection)
    }

    func releaseHandle(connectionHandle: NSNumber?) -> Future<NSNumber, Error> {
        Future { promise in
            promise(.success(self.releaseHandle(handle: connectionHandle)))
        }
    }

    func releaseHandle(handle: NSNumber?) -> NSNumber {
        connectionPort.releaseHandle(handle: handle)
    }

    func searchConnection(invitation: ConnectionInvitationDto) -> Future<SearchRecordDto?, Error> {
        let query = ["their_label", invitation.label!, "serviceEndpoint", invitation.serviceEndpoint!]
        return searchConnection(query: query)
    }

    func searchConnection(query: [String]) -> Future<SearchRecordDto?, Error> {
        Future { promise in
            self.connectionRecordRepository.search(keyValQuery: query)
                    .map { searchResponse in
                        searchResponse.records?[0]
                    }
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): promise(.failure(error))
                        }
                    }, receiveValue: { connectionRecord in
                        promise(.success(connectionRecord))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func deleteConnection(id: String) -> Future<Int, Error> {
        connectionRecordRepository.delete(recordId: id)
    }


    func saveSerializedConnection(
            _ serializedConnection: String,
            _ tags: ConnectionTagsDto
    ) -> Future<WalletRecordDto?, Error> {
        let myTheirDid = getMyTheirDidFrom(serializedConnection)
        let pairwiseDid = myTheirDid["my_did"]
        tags.myDid = pairwiseDid
        tags.theirDid = myTheirDid["their_did"]
        tags.createdAt = DateUtil.currentDateTime()
        tags.state = ConnectionStateEnum.FINISHED.value
        return connectionRecordRepository.save(value: serializedConnection, tag: tags)
    }

    private func getMyTheirDidFrom(_ serializedConnection: String) -> [String: String] {
        let connectionDict = JsonUtil.toDictionary(serializedConnection)
        let conData = connectionDict!["data"] as! [String: AnyObject]
        let myDid = conData["pw_did"] as! String

        let conState = connectionDict!["state"] as! [String: AnyObject]
        let conInvitee = conState["Invitee"] as! [String: AnyObject]
        let conInviteeCompleted = conInvitee["Completed"] as! [String: AnyObject]
        let didDoc = conInviteeCompleted["did_doc"] as! [String: AnyObject]
        let id = didDoc["id"] as! String
        let theirDid = id.split(separator: ":").map {
            String($0)
        }

        return ["my_did": myDid, "their_did": theirDid[2]]
    }
}
