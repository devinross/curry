//
//  TKProgressDataTask.swift
//  Created by Devin Ross on 5/2/17.
//
/*

curry || https://github.com/devinross/curry

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

*/

import Foundation


/// `NSJSONSerialization` reports a malformed payload with this code.
private let jsonCorruptErrorCode = 3840


/** A data task that reports download and upload progress as it runs. */
public final class TKProgressDataTask: NSObject, URLSessionDataDelegate {
	
	/// Called with the bytes transferred so far and the total expected.
	public typealias ProgressHandler = (Double, Double) -> Void
	/// Called once the task finishes, with `Data` or a decoded JSON object.
	public typealias CompletionHandler = (Any?, URLResponse?, Error?) -> Void
	
	@objc public var expectedData: Double = 0
	@objc public var loadedData: Double = 0
	
	@objc public var completionHandler: CompletionHandler?
	@objc public var progressHandler: ProgressHandler?
	@objc public var uploadProgressHandler: ProgressHandler?
	
	private var task: URLSessionDataTask?
	private var session: URLSession?
	private var data: NSMutableData? = NSMutableData()
	private var shouldProcessJSON = false
	
	
	// MARK: - Init
	
	private init(progressHandler: ProgressHandler?,
	             uploadProgressHandler: ProgressHandler?,
	             completionHandler: CompletionHandler?,
	             processJSON: Bool,
	             makeTask: (URLSession) -> URLSessionDataTask) {
		
		super.init()
		
		self.shouldProcessJSON = processJSON
		self.progressHandler = progressHandler
		self.uploadProgressHandler = uploadProgressHandler
		self.completionHandler = completionHandler
		
		let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
		self.session = session
		self.task = makeTask(session)
	}
	
	deinit {
		session?.finishTasksAndInvalidate()
	}
	
	/// Wraps a `Data`-typed completion handler as the stored `Any?` one.
	private static func wrap(_ completion: ((Data?, URLResponse?, Error?) -> Void)?) -> CompletionHandler? {
		guard let completion else { return nil }
		return { object, response, error in completion(object as? Data, response, error) }
	}
	
	
	// MARK: - URL
	
