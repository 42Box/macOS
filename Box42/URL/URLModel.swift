//
//  URLModel.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation

struct URLModel {
	let URLdict: [String: URL] = [
		"home": URL(string: "https://42box.github.io/front-end/")!,
		"Box 42": URL(string: "https://42box.github.io/front-end/#/box")!,
		"Intra 42": URL(string: "https://intra.42.fr")!,
		"Jiphyeonjeon" : URL(string:"https://42library.kr")!,
		"E-Library": URL(string:"https://42seoul.dkyobobook.co.kr/main.ink")!,
		"24Hane": URL(string:"https://24hoursarenotenough.42seoul.kr")!,
		"80000Coding": URL(string:"https://80000coding.oopy.io")!,
		"where42": URL(string:"https://www.where42.kr")!,
		"cabi": URL(string:"https://cabi.42seoul.io/")!,
		"42gg": URL(string:"https://42gg.kr/")!,
	]
	
	let URLstring: [(String, String)] = [
		("home", "https://42box.github.io/front-end/"),
		("Box 42", "https://42box.github.io/front-end/#/box"),
		("Intra 42", "https://intra.42.fr"),
		("Jiphyeonjeon", "https://42library.kr"),
		("E-Library", "https://42seoul.dkyobobook.co.kr/main.ink"),
		("24Hane", "https://24hoursarenotenough.42seoul.kr"),
		("80000Coding", "https://80000coding.oopy.io"),
		("where42", "https://www.where42.kr"),
		("cabi", "https://cabi.42seoul.io/"),
		("42gg", "https://42gg.kr/"),
		]
}
