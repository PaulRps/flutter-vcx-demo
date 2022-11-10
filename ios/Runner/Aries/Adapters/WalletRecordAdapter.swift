//
//  WalletRecordAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine
import vcx

class WalletRecordAdapter: WalletRecordPort, CheckVcxResult {
    private final let logger = CustomLogger(context: WalletRecordAdapter.self)
    private final var cancellables: Set<AnyCancellable>
    private let vcx: VcxAPI

    init() {
        vcx = VcxAPI()
        cancellables = Set()
    }

    func add(record: WalletRecordDto) -> Future<Int, Error> {
        Future { promise in
            self.logger.info(message: "adding record in wallet")
            self.vcx.addRecordWallet(
                    record.type.value,
                    recordId: record.uuid,
                    recordValue: record.value,
                    tagsJson: record.tag) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on adding record in wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "added record in wallet successfully")
                promise(.success(0))
            }
        }
    }

    func update(record: WalletRecordDto) -> Future<Int, Error> {
        Future { promise in
            self.logger.info(message: "updating record in wallet")
            self.vcx.updateRecordWallet(
                    record.type.value,
                    withRecordId: record.uuid,
                    withRecordValue: record.value!) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on updating record in wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "updated record in wallet successfully")
                promise(.success(0))
            }
        }
    }

    func updateTags(record: WalletRecordDto) -> Future<Int, Error> {
        Future { promise in
            self.logger.info(message: "updating tags in wallet")
            self.vcx.updateRecordTagsWallet(
                    record.type.value,
                    recordId: record.uuid,
                    tagsJson: record.tag!) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on updating tags in wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "updated tags in wallet sucessfully")
                promise(.success(0))
            }
        }
    }

    func deleteRecord(type: WalletRecordTypeEnum, uuid: String) -> Future<Int, Error> {
        Future { promise in
            self.logger.info(message: "deleting record in wallet")
            self.vcx.deleteRecordWallet(
                    type.value,
                    recordId: uuid) { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on deleting record in wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "deleted record in wallet sucessfully")
                promise(.success(0))
            }
        }
    }
}
