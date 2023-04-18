/**
 * @File Name          : CalloutDummy.cls
 * @Description        : 
 * @Author             : aniubo
 * @Group              : 
 * @Last Modified By   : aniubo
 * @Last Modified On   : 4/17/2023, 4:30:03 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    4/17/2023, 4:26:02 PM   aniubo     Initial Version
**/
public class CalloutDummy extends Callout {
	private final String path = 'dummy';
	private final Map<String, String> parameters = new Map<String, String>{
		'p1' => 'dummy'
	};
	private Map<String, String> headers = new Map<String, String>();

	public CalloutDummy() {
		baseUrl = 'http://192.168.1.1';
		setBaseUrlFromNamedCredential('dummy');
	}
	public String getDummy() {
		get(path, new Map<String, String>(), parameters);
		return resp.getBody();
	}
	public String putDummy() {
		put(path, headers, parameters, '{}');
		return resp.getBody();
	}
	public String postDummy() {
		post(path, headers, parameters, '{}');
		return resp.getBody();
	}
	public String deleteDummy() {
		del(path, headers, parameters);
		return resp.getBody();
	}
	public String patchDummy() {
		patch(path, headers, parameters, '{}');
		return resp.getBody();
	}
}