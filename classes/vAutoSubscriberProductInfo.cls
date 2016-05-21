public with sharing class vAutoSubscriberProductInfo {

	// Class Variables 
    public List<Billing_Item__c> billedAssets{get;set;}
    public String ACCTId{get;set;}
    public SubscriberAssetWrapper SAWrap{get;set;}//Class
    public List<SubscriberAssetWrapper> SAWrapList{get;set;}//List of records in the class
    public Integer numOfRows{get;set;}
	private ApexPages.StandardController stdController;

	// Constructor
	public vAutoSubscriberProductInfo(ApexPages.StandardController stdController){
		this.stdController = stdController;
        ACCTId = String.valueOf(stdController.getRecord().get('id'));
        getBilledAssets();
        initializeSubscriberAssetWrapper();
	}

	//Grabbing the vAuto Billed Assets from the Account.
    public void getBilledAssets(){
        if (ACCTId != null) {
	        try{
                billedAssets = 	[SELECT Id, Name, Subscriber_Account__c, Suite_Name__c, LOB_Status__c, vAuto_Activation_Date__c, isBaseAsset__c, Product_Status__c
                               	   FROM Billing_Item__c
                               	  WHERE Subscriber_Account__c =: ACCTId AND isBaseAsset__c = true AND Product_Status__c = 'Active'];
            	numOfRows = billedAssets.size();
            }
	        catch (exception e) {
	            System.debug('getBilledAssets() encountered an exception: ' + e.getMessage());
	            throw e;
	        }
        }
        else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to retrieve an AccountId.');
            ApexPages.addMessage(myMsg);
        }
    }
	
    public void initializeSubscriberAssetWrapper() {
        SAWrapList = null;
        if (billedAssets != null && billedAssets.size() > 0){
            SAWrapList = new List<SubscriberAssetWrapper>();
            for (Billing_Item__c bi : billedAssets) {
            	if(bi.Suite_Name__c == 'Auction Genius'
            	|| bi.Suite_Name__c == 'Provision'
            	|| bi.Suite_Name__c == 'Conquest'
            	|| bi.Suite_Name__c == 'KBB PAR Used'
            	|| bi.Suite_Name__c == 'KBB PAR New'){
            		SAWrap = new SubscriberAssetWrapper();
                	SAWrap.ProductName = bi.Suite_Name__c;
                	SAWrap.ProductStatus = bi.LOB_Status__c;
                	SAWrap.ActivationDate = bi.vAuto_Activation_Date__c.format();
                	SAWrapList.add(SAWrap);
                }
                else{
                	continue;
                }
            }
        }
    }

    // Class
    public class SubscriberAssetWrapper{
        public String ProductName{get;set;}
        public String ProductStatus{get;set;}
        public String ActivationDate{get;set;}
    }

}