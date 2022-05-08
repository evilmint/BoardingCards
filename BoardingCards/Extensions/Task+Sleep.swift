import Foundation

extension Task where Failure == Never, Success == Never {
    static func sleep(milliseconds: UInt64) async throws {
        try await sleep(nanoseconds: milliseconds * 1_000_000)
    }
}
