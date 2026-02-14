//
//  UserService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

import Moya

protocol UserServiceProtocol {
    func getuserInfo() async -> Result<UserInfoResponseDTO, NetworkError>
    func checkNickName(nickname: String) async -> Result<BaseResponseDTO<EmptyData>, NetworkError>
    func getMyPageInfo() async -> Result<MyPageResponseDTO, NetworkError>
    func getEditProfileInfo() async -> Result<EditProfileResponseDTO, NetworkError>
    func putEditProfileInfo(profileInfo: EditProfileRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError>
    func getSearchUniv(keyword: String) async -> Result<UnivListResponseDTO, NetworkError>
    func getSearchMajor(keyword: String) async -> Result<MajorListResponseDTO, NetworkError>
    func editUniv(request: EditUnivRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError>
    func editMajor(request: EditMajorRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError>
    func getNotificationSetting() async -> Result<NotificationSettingResponseDTO, NetworkError>
    func toggleMarketingSetting(agree: EditNotificationSettingRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError>
    func togglePrivacySetting(agree: EditNotificationSettingRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError>
    func getTrack() async -> Result<TrackResponseDTO, NetworkError>

}

final class UserService: BaseService, UserServiceProtocol {
    
    private let provider = MoyaProvider<UserAPI>.init(plugins: [MoyaPlugin()])

    func getuserInfo() async -> Result<UserInfoResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getUserInfo)
    }
    
    func checkNickName(nickname: String) async -> Result<BaseResponseDTO<EmptyData>, NetworkError> {
        return await requestDecodable(provider, .checkNickname(nickname: nickname))
    }
    
    func getMyPageInfo() async -> Result<MyPageResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getMyPageInfo)
    }
    
    func getEditProfileInfo() async -> Result<EditProfileResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getEditProfileInfo)
    }
    
    func putEditProfileInfo(profileInfo: EditProfileRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError> {
        return await requestDecodable(provider, .putEditProfileInfo(request: profileInfo))
    }
    
    func getSearchUniv(keyword: String) async -> Result<UnivListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .searchUniv(keyword: keyword))
    }
    
    func getSearchMajor(keyword: String) async -> Result<MajorListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .searchMajor(keyword: keyword))
    }
    
    func editUniv(request: EditUnivRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError> {
        return await requestDecodable(provider, .editUniv(request: request))
    }
    
    func editMajor(request: EditMajorRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError> {
        return await requestDecodable(provider, .editMajor(request: request))
    }
    
    func getNotificationSetting() async -> Result<NotificationSettingResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getNotificationSetting)
    }
    
    func toggleMarketingSetting(agree: EditNotificationSettingRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError> {
        return await requestDecodable(provider, .toggleMarketingSetting(agree: agree))
    }
    
    func togglePrivacySetting(agree: EditNotificationSettingRequestDTO) async -> Result<BaseResponseDTO<EmptyData>, NetworkError> {
        return await requestDecodable(provider, .togglePrivacySetting(agree: agree))
    }
    
    func getTrack() async -> Result<TrackResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getTrack)
    }
}
