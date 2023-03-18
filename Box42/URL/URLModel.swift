//
//  URLModel.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation

struct URLModel {
	let URLdict: [String: URL] = [
		"home": URL(string: "http://localhost:4242/")!,
		"Box 42": URL(string: "http://localhost:4242/")!,
		"Intra 42": URL(string: "https://intra.42.fr")!,
		"Jiphyeonjeon" : URL(string:"https://42library.kr")!,
		"24Hane": URL(string:"https://24hoursarenotenough.42seoul.kr")!,
		"80000Coding": URL(string:"https://80000coding.oopy.io")!,
		"where42": URL(string:"https://www.where42.kr")!,
		"E-Library": URL(string:"https://42seoul.dkyobobook.co.kr/main.ink")!,
		"42gg": URL(string:"https://42gg.kr/")!,
	]
	
	let URLstring: [(String, String)] = [
		("home", "http://localhost:4242/"),
		("Box 42", "http://localhost:4242/"),
		("Intra 42", "https://intra.42.fr"),
		("Jiphyeonjeon", "https://42library.kr"),
		("24Hane", "https://24hoursarenotenough.42seoul.kr"),
		("80000Coding", "https://80000coding.oopy.io"),
		("where42", "https://www.where42.kr"),
		("E-Library", "https://42seoul.dkyobobook.co.kr/main.ink"),
		("42gg", "https://42gg.kr/")
		]
}
