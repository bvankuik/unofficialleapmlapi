import XCTest
@testable import LeapML
import Swifter
import OSLog

final class LeapMLTests: XCTestCase {
    private let testServer = HttpServer()
    private static let testServerPort = 9081
    private static let testServerListInferencePath = "/api/inferences"
    
    private lazy var configuration: LeapML.Configuration = {
        LeapML.Configuration(scheme: "http", host: "localhost", port: Self.testServerPort, modelID: "unittest", path: Self.testServerListInferencePath, apiKey: "unittest")
    }()
    
    override func setUpWithError() throws {
        let listInferenceData = try! Data(contentsOf: Bundle.module.url(forResource: "ListInferenceJobs", withExtension: "json")!)
        let generateImageData = try! Data(contentsOf: Bundle.module.url(forResource: "GenerateImage", withExtension: "json")!)

        testServer[Self.testServerListInferencePath] = { request in
            switch request.method {
            case "POST":
                return .ok(
                    .data(
                        generateImageData,
                        contentType: "application/json"
                    )
                )
            case "GET":
                return .ok(
                    .data(
                        listInferenceData,
                        contentType: "application/json"
                    )
                )
            default:
                XCTFail("Unexpected method \(request.method)")
                return .internalServerError
            }
        }

        do {
            let port: UInt16 = UInt16(clamping: Self.testServerPort)
            XCTAssert(port == Self.testServerPort)
            try testServer.start(port)
            os_log("Server has started")
        } catch {
            os_log("Server start error: \(error)")
        }
    }
    
    override func tearDownWithError() throws {
        testServer.stop()
        os_log("Server has stopped")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LeapML().text, "Unofficial Swift package for accessing the LeapML API")
    }
    
    func testGenerateImageService() async throws {
        let prompt = "cat with six legs"
        let requestBody = GenerateImageService.RequestBody(
            prompt: prompt,
            negativePrompt: "asymmetric, watermarks",
            version: nil,
            steps: 50,
            width: 512,
            height: 512,
            numberOfImages: 1,
            promptStrength: 7,
            webhookUrl: nil)
        
        let inference = try await GenerateImageService.call(requestBody: requestBody, configuration: self.configuration)
        XCTAssert(inference.prompt == prompt)
    }
    
    func testListInferenceService() async throws {
        let inferenceJobs = try await ListInferenceService.call(configuration: self.configuration)
        XCTAssert(!inferenceJobs.isEmpty)
    }
}
