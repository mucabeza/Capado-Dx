/**
 * @File Name          : FishingRodRecommendationTest.cls
 * @Description        : Test class for FishingRodRecommendation
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
@isTest
private class FishingRodRecommendationTest {

	@isTest
	private static void testGetRecommendationsUnder100Success() {
		String mockResponseBody = '{"success":true,"products":[{"name":"Shimano FX Spinning Rod","price":49.99,"rating":4.5},{"name":"Ugly Stik GX2 Spinning Rod","price":39.99,"rating":4.7}]}';
		Test.setMock(HttpCalloutMock.class, getCalloutMock(200, mockResponseBody));
		
		Test.startTest();
		FishingRodRecommendation recommendation = new FishingRodRecommendation();
		String response = recommendation.getRecommendationsUnder100();
		Test.stopTest();
		
		System.assert(response != null, 'Response should not be null');
		System.assert(response.contains('success'), 'Response should contain success indicator');
		System.assert(response.contains('products'), 'Response should contain products');
	}
	
	@isTest
	private static void testGetRecommendationsCustomPrice() {
		String mockResponseBody = '{"success":true,"products":[{"name":"Premium Rod","price":75.00,"rating":4.8}]}';
		Test.setMock(HttpCalloutMock.class, getCalloutMock(200, mockResponseBody));
		
		Test.startTest();
		FishingRodRecommendation recommendation = new FishingRodRecommendation();
		String response = recommendation.getRecommendations(75);
		Test.stopTest();
		
		System.assert(response != null, 'Response should not be null');
		System.assert(response.contains('success'), 'Response should contain success indicator');
	}
	
	@isTest
	private static void testGetRecommendationsWithNullPrice() {
		String mockResponseBody = '{"success":true,"products":[]}';
		Test.setMock(HttpCalloutMock.class, getCalloutMock(200, mockResponseBody));
		
		Test.startTest();
		FishingRodRecommendation recommendation = new FishingRodRecommendation();
		String response = recommendation.getRecommendations(null);
		Test.stopTest();
		
		System.assert(response != null, 'Response should not be null');
	}
	
	@isTest
	private static void testGetRecommendationsFailure() {
		Test.setMock(HttpCalloutMock.class, getCalloutMock(500, ''));
		
		Test.startTest();
		FishingRodRecommendation recommendation = new FishingRodRecommendation();
		String response = recommendation.getRecommendationsUnder100();
		Test.stopTest();
		
		System.assert(response != null, 'Response should not be null');
		System.assert(response.contains('success'), 'Response should contain success indicator');
		System.assert(response.contains('false'), 'Success should be false for error response');
		System.assert(response.contains('statusCode'), 'Response should contain status code');
	}
	
	static CalloutMock getCalloutMock(Integer status, String body) {
		return new CalloutMock(
			status,
			body,
			'',
			new Map<String, String>(),
			new Map<String, String>{ 'products' => body }
		);
	}
}
