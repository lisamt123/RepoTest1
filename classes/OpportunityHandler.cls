public abstract class OpportunityHandler implements IOpportunityHandler{
  // context-specific methods to implement  
  public virtual void beforeInsert(Opportunity opp){}
  public virtual void beforeUpdate(Opportunity newOpp, Opportunity oldOpp){}
  public virtual void beforeDelete(Opportunity Opp){}
  public virtual void afterInsert(Opportunity Opp){}
  public virtual void afterUpdate(Opportunity newOpp, Opportunity oldOpp){}
  public virtual void afterDelete(Opportunity Opp){}
  public virtual void afterUndelete(Opportunity opp){}
  
 
	 
	
}