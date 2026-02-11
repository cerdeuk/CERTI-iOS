//
//  Region.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/5/26.
//

import Foundation

enum Region: String, CaseIterable, Codable {
    case seoul = "서울특별시"
    case busan = "부산광역시"
    case daegu = "대구광역시"
    case incheon = "인천광역시"
    case gwangju = "광주광역시"
    case daejeon = "대전광역시"
    case ulsan = "울산광역시"
    case sejong = "세종특별자치시"
    case gyeonggi = "경기도"
    case gangwon = "강원특별자치도"
    case chungbuk = "충청북도"
    case chungnam = "충청남도"
    case jeonbuk = "전라북도"
    case jeonnam = "전라남도"
    case gyeongbuk = "경상북도"
    case gyeongnam = "경상남도"
    case jeju = "제주특별자치도"

    var districts: [String] {
        switch self {
        case .seoul: return Seoul.allCases.map(\.rawValue)
        case .busan: return Busan.allCases.map(\.rawValue)
        case .daegu: return Daegu.allCases.map(\.rawValue)
        case .incheon: return Incheon.allCases.map(\.rawValue)
        case .gwangju: return Gwangju.allCases.map(\.rawValue)
        case .daejeon: return Daejeon.allCases.map(\.rawValue)
        case .ulsan: return Ulsan.allCases.map(\.rawValue)
        case .sejong: return Sejong.allCases.map(\.rawValue)
        case .gyeonggi: return Gyeonggi.allCases.map(\.rawValue)
        case .gangwon: return Gangwon.allCases.map(\.rawValue)
        case .chungbuk: return Chungbuk.allCases.map(\.rawValue)
        case .chungnam: return Chungnam.allCases.map(\.rawValue)
        case .jeonbuk: return Jeonbuk.allCases.map(\.rawValue)
        case .jeonnam: return Jeonnam.allCases.map(\.rawValue)
        case .gyeongbuk: return Gyeongbuk.allCases.map(\.rawValue)
        case .gyeongnam: return Gyeongnam.allCases.map(\.rawValue)
        case .jeju: return Jeju.allCases.map(\.rawValue)
        }
    }

    enum Seoul: String, CaseIterable, Codable {
        case jongno = "종로구"
        case jung = "중구"
        case yongsan = "용산구"
        case seongdong = "성동구"
        case gwangjin = "광진구"
        case dongdaemun = "동대문구"
        case jungnang = "중랑구"
        case seongbuk = "성북구"
        case gangbuk = "강북구"
        case dobong = "도봉구"
        case nowon = "노원구"
        case eunpyeong = "은평구"
        case seodaemun = "서대문구"
        case mapo = "마포구"
        case yangcheon = "양천구"
        case gangseo = "강서구"
        case guro = "구로구"
        case geumcheon = "금천구"
        case yeongdeungpo = "영등포구"
        case dongjak = "동작구"
        case gwanak = "관악구"
        case seocho = "서초구"
        case gangnam = "강남구"
        case songpa = "송파구"
        case gangdong = "강동구"
    }

    enum Busan: String, CaseIterable, Codable {
        case jung = "중구"
        case seo = "서구"
        case dong = "동구"
        case yeongdo = "영도구"
        case busanjin = "부산진구"
        case dongnae = "동래구"
        case nam = "남구"
        case buk = "북구"
        case haeundae = "해운대구"
        case saha = "사하구"
        case geumjeong = "금정구"
        case gangseo = "강서구"
        case yeonje = "연제구"
        case suyeong = "수영구"
        case sasang = "사상구"
        case gijang = "기장군"
    }

    enum Daegu: String, CaseIterable, Codable {
        case jung = "중구"
        case dong = "동구"
        case seo = "서구"
        case nam = "남구"
        case buk = "북구"
        case suseong = "수성구"
        case dalseo = "달서구"
        case dalseong = "달성군"
    }

    enum Incheon: String, CaseIterable, Codable {
        case jung = "중구"
        case dong = "동구"
        case michuhol = "미추홀구"
        case yeonsu = "연수구"
        case namdong = "남동구"
        case bupyeong = "부평구"
        case gyeyang = "계양구"
        case seo = "서구"
        case ganghwa = "강화군"
        case ongjin = "옹진군"
    }

    enum Gwangju: String, CaseIterable, Codable {
        case dong = "동구"
        case seo = "서구"
        case nam = "남구"
        case buk = "북구"
        case gwangsan = "광산구"
    }

    enum Daejeon: String, CaseIterable, Codable {
        case dong = "동구"
        case jung = "중구"
        case seo = "서구"
        case yuseong = "유성구"
        case daedeok = "대덕구"
    }

    enum Ulsan: String, CaseIterable, Codable {
        case jung = "중구"
        case nam = "남구"
        case dong = "동구"
        case buk = "북구"
        case ulju = "울주군"
    }

    enum Sejong: String, CaseIterable, Codable {
        case sejong = "세종시"
    }

    enum Gyeonggi: String, CaseIterable, Codable {
        case suwon = "수원시"
        case seongnam = "성남시"
        case uijeongbu = "의정부시"
        case anyang = "안양시"
        case bucheon = "부천시"
        case gwangmyeong = "광명시"
        case pyeongtaek = "평택시"
        case dongducheon = "동두천시"
        case ansan = "안산시"
        case goyang = "고양시"
        case gwacheon = "과천시"
        case guri = "구리시"
        case namyangju = "남양주시"
        case osan = "오산시"
        case siheung = "시흥시"
        case gunpo = "군포시"
        case uiwang = "의왕시"
        case hanam = "하남시"
        case yongin = "용인시"
        case paju = "파주시"
        case icheon = "이천시"
        case anseong = "안성시"
        case gimpo = "김포시"
        case hwaseong = "화성시"
        case gwangju = "광주시"
        case yangju = "양주시"
        case pocheon = "포천시"
        case yeoju = "여주시"
        case yeoncheon = "연천군"
        case gapyeong = "가평군"
        case yangpyeong = "양평군"
    }

    enum Gangwon: String, CaseIterable, Codable {
        case chuncheon = "춘천시"
        case wonju = "원주시"
        case gangneung = "강릉시"
        case donghae = "동해시"
        case taebaek = "태백시"
        case sokcho = "속초시"
        case samcheok = "삼척시"
        case hongcheon = "홍천군"
        case hoengseong = "횡성군"
        case yeongwol = "영월군"
        case pyeongchang = "평창군"
        case jeongseon = "정선군"
        case cheorwon = "철원군"
        case hwacheon = "화천군"
        case yanggu = "양구군"
        case inje = "인제군"
        case goseong = "고성군"
        case yangyang = "양양군"
    }

    enum Chungbuk: String, CaseIterable, Codable {
        case cheongju = "청주시"
        case chungju = "충주시"
        case jecheon = "제천시"
        case boeun = "보은군"
        case okcheon = "옥천군"
        case yeongdong = "영동군"
        case jeungpyeong = "증평군"
        case jincheon = "진천군"
        case goesan = "괴산군"
        case eumsung = "음성군"
        case danyang = "단양군"
    }

    enum Chungnam: String, CaseIterable, Codable {
        case cheonan = "천안시"
        case gongju = "공주시"
        case boryeong = "보령시"
        case asan = "아산시"
        case seosan = "서산시"
        case nonsan = "논산시"
        case gyeryong = "계룡시"
        case dangjin = "당진시"
        case geumsan = "금산군"
        case buyeo = "부여군"
        case seocheon = "서천군"
        case cheongyang = "청양군"
        case hongseong = "홍성군"
        case yesan = "예산군"
        case taean = "태안군"
    }

    enum Jeonbuk: String, CaseIterable, Codable {
        case jeonju = "전주시"
        case gunsan = "군산시"
        case iksan = "익산시"
        case jeongeup = "정읍시"
        case namwon = "남원시"
        case gimje = "김제시"
        case wanju = "완주군"
        case jinan = "진안군"
        case muju = "무주군"
        case jangsu = "장수군"
        case imsil = "임실군"
        case sunchang = "순창군"
        case gochang = "고창군"
        case buan = "부안군"
    }

    enum Jeonnam: String, CaseIterable, Codable {
        case mokpo = "목포시"
        case yeosu = "여수시"
        case suncheon = "순천시"
        case naju = "나주시"
        case gwangyang = "광양시"
        case damyang = "담양군"
        case gokseong = "곡성군"
        case gurye = "구례군"
        case goheung = "고흥군"
        case boseong = "보성군"
        case hwasun = "화순군"
        case jangheung = "장흥군"
        case gangjin = "강진군"
        case haenam = "해남군"
        case yeongam = "영암군"
        case muan = "무안군"
        case hampyeong = "함평군"
        case yeonggwang = "영광군"
        case jangseong = "장성군"
        case wando = "완도군"
        case jindo = "진도군"
        case sinan = "신안군"
    }

    enum Gyeongbuk: String, CaseIterable, Codable {
        case pohang = "포항시"
        case gyeongju = "경주시"
        case gimcheon = "김천시"
        case andong = "안동시"
        case gumi = "구미시"
        case yeongju = "영주시"
        case yeongcheon = "영천시"
        case sangju = "상주시"
        case mungyeong = "문경시"
        case gyeongsan = "경산시"
        case gunwi = "군위군"
        case uiseong = "의성군"
        case cheongsong = "청송군"
        case yeongyang = "영양군"
        case yeongdeok = "영덕군"
        case cheongdo = "청도군"
        case goryeong = "고령군"
        case seongju = "성주군"
        case chilgok = "칠곡군"
        case yecheon = "예천군"
        case bonghwa = "봉화군"
        case uljin = "울진군"
        case ulleung = "울릉군"
    }

    enum Gyeongnam: String, CaseIterable, Codable {
        case changwon = "창원시"
        case jinju = "진주시"
        case tongyeong = "통영시"
        case sacheon = "사천시"
        case gimhae = "김해시"
        case miryang = "밀양시"
        case geoje = "거제시"
        case yangsan = "양산시"
        case uiryeong = "의령군"
        case haman = "함안군"
        case changnyeong = "창녕군"
        case goseong = "고성군"
        case namhae = "남해군"
        case hadong = "하동군"
        case sancheong = "산청군"
        case hamyang = "함양군"
        case geochang = "거창군"
        case hapcheon = "합천군"
    }

    enum Jeju: String, CaseIterable, Codable {
        case jeju = "제주시"
        case seogwipo = "서귀포시"
    }
}
