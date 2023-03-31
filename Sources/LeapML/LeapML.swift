public struct LeapML {
    public private(set) var text = "Unofficial Swift package for accessing the LeapML API"
    
    public init() {
    }
}

extension LeapML {
    public struct Configuration {
        let scheme: String
        let host: String
        let modelID: String
        let path: String
        
        public static let standard: Configuration = {
            let modelID = "8b1b897c-d66d-45a6-b8d7-8e32421d02cf"
            let path = "/api/v1/images/models/\(modelID)/inferences"
            return Configuration(scheme: "https", host: "api.leapml.dev", modelID: modelID, path: path)
        }()
    }
}
