/**
 * @File Name          : CalloutDummyTest.cls
 * @Description        : 
 * @Author             : aniubo
 * @Group              : 
 * @Last Modified By   : aniubo
 * @Last Modified On   : 4/17/2023, 4:26:55 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    4/17/2023, 4:26:55 PM   aniubo     Initial Version
**/
@isTest
private class CalloutDummyTest {

    @isTest
	private static void get() {
		Test.setMock(HttpCalloutMock.class, getCalloutMock(200));
		// Actual test
		Test.startTest();
		CalloutDummy dummy = new CalloutDummy();
		String body = dummy.deleteDummy();
		System.assert(body != null);
		body = dummy.getDummy();
		System.assert(body != null);
		body = dummy.postDummy();
		System.assert(body != null);
		body = dummy.putDummy();
		System.assert(body != null);
		body = dummy.patchDummy();
		System.assert(body != null);
		Test.stopTest();

		// Asserts
	}
	static CalloutMock getCalloutMock(Integer status) {
		return new CalloutMock(
			status,
			'[]',
			'',
			new Map<String, String>(),
			new Map<String, String>{ 'dummny' => '[]' }
		);
	}

}