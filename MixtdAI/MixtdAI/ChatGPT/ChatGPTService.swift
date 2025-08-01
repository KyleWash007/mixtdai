//
//  ChatGPTService.swift
//  LLM
//
//  Created by Aravind Kumar on 10/02/25.
//

import Foundation
import UIKit

// MARK: - ChatGPT API Service
class ChatGPTService {
    private let apiUrl = "https://api.openai.com/v1/chat/completions"

    func sendMessage(_ text: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: apiUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": text]],
            "max_tokens": 1000,
            "temperature": 0.7
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        request.timeoutInterval =  120
        URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data, error == nil else {
                completion("")
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {
                DispatchQueue.main.async {
                    completion(self.removeSpecificCharacters(from: content))
                }
            }
        }.resume()
    }

    func removeSpecificCharacters(from string: String) -> String {
        let pattern = "[~!@#$%^&*()]"
        return string.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
    }

    func generateMixAIResponse(ingredient1: String, ingredient2: String, completion: @escaping (Result<MixAIResponse, Error>) -> Void) {
        let prompt = """
        I am building a cocktail AI assistant. I will provide two mix ingredients.Each key must contain at least 240 words of detailed and meaningful information.For each mix, generate a JSON object with the following six keys and creative responses:

        1. experience — A short, valid description of what someone will experience when tasting the mix.
        2. science — A simplified explanation of the flavor chemistry or interaction between the ingredients.
        3. similarTo — Mention what this mix is similar to (another cocktail or experience).
        4. Recommended Ratio — Recommend what is the optimal mixture ratio for the best flavor of this mixture..
        5. suggestedName — Suggest a creative, unique name for the mix.
        6. improvementTip — Suggest one smart improvement to enhance the mix further.

        Input: { \"ingredient1\": \"\(ingredient1)\", \"ingredient2\": \"\(ingredient2)\" }

        Respond ONLY in this JSON format:
        {
          "experience": "...",
          "science": "...",
          "similarTo": "...",
          "recommendedRatio": "...",
          "suggestedName": "...",
          "improvementTip": "..."
        }
        """

        let messages: [[String: String]] = [
            ["role": "system", "content": "You are an expert cocktail mixologist AI."],
            ["role": "user", "content": prompt]
        ]

        let requestBody: [String: Any] = [
            "model": "gpt-4",
            "messages": messages,
            "temperature": 0.8
        ]

        sendRequest(url: apiUrl, body: requestBody, completion: completion)
    }

    private func sendRequest<T: Decodable>(url: String, body: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 120

        do {
            let data = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = data

            let task = URLSession.shared.dataTask(with: request) { data, response, error in

                if let data = data,
                   let str = String(data: data, encoding: .utf8) {
                    print("Server Response:\n" + str)
                }

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "No Data", code: 0)))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(ChatCompletionResponse.self, from: data)
                    if let content = decoded.choices.first?.message.content {
                        let cleanedContent = content
                            .replacingOccurrences(of: "```json", with: "")
                            .replacingOccurrences(of: "```", with: "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        if let contentData = cleanedContent.data(using: .utf8) {
                            let result = try JSONDecoder().decode(T.self, from: contentData)
                            completion(.success(result))
                        } else {
                            completion(.failure(NSError(domain: "Failed to encode cleaned content", code: 0)))
                        }
                    } else {
                        completion(.failure(NSError(domain: "Invalid Content", code: 0)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    func generateImageURL(from prompt: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/images/generations")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(self.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "dall-e-3",
            "prompt": prompt,
            "n": 1,
            "size": "1024x1024"
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataArray = json["data"] as? [[String: Any]],
                  let first = dataArray.first,
                  let urlString = first["url"] as? String,
                  let imageURL = URL(string: urlString) else {
                completion(.failure(NSError(domain: "ImageParse", code: 0)))
                return
            }

            completion(.success(imageURL))
        }.resume()
    }

}

// MARK: - Models
struct ChatCompletionResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: MessageSim
}

struct MessageSim: Codable {
    let role: String
    let content: String
}

class MixAIResponse: Codable {
    let experience: String
    let science: String
    let similarTo: String
    let recommendedRatio: String
    var suggestedName: String
    let improvementTip: String
    var leftIngredient:String?
    var rightIngredient:String?

}
