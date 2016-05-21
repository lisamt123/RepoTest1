public with sharing class ctrl_BannerComponent {

	public String getBanner(){
		string bannerString = '';
		
		Role_Banner2__c b = Role_Banner2__c.getInstance(userInfo.getProfileId());
		if(b.Banner_Name__c==null){
			b = Role_Banner2__c.getInstance(userInfo.getUserId());
		}
		bannerString = b.Banner_Name__c;
		return bannerString;
	}

}