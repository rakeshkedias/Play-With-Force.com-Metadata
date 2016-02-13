public with sharing class PlayWithMetadataDemo {
	// HTTP Callout
	public static string makeHttpCallout(string actionType, string bodyContents) {
		HTTPRequest req = new HTTPRequest();
		req.setMethod('POST');
		req.setHeader('Content-Type', 'text/XML');
		req.setHeader('SOAPAction', actionType);
		System.debug('======='+bodyContents);
    	req.setBody(bodyContents);
		req.setCompressed(false);
		req.setEndpoint('https://rakeshkumarkedia-dev-ed.my.salesforce.com/services/Soap/m/29.0/'+USERINFO.getOrganizationId());
		String resBodyXMLData;
		HTTPResponse resp;
		try {
			HTTP h = new HTTP();
			resp = h.send(req);
			Integer statusCode = resp.getStatusCode();
			if(statusCode == 200) { 
				resBodyXMLData = resp.getBody();					
			}else{
				resBodyXMLData = 'Failed';
			}	
    	}catch (System.CalloutException e) {
    		resBodyXMLData = 'Failed';
    		System.debug('Callout ERROR: '+ e);
		}
		if(resp != null){
			system.debug(LoggingLevel.INFO,'======response======= '+resp.getBody());
		}
		return resBodyXMLData;
    }
	// SoapHeader
    public static string buildSoapEnvelopHeader(){
    	String buildSoapHeader = '<?xml version="1.0" encoding="UTF-8"?>';
		buildSoapHeader += '<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
		buildSoapHeader += '<env:Header>';
		buildSoapHeader += '<SessionHeader xmlns="http://soap.sforce.com/2006/04/metadata">';
		buildSoapHeader += '<sessionId>' + UserInfo.getSessionId() + '</sessionId>';
		buildSoapHeader += '</SessionHeader>';
		buildSoapHeader += '</env:Header>';
		buildSoapHeader += '<env:Body>';
    	return buildSoapHeader; 
    }
    // Soap Footer
    public static string buildSoapEnvelopFooter(){
    	String buildSoapFooter = '</env:Body>';
		buildSoapFooter += '</env:Envelope>';
    	return buildSoapFooter;
    }
    
    // Create Remotesite Settings
    public static string createRemoteSiteSetting(string remoteSettingsName){
    	// Soap Envelop Header
    	String createRemotesiteSetting = buildSoapEnvelopHeader();
    	// Soap Envelop Body
    	createRemotesiteSetting += '<createMetadata xmlns="http://soap.sforce.com/2006/04/metadata">';
    	createRemotesiteSetting += '<metadata xsi:type="RemoteSiteSetting">';
    	createRemotesiteSetting += '<fullName>'+remoteSettingsName+'</fullName>';
    	createRemotesiteSetting += '<description>Metadata API Remote Site Setting is Created</description>';
    	createRemotesiteSetting += '<disableProtocolSecurity>false</disableProtocolSecurity>';
    	createRemotesiteSetting += '<isActive>true</isActive>';
    	createRemotesiteSetting += '<url>http://www.rakeshkedia.com</url>';
    	createRemotesiteSetting += '</metadata>';
    	createRemotesiteSetting += '</createMetadata>';
    	// Soap Envelop Footer
    	createRemotesiteSetting += buildSoapEnvelopFooter();
    	// Http Callout with create operation
    	string msg = makeHttpCallout('create', createRemotesiteSetting);
    	return msg;
    }
    
    // Update Remotesite Settings
    public static string updateRemoteSiteSetting(string remoteSettingsName){
    	// Soap Envelop Header
    	String updateRemotesiteSetting = buildSoapEnvelopHeader();
    	// Soap Envelop Body
    	updateRemotesiteSetting += '<updateMetadata xmlns="http://soap.sforce.com/2006/04/metadata">';
    	updateRemotesiteSetting += '<metadata xsi:type="RemoteSiteSetting">';
    	updateRemotesiteSetting += '<fullName>'+remoteSettingsName+'</fullName>';
    	updateRemotesiteSetting += '<description>Metadata API Remote Site Setting is Updated</description>';
    	updateRemotesiteSetting += '<disableProtocolSecurity>false</disableProtocolSecurity>';
    	updateRemotesiteSetting += '<isActive>true</isActive>';
    	updateRemotesiteSetting += '<url>http://www.google.com</url>';
    	updateRemotesiteSetting += '</metadata>';
    	updateRemotesiteSetting += '</updateMetadata>';
    	// Soap Envelop Footer
    	updateRemotesiteSetting += buildSoapEnvelopFooter();
    	// Http Callout with create operation
    	string msg = makeHttpCallout('update', updateRemotesiteSetting);
    	return msg;
    }
    
    // Create Custom Object
    public static string createCustomObject(string objFullName, String objLabelName, string defaultFieldLabel){
    	// Soap Envelop Header
    	String createCustomObject = buildSoapEnvelopHeader();
    	// Soap Envelop Body
    	createCustomObject += '<create xmlns="http://soap.sforce.com/2006/04/metadata">';
		createCustomObject += '<metadata xsi:type="CustomObject" xmlns="http://soap.sforce.com/2006/04/metadata">';
		createCustomObject += '<fullName>'+objFullName+'</fullName>';
		createCustomObject += '<deploymentStatus>Deployed</deploymentStatus>';
		createCustomObject += '<description>Created by the Metadata API</description>';
		createCustomObject += '<enableActivities>true</enableActivities>';
		createCustomObject += '<label>'+objLabelName+'</label>';
		createCustomObject += '<nameField>';
		createCustomObject += '<displayFormat>AN-{0000}</displayFormat>';
		createCustomObject += '<label>'+defaultFieldLabel+'</label>';
		createCustomObject += '<type>AutoNumber</type>';
		createCustomObject += '</nameField>';
		createCustomObject += '<pluralLabel>'+objLabelName+'s</pluralLabel>';
		createCustomObject += '<sharingModel>ReadWrite</sharingModel>';
		createCustomObject += '</metadata>';
		createCustomObject += '</create>';
    	// Soap Envelop Footer
    	createCustomObject += buildSoapEnvelopFooter();
    	// Http Callout with create operation
    	string msg = makeHttpCallout('create', createCustomObject);
    	return msg;
    }
    
    // Update Custom Object
    public static string updateCustomObject(string objFullName, String objLabelName, string defaultFieldLabel){
    	// Soap Envelop Header
    	String updateCustomObject = buildSoapEnvelopHeader();
    	// Soap Envelop Body
    	updateCustomObject += '<update xmlns="http://soap.sforce.com/2006/04/metadata">';
    	updateCustomObject += '<UpdateMetadata>';
		updateCustomObject += '<currentName>'+objFullName+'</currentName>';
		updateCustomObject += '<metadata xsi:type="CustomObject" xmlns="http://soap.sforce.com/2006/04/metadata">';
		updateCustomObject += '<fullName>'+objFullName+'</fullName>';
		updateCustomObject += '<deploymentStatus>Deployed</deploymentStatus>';
		updateCustomObject += '<description>Updated by the Metadata API</description>';
		updateCustomObject += '<enableActivities>true</enableActivities>';
		updateCustomObject += '<label>'+objLabelName+'</label>';
		updateCustomObject += '<nameField>';
		updateCustomObject += '<displayFormat>AN-{0000}</displayFormat>';
		updateCustomObject += '<label>'+defaultFieldLabel+'</label>';
		updateCustomObject += '<type>AutoNumber</type>';
		updateCustomObject += '</nameField>';
		updateCustomObject += '<pluralLabel>'+objLabelName+'s</pluralLabel>';
		updateCustomObject += '<sharingModel>ReadWrite</sharingModel>';
		updateCustomObject += '</metadata>';
		updateCustomObject += '</UpdateMetadata>';
		updateCustomObject += '</update>';

    	// Soap Envelop Footer
    	updateCustomObject += buildSoapEnvelopFooter();
    	// Http Callout with create operation
    	string msg = makeHttpCallout('update', updateCustomObject);
    	return msg;
    }
    
    // create custom field 'Date Type' 
    public static string createCustomFieldTypeDate(string objFullName, String fieldName, string labelName){
    	// Soap Envelop Header
    	String createFieldTypeDate = buildSoapEnvelopHeader();
    	// Soap Envelop Body
    	createFieldTypeDate += '<create xmlns="http://soap.sforce.com/2006/04/metadata">';
		createFieldTypeDate += '<metadata xsi:type="CustomField" xmlns="http://soap.sforce.com/2006/04/metadata">';
		createFieldTypeDate += '<fullName>'+objFullName+'.'+fieldName+'</fullName>';
        createFieldTypeDate += '<description>Date type custom field is cretaed</description>';
        createFieldTypeDate += '<externalId>false</externalId>';
        createFieldTypeDate += '<inlineHelpText>CheckDate Help Text</inlineHelpText>';
        createFieldTypeDate += '<label>'+labelName+'</label>';
        createFieldTypeDate += '<required>true</required>';
        createFieldTypeDate += '<trackTrending>false</trackTrending>';
        createFieldTypeDate += '<type>Date</type>';		
		createFieldTypeDate += '</metadata>';
		createFieldTypeDate += '</create>';
    	// Soap Envelop Footer
    	createFieldTypeDate += buildSoapEnvelopFooter();
    	// Http Callout with create operation
    	string msg = makeHttpCallout('create', createFieldTypeDate);
    	return msg;
    }
    
    // Update 'Date Type' custom field into 'Numbar'
    public static string updateCustomFieldTypeDateIntoNumber(string objFullName, String oldFieldName, String newFieldName, string newLabelName){
    	// Soap Envelop Header
    	String updateFieldTypeDatetoNum = buildSoapEnvelopHeader();
    	// Soap Envelop Body 
    	
    	updateFieldTypeDatetoNum += '<update xmlns="http://soap.sforce.com/2006/04/metadata">';
    	updateFieldTypeDatetoNum += '<UpdateMetadata>';
		updateFieldTypeDatetoNum += '<currentName>'+objFullName+'.'+oldFieldName+'</currentName>';
		updateFieldTypeDatetoNum += '<metadata xsi:type="CustomField" xmlns="http://soap.sforce.com/2006/04/metadata">';
		updateFieldTypeDatetoNum += '<fullName>'+objFullName+'.'+newFieldName+'</fullName>';
        updateFieldTypeDatetoNum += '<description>Updated Field date to number</description>';
        updateFieldTypeDatetoNum += '<externalId>false</externalId>';
        updateFieldTypeDatetoNum += '<inlineHelpText>checkNumberHelp</inlineHelpText>';
        updateFieldTypeDatetoNum += '<label>'+newLabelName+'</label>';
        updateFieldTypeDatetoNum += '<precision>18</precision>';
        updateFieldTypeDatetoNum += '<required>true</required>';
        updateFieldTypeDatetoNum += '<scale>0</scale>';
        updateFieldTypeDatetoNum += '<trackTrending>false</trackTrending>';
        updateFieldTypeDatetoNum += '<type>Number</type>';
        updateFieldTypeDatetoNum += '<unique>false</unique>';
		updateFieldTypeDatetoNum += '</metadata>';  
		updateFieldTypeDatetoNum += '</UpdateMetadata>';
		updateFieldTypeDatetoNum += '</update>';
    	// Soap Envelop Footer
    	updateFieldTypeDatetoNum += buildSoapEnvelopFooter();
    	// Http Callout with create operation
    	string msg = makeHttpCallout('update', updateFieldTypeDatetoNum);
    	return msg;
    }
    
    //Execute below on Developer Console
    
	//PlayWithMetadataDemo.createRemoteSiteSetting('PlayWithMetaData');
	//PlayWithMetadataDemo.updateRemoteSiteSetting('PlayWithMetaData');
	//PlayWithMetadataDemo.createCustomObject('PlayWithMetaData__c', 'Play With Metadata', 'Play Name');
	//PlayWithMetadataDemo.updateCustomObject('PlayWithMetaData__c', 'Play With Metadata Updates', 'Play Name2');
	//PlayWithMetadataDemo.createCustomFieldTypeDate('PlayWithMetaData__c','PlayDate__c','Play Date');
	//PlayWithMetadataDemo.updateCustomFieldTypeDateIntoNumber('PlayWithMetaData__c','PlayDate__c','PlayNum__c','Play Number');
}