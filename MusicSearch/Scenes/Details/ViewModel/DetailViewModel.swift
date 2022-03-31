//
//  DetailViewModel.swift
//  MusicSearch
//
//  Created by Vinsi on 31/03/2022.
//

import Combine
import Foundation

private extension Int {

    var toTime: String {
        let secs = self % 60
        let mins = self / 60
        return String(format: "%02d:%02d", mins, secs)
    }
}

final class DetailViewModel {

    var repo: AlbumRepositoryType = AlbumRepository()
    var cells: CurrentValueSubject<[CellConfigurable], Never> = .init([])
    var errorMessage: PassthroughSubject<String, Never> = .init()
    let loader: CurrentValueSubject<Bool, Never> = .init(false)
    var search: SearchType?
    let cancelBag = CancelBag()
    let errorMessageNoData = "No Album found"
    func fetch() {
        let params = """
"fetch started..with-
 \(search?.album ?? "")
 \(search?.artist ?? "")
 \(search?.mbd ?? "" )
"""
        Logger(.detail).log(params)
        repo.info(album: search?.album, artist: search?.artist, mbid: search?.mbd)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                Logger(.detail).log("fetch completed")
                switch $0 {
                case .failure(let error):
                    Logger(.detail).log(type: .failure, error.localizedDescription)
                    self?.errorMessage.send(self?.errorMessageNoData ?? "")
                default:
                    break
                }
            } receiveValue: { [weak self] in
                let avatar = AvatarModel(image: $0.album?.image?.first?.text)
                if let tracks = $0.album?.tracks?.track?.compactMap({
                    TrackCellModel(artist: $0.artist?.name,
                                   duration: $0.duration?.toTime,
                                   name: $0.name)
                }) {
                    self?.cells.value = [avatar] + tracks
                }
                if let self = self,
                   self.cells.value.isEmpty == true {
                    self.errorMessage.send(self.errorMessageNoData)
                }
                Logger(.detail).log("fetched:-\(self?.cells.value.count ?? 0) cells")
            }.store(in: cancelBag)
    }
}