	@objc(progressDataTaskWithURL:progressHandler:completionHandler:)
	public static func progressDataTask(with url: URL,
	                                    progressHandler: ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		progressDataTask(with: url, progressHandler: progressHandler, uploadProgressHandler: nil, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithURL:uploadProgressHandler:completionHandler:)
	public static func progressDataTask(with url: URL,
	                                    uploadProgressHandler: ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		progressDataTask(with: url, progressHandler: nil, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithURL:progressHandler:uploadProgressHandler:completionHandler:)
	public static func progressDataTask(with url: URL,
	                                    progressHandler: ProgressHandler?,
	                                    uploadProgressHandler: ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		TKProgressDataTask(progressHandler: progressHandler,
		                   uploadProgressHandler: uploadProgressHandler,
		                   completionHandler: wrap(completionHandler),
		                   processJSON: false) { $0.dataTask(with: url) }
	}
	
	
	// MARK: - Request
	
	@objc(progressDataTaskWithRequest:progressHandler:completionHandler:)
	public static func progressDataTask(with request: URLRequest,
	                                    progressHandler: ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		progressDataTask(with: request, progressHandler: progressHandler, uploadProgressHandler: nil, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithRequest:uploadProgressHandler:completionHandler:)
	public static func progressDataTask(with request: URLRequest,
	                                    uploadProgressHandler: ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		progressDataTask(with: request, progressHandler: nil, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithRequest:progressHandler:uploadProgressHandler:completionHandler:)
	public static func progressDataTask(with request: URLRequest,
	                                    progressHandler: ProgressHandler?,
	                                    uploadProgressHandler: ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		TKProgressDataTask(progressHandler: progressHandler,
		                   uploadProgressHandler: uploadProgressHandler,
		                   completionHandler: wrap(completionHandler),
		                   processJSON: false) { $0.dataTask(with: request) }
	}
	
	
	// MARK: - JSON URL
	
	@objc(progressJSONDataTaskWithURL:progressHandler:completionHandler:)
	public static func progressJSONDataTask(with url: URL,
	                                        progressHandler: ProgressHandler?,
	                                        completionHandler: CompletionHandler?) -> TKProgressDataTask {
		progressJSONDataTask(with: url, progressHandler: progressHandler, uploadProgressHandler: nil, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithURL:uploadProgressHandler:completionHandler:)
	public static func progressJSONDataTask(with url: URL,
	                                        uploadProgressHandler: ProgressHandler?,
	                                        completionHandler: CompletionHandler?) -> TKProgressDataTask {
		progressJSONDataTask(with: url, progressHandler: nil, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithURL:progressHandler:uploadProgressHandler:completionHandler:)
	public static func progressJSONDataTask(with url: URL,
	                                        progressHandler: ProgressHandler?,
	                                        uploadProgressHandler: ProgressHandler?,
	                                        completionHandler: CompletionHandler?) -> TKProgressDataTask {
		TKProgressDataTask(progressHandler: progressHandler,
		                   uploadProgressHandler: uploadProgressHandler,
		                   completionHandler: completionHandler,
		                   processJSON: true) { $0.dataTask(with: url) }
	}
	
	
	// MARK: - JSON Request
	
	@objc(progressJSONDataTaskWithRequest:progressHandler:completionHandler:)
	public static func progressJSONDataTask(with request: URLRequest,
	                                        progressHandler: ProgressHandler?,
	                                        completionHandler: CompletionHandler?) -> TKProgressDataTask {
		progressJSONDataTask(with: request, progressHandler: progressHandler, uploadProgressHandler: nil, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithRequest:uploadProgressHandler:completionHandler:)
	public static func progressJSONDataTask(with request: URLRequest,
	                                        uploadProgressHandler: ProgressHandler?,
	                                        completionHandler: CompletionHandler?) -> TKProgressDataTask {
		progressJSONDataTask(with: request, progressHandler: nil, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithRequest:progressHandler:uploadProgressHandler:completionHandler:)
	public static func progressJSONDataTask(with request: URLRequest,
	                                        progressHandler: ProgressHandler?,
	                                        uploadProgressHandler: ProgressHandler?,
	                                        completionHandler: CompletionHandler?) -> TKProgressDataTask {
		TKProgressDataTask(progressHandler: progressHandler,
		                   uploadProgressHandler: uploadProgressHandler,
		                   completionHandler: completionHandler,
		                   processJSON: true) { $0.dataTask(with: request) }
	}
	
	
	// MARK: - Controlling the task
	
	@objc public func resume() {
		task?.resume()
	}
	
	@objc public func suspend() {
		task?.suspend()
	}
	
	@objc public func cancel() {
		task?.cancel()
		data = nil
	}
	
	@objc public var priority: Float {
		get { task?.priority ?? URLSessionTask.defaultPriority }
		set { task?.priority = newValue }
	}
	
	
	// MARK: - URLSessionDataDelegate
	
	public func urlSession(_ session: URLSession,
	                       task: URLSessionTask,
	                       didSendBodyData bytesSent: Int64,
	                       totalBytesSent: Int64,
	                       totalBytesExpectedToSend: Int64) {
		DispatchQueue.main.async {
			self.uploadProgressHandler?(Double(totalBytesSent), Double(totalBytesExpectedToSend))
		}
	}
	
	public func urlSession(_ session: URLSession,
	                       dataTask: URLSessionDataTask,
	                       didReceive response: URLResponse,
	                       completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
		completionHandler(.allow)
		expectedData = Double(response.expectedContentLength)
		DispatchQueue.main.async {
			self.progressHandler?(0, self.expectedData)
		}
	}
	
	public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
		self.data?.append(data)
		loadedData = Double(self.data?.length ?? 0)
		DispatchQueue.main.async {
			self.progressHandler?(self.loadedData, self.expectedData)
		}
	}
	
	public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
		
		DispatchQueue.main.async {
			
			guard let completion = self.completionHandler else { return }
			let body = self.data as Data?
			
			guard self.shouldProcessJSON else {
				completion(body, task.response, error)
				self.teardown()
				return
			}
			
			guard let body, !body.isEmpty else {
				completion(nil, task.response, error)
				self.teardown()
				return
			}
			
			self.processJSON(body, response: task.response, error: error, options: .allowFragments) { object, response, jsonError in
				
				// A body that is not JSON at all is still worth handing back as text.
				if (jsonError as? NSError)?.code == jsonCorruptErrorCode {
					completion(String(data: body, encoding: .utf8), response, jsonError)
				} else {
					completion(object, response, error)
				}
				
				self.teardown()
			}
		}
	}
	
	private func teardown() {
		data = nil
		progressHandler = nil
		completionHandler = nil
		task = nil
		session?.finishTasksAndInvalidate()
		session = nil
	}
	
}


/** Additional functionality for `URLSession` that creates progress reporting data tasks. */
extension URLSession {
	
	@objc(progressDataTaskWithURL:progressHandler:completionHandler:)
	open class func progressDataTask(with url: URL,
	                                    progressHandler: TKProgressDataTask.ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		TKProgressDataTask.progressDataTask(with: url, progressHandler: progressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithURL:uploadProgressHandler:completionHandler:)
	open class func progressDataTask(with url: URL,
	                                    uploadProgressHandler: TKProgressDataTask.ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		TKProgressDataTask.progressDataTask(with: url, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithURL:progressHandler:uploadProgressHandler:completionHandler:)
	open class func progressDataTask(with url: URL,
	                                    progressHandler: TKProgressDataTask.ProgressHandler?,
	                                    uploadProgressHandler: TKProgressDataTask.ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		TKProgressDataTask.progressDataTask(with: url, progressHandler: progressHandler, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithRequest:progressHandler:completionHandler:)
	open class func progressDataTask(with request: URLRequest,
	                                    progressHandler: TKProgressDataTask.ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		TKProgressDataTask.progressDataTask(with: request, progressHandler: progressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithRequest:uploadProgressHandler:completionHandler:)
	open class func progressDataTask(with request: URLRequest,
	                                    uploadProgressHandler: TKProgressDataTask.ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		TKProgressDataTask.progressDataTask(with: request, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressDataTaskWithRequest:progressHandler:uploadProgressHandler:completionHandler:)
	open class func progressDataTask(with request: URLRequest,
	                                    progressHandler: TKProgressDataTask.ProgressHandler?,
	                                    uploadProgressHandler: TKProgressDataTask.ProgressHandler?,
	                                    completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) -> TKProgressDataTask {
		TKProgressDataTask.progressDataTask(with: request, progressHandler: progressHandler, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithURL:progressHandler:completionHandler:)
	open class func progressJSONDataTask(with url: URL,
	                                        progressHandler: TKProgressDataTask.ProgressHandler?,
	                                        completionHandler: TKProgressDataTask.CompletionHandler?) -> TKProgressDataTask {
		TKProgressDataTask.progressJSONDataTask(with: url, progressHandler: progressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithURL:uploadProgressHandler:completionHandler:)
	open class func progressJSONDataTask(with url: URL,
	                                        uploadProgressHandler: TKProgressDataTask.ProgressHandler?,
	                                        completionHandler: TKProgressDataTask.CompletionHandler?) -> TKProgressDataTask {
		TKProgressDataTask.progressJSONDataTask(with: url, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithURL:progressHandler:uploadProgressHandler:completionHandler:)
	open class func progressJSONDataTask(with url: URL,
	                                        progressHandler: TKProgressDataTask.ProgressHandler?,
	                                        uploadProgressHandler: TKProgressDataTask.ProgressHandler?,
	                                        completionHandler: TKProgressDataTask.CompletionHandler?) -> TKProgressDataTask {
		TKProgressDataTask.progressJSONDataTask(with: url, progressHandler: progressHandler, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithRequest:progressHandler:completionHandler:)
	open class func progressJSONDataTask(with request: URLRequest,
	                                        progressHandler: TKProgressDataTask.ProgressHandler?,
	                                        completionHandler: TKProgressDataTask.CompletionHandler?) -> TKProgressDataTask {
		TKProgressDataTask.progressJSONDataTask(with: request, progressHandler: progressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithRequest:uploadProgressHandler:completionHandler:)
	open class func progressJSONDataTask(with request: URLRequest,
	                                        uploadProgressHandler: TKProgressDataTask.ProgressHandler?,
	                                        completionHandler: TKProgressDataTask.CompletionHandler?) -> TKProgressDataTask {
		TKProgressDataTask.progressJSONDataTask(with: request, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
	@objc(progressJSONDataTaskWithRequest:progressHandler:uploadProgressHandler:completionHandler:)
	open class func progressJSONDataTask(with request: URLRequest,
	                                        progressHandler: TKProgressDataTask.ProgressHandler?,
	                                        uploadProgressHandler: TKProgressDataTask.ProgressHandler?,
	                                        completionHandler: TKProgressDataTask.CompletionHandler?) -> TKProgressDataTask {
		TKProgressDataTask.progressJSONDataTask(with: request, progressHandler: progressHandler, uploadProgressHandler: uploadProgressHandler, completionHandler: completionHandler)
	}
	
}
