/**
 * @File Name          : CalloutMock.cls
 * @Description        : 
 * @Author             : aniubo
 * @Group              : 
 * @Last Modified By   : aniubo
 * @Last Modified On   : 4/17/2023, 4:29:38 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    4/17/2023, 4:27:46 PM   aniubo     Initial Version
**/
@isTest 
global class CalloutMock implements HttpCalloutMock {
	private Integer statusCode;
	private String status;
	private object body;
	private Map<String, String> responseHeaders;
	private Map<String, String> responseMap;

	/**
	 * Constructor
	 */
	public CalloutMock(
		Integer code,
		object body,
		String status,
		Map<String, String> responseHeaders,
		Map<String, String> responseMap
	) {
		this.statusCode = code;
		this.status = status;
		this.body = body;
		this.responseHeaders = responseHeaders;
		this.responseMap = responseMap;
	}

	/**
	 * Callout response method
	 */
	/**
	 * Callout response method
	 */
	global HTTPResponse respond(HTTPRequest req) {
		String hrBody = null;
		String endPoint = req.getEndpoint();
		if (!responseMap.isEmpty()) {
			for (String key : responseMap.keySet()) {
				if (hrBody != null) {
					continue;
				}
				if (endPoint.containsIgnoreCase(key)) {
					hrBody = responseMap.get(key);
					break;
				}
			}
		}
		// Create the response from class properties
		HttpResponse res = new HttpResponse();
		res.setStatusCode(statusCode);
		res.setStatus(status);
		res.setBody(hrBody == null ? (String) body : hrBody);

		if (responseHeaders != null) {
			for (String key : responseHeaders.keySet()) {
				res.setHeader(key, responseHeaders.get(key));
			}
		}

		return res;
	}
}