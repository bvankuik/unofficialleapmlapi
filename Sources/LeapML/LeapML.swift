import Foundation

public struct LeapML {
    public private(set) var text = "Unofficial Swift package for accessing the LeapML API"
    
    public init() {
    }
}

extension LeapML {
    public struct Configuration {
        let scheme: String
        let host: String
        let port: Int?
        let modelID: String
        let path: String
        let apiKey: String
        
        public static let standard: Configuration = {
            let modelID = "8b1b897c-d66d-45a6-b8d7-8e32421d02cf"
            let path = "/api/v1/images/models/\(modelID)/inferences"
            
            guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
                fatalError("API key not found")
            }

            return Configuration(scheme: "https", host: "api.leapml.dev", port: nil, modelID: modelID, path: path, apiKey: apiKey)
        }()
    }
}
