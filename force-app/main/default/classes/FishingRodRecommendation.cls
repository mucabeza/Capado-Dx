/**
 * @File Name          : FishingRodRecommendation.cls
 * @Description        : Callout class to fetch fishing rod recommendations under a specified budget
 * @Author             : Copilot
 * @Group              : 
 * @Last Modified By   : Copilot
 * @Last Modified On   : 12/29/2024
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    12/29/2024               Copilot     Initial Version
**/
public class FishingRodRecommendation extends Callout {
	private final String path = '/api/products/search';
	private static final Integer DEFAULT_MAX_PRICE = 100;
	
	public FishingRodRecommendation() {
		baseUrl = 'https://api.example.com';
		setBaseUrlFromNamedCredential('FishingRodAPI');
	}
	
	/**
	 * Get fishing rod recommendations under a specified budget
	 * @param maxPrice Maximum price in dollars (defaults to 100)
	 * @return JSON string with fishing rod recommendations
	 */
	public String getRecommendations(Integer maxPrice) {
		if (maxPrice == null || maxPrice < 0) {
			maxPrice = DEFAULT_MAX_PRICE;
		}
		
		Map<String, String> parameters = new Map<String, String>{
			'category' => 'fishing-rods',
			'maxPrice' => String.valueOf(maxPrice),
			'sortBy' => 'rating'
		};
		
		Map<String, String> headers = new Map<String, String>{
			'Content-Type' => 'application/json',
			'Accept' => 'application/json'
		};
		
		get(path, headers, parameters);
		
		if (isResponseCodeSuccess()) {
			return resp.getBody();
		} else {
			return buildErrorResponse();
		}
	}
	
	/**
	 * Get fishing rod recommendations under $100 (default)
	 * @return JSON string with fishing rod recommendations
	 */
	public String getRecommendationsUnder100() {
		return getRecommendations(DEFAULT_MAX_PRICE);
	}
	
	/**
	 * Build error response when API call fails
	 * @return JSON string with error details
	 */
	private String buildErrorResponse() {
		Map<String, Object> errorResponse = new Map<String, Object>{
			'success' => false,
			'statusCode' => resp.getStatusCode(),
			'status' => resp.getStatus(),
			'message' => 'Failed to fetch fishing rod recommendations'
		};
		return JSON.serialize(errorResponse);
	}
}
