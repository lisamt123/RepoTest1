/***************************************************************************************************
Name        : OpportunityPricingTableBeforeUpdate 
Created By  : TinderBox 
Email       : developer@tinderbox.com
Created Date: July 24, 2013
Description : This Trigger runs before an Opportunity is updated. It builds and sets the Pricing HTML field
              on the Opportunity.
******************************************************************************************************/
trigger OpportunityPricingTableBeforeUpdate on Opportunity (before update) {

	
    System.debug('OpportunityPricingTableBeforeUpdate Trigger: Start Trigger');
	    for(Opportunity oUpdatedOpportunity: trigger.new) {
	        
	        try{
				if(test.isRunningTest()==false){
	            	TinderBoxPricingGenerator.buildOpportunityPricingHTML(oUpdatedOpportunity);
				}
	            
	        }catch(Exception oException){
	            
	            System.debug('OpportunityPricingTableBeforeUpdate Trigger: ' + oException.getMessage());
	        }   
	    }        
    System.debug('OpportunityPricingTableBeforeUpdate Trigger: End Trigger');
}