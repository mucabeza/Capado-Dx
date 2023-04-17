/**
 * @File Name          : Callout.cls
 * @Description        : 
 * @Author             : aniubo
 * @Group              : 
 * @Last Modified By   : aniubo
 * @Last Modified On   : 4/17/2023, 4:22:54 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    4/17/2023, 2:01:09 PM   aniubo     Initial Version
**/
//secon
public abstract class Callout {
	// Methods
	public enum METHODS {
		GET,
		POST,
		PUT,
		PATCH,
		DEL
	}

	// Integration base url
	protected String baseUrl;
	// Request
	protected HttpRequest req;
	// Response
	protected HttpResponse resp;
	// Default request timeout
	protected Integer timeout = 120000;
	// Default successful response status codes
	protected Set<Integer> successCodes = new Set<Integer>{ 200 };

	/**
	 * Method to do a GET request
	 * @param:  resource,
	 * @param:  headers,
	 * @param:  params
	 */
	protected void get(
		String resource,
		Map<String, String> headers,
		Map<String, String> params
	) {
		call(METHODS.GET, resource, headers, params, null);
	}

	/**
	 * Method to do a POST request
	 * @param:  resource,
	 * @param:  headers,
	 * @param:  params
	 * @param:  body,
	 */
	protected void post(
		String resource,
		Map<String, String> headers,
		Map<String, String> params,
		String body
	) {
		call(METHODS.POST, resource, headers, params, body);
	}

	/**
	 * Method to do a PUT request
	 * @param:  resource,
	 * @param:  headers,
	 * @param:  params
	 * @param:  body,
	 */
	protected void put(
		String resource,
		Map<String, String> headers,
		Map<String, String> params,
		String body
	) {
		call(METHODS.PUT, resource, headers, params, body);
	}

	/**
	 * Method to do a PATCH request
	 * @param:  resource,
	 * @param:  headers,
	 * @param:  params
	 * @param:  body,
	 */
	protected void patch(
		String resource,
		Map<String, String> headers,
		Map<String, String> params,
		String body
	) {
		call(METHODS.PATCH, resource, headers, params, body);
	}

	/**
	 * Method to do a DEL request
	 * @param:  resource,
	 * @param:  headers,
	 * @param:  params
	 */
	protected void del(
		String resource,
		Map<String, String> headers,
		Map<String, String> params
	) {
		call(METHODS.DEL, resource, headers, params, null);
	}

	/**
	 * Method to do a request
	 * @param:  method,
	 * @param:  resource,
	 * @param:  headers,
	 * @param:  params,
	 * @param:  body,
	 */
	protected HttpResponse call(
		METHODS method,
		String resource,
		Map<String, String> headers,
		Map<String, String> params,
		String body
	) {
		req = new HttpRequest();

		PageReference pRef = String.isBlank(resource)
			? new PageReference(baseUrl)
			: new PageReference(baseUrl + resource);

		// Set url parameters
		if (params != null) {
			pRef.getParameters().putAll(params);
		}

		String endPoint = pRef.getUrl();

		// PATCH is not supported. We must
		// to overwrite using header parameter
		if (method == METHODS.PATCH) {
			method = METHODS.PUT;

			if (headers == null) {
				headers = new Map<String, String>{
					'X-HTTP-Method-Override' => METHODS.PATCH.name()
				};
			} else {
				headers.put('X-HTTP-Method-Override', METHODS.PATCH.name());
			}
		}

		req.setTimeout(timeout);
		req.setMethod(method.name());
		req.setEndpoint(endPoint);

		// Set headers
		if (headers != null) {
			for (String h : headers.keySet()) {
				req.setHeader(h, headers.get(h));
			}
		}

		// Set body
		if (!String.isBlank(body)) {
			req.setBody(body);
		}

		// Send
		resp = new Http().send(req);

		return resp;
	}

	/**
	 * Know if the response is success
	 */
	protected Boolean isResponseCodeSuccess() {
		return successCodes.contains(resp.getStatusCode());
	}

	/**
	 * Set baseUrl from a named credential name
	 */
	protected void setBaseUrlFromNamedCredential(
		String namedCredentialDevName
	) {
		baseUrl = 'callout:' + namedCredentialDevName;
	}
}