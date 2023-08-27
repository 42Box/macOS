//
//  URLModel.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation

typealias nameUrl = (name: String, url: String)

struct URLModel {
    var id: UUID
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.id = UUID()
        self.name = name
        self.url = url
    }
}

struct UserDataA: Codable {
    var uuid: String
    var nickname: String
    var theme: Int
    var icon: String
    var urlList: [_URLModel]
    var profileImage: String
}

struct _URLModel: Codable {
    var name: String
    var url: String
}

struct URLModels {
    var info: [URLModel]
    let strData = """
    {
      \"uuid\":\"8a8b9d71-3c10-4cbc-8b3a-ae1b5c215f40\",
      \"nickname\":\"sechung\",
      \"theme\":0,
      \"icon\":\"fox\",
      \"urlList\":[
        {\"name\":\"home\",\"url\":\"https://42box.kr/\"},
        {\"name\":\"23Coaltheme\",\"url\":\"https://42box.github.io/front-end/\"},
        {\"name\":\"loopback\",\"url\":\"http://127.0.0.1:3000/\"},
        {\"name\":\"Box42\",\"url\":\"https://42box.github.io/front-end/#/box\"},
        {\"name\":\"Intra 42\",\"url\":\"https://intra.42.fr\"},
        {\"name\":\"Jiphyeonjeon\",\"url\":\"https://42library.kr\"},
        {\"name\":\"42STAT\",\"url\":\"https://stat.42seoul.kr/home\"},
        {\"name\":\"24Hane\",\"url\":\"https://24hoursarenotenough.42seoul.kr\"},
        {\"name\":\"80kCoding\",\"url\":\"https://80000coding.oopy.io\"},
        {\"name\":\"where42\",\"url\":\"https://www.where42.kr\"},
        {\"name\":\"cabi\",\"url\":\"https://cabi.42seoul.io/\"},
        {\"name\":\"42gg\",\"url\":\"https://42gg.kr/\"}
      ],
      \"profileImage\":\"dummy-images.png\"
    }
    """
    // Network logic api call 날려서 받아올 것.
    let URLstring: [nameUrl] = [
        ("home", "https://42box.kr/"),
        ("23Coaltheme", "https://42box.github.io/front-end/"),
        ("Box 42", "https://42box.github.io/front-end/#/box"),
        ("Intra 42", "https://intra.42.fr"),
        ("Jiphyeonjeon", "https://42library.kr"),
        ("42STAT", "https://stat.42seoul.kr/home"),
        ("24Hane", "https://24hoursarenotenough.42seoul.kr"),
        ("80kCoding", "https://80000coding.oopy.io"),
        ("where42", "https://www.where42.kr"),
        ("cabi", "https://cabi.42seoul.io/"),
        ("42gg", "https://42gg.kr/"),
        ("textart", "https://textart.sh/"),
    ]
    
    
//    let a = URLModel(name: "name", url: "url")
//    var m = URLModels(info: [a])
//    var strData = m.strData
//    var dicData : Dictionary<String, Any> = [String: String]()
//    do {
//        dicData = try JSONSerialization.jsonObject(with: Data(strData.utf8), options: []) as! Dictionary<String, Any>
//    } catch {
//        print(error.localizedDescription)
//    }
//    print(dicData["home"])
//    print(dicData)
//
//
//    let jsonData = Data(strData.utf8)
//    do {
//        let userData = try JSONDecoder().decode(UserDataA.self, from: jsonData)
//        for urlModel in userData.urlList {
//            print(urlModel.name, urlModel.url)
//        }
//
//
//        if let homeURLModel = userData.urlList.first(where: { $0.name == "home" }) {
//            print(homeURLModel.url)
//        }
//    } catch {
//        print(error.localizedDescription)
//    }
}
