public with sharing class PhasedImplementationUpdate {
	
	public static SFDC_520_Quote__c GetPieceProject(Project_Piece__c PP)
	{	
		SFDC_520_Quote__c thisProject = new SFDC_520_Quote__c();
		
		try {
			thisProject = [select Id, RecordTypeId, Inventory_Completed__c, DMS_Accessed__c  from SFDC_520_Quote__c where Id =: PP.Project__c limit 1];
		}
		catch(Exception e) {
			
		}
		
		return thisProject;
	}
	
	@future
	public static void UpdateInventoryModuleComplete(String Id)
	{
		Project_Piece__c thisPiece = new Project_Piece__c();
		SFDC_520_Quote__c thisProject = new SFDC_520_Quote__c();
		
		try {
			thisPiece = [select Id, Project__c from Project_Piece__c where Id =: Id limit 1];
		}
		catch(Exception e) {
			
		}
		
		try {
			thisProject = [select Id, Inventory_Completed__c from SFDC_520_Quote__c where Id =: thisPiece.Project__c limit 1];
		}
		catch(Exception e) {
			
		}
		
		thisProject.Inventory_Completed__c = system.today();
		
		try {
			update thisProject;	
		}
		catch(Exception e) {
			
		}
		
	}
	
	@future
	public static void UpdateDMSAccessed(String Id)
	{
		Project_Piece__c thisPiece = new Project_Piece__c();
		SFDC_520_Quote__c thisProject = new SFDC_520_Quote__c();
		
		try {
			thisPiece = [select Id, Project__c from Project_Piece__c where Id =: Id limit 1];
		}
		catch(Exception e) {
			
		}
		
		try {
			thisProject = [select Id, Inventory_Completed__c from SFDC_520_Quote__c where Id =: thisPiece.Project__c limit 1];	
		}
		catch(Exception e) {
			
		}
		
		
		thisProject.DMS_Accessed__c = system.today();
		
		try {
			update thisProject;	
		}
		catch(Exception e) {
			
		}
		
	}
	@future
	public static void UpdateCRMComplete(String Id)
	{
		Project_Piece__c thisPiece = new Project_Piece__c();
		SFDC_520_Quote__c thisProject = new SFDC_520_Quote__c();
		
		
		try {
			thisPiece = [select Id, Project__c from Project_Piece__c where Id =: Id limit 1];	
		}
		catch(Exception e) {
			
		}
		try {
			thisProject = [select Id, Inventory_Completed__c from SFDC_520_Quote__c where Id =: thisPiece.Project__c limit 1];	
		}
		catch(Exception e) {
			
		}
		
		
		
		thisProject.CRM_Completed__c = system.today();
		
		try {
			update thisProject;	
		}
		catch(Exception e) {
			
		}
		
	}
	@future
	public static void UpdateILMComplete(String Id)
	{
		Project_Piece__c thisPiece = new Project_Piece__c();
		SFDC_520_Quote__c thisProject = new SFDC_520_Quote__c();
		
		
		try {
			thisPiece = [select Id, Project__c from Project_Piece__c where Id =: Id limit 1];	
		}
		catch(Exception e) {
			
		}
		
		try {
			thisProject = [select Id, Inventory_Completed__c from SFDC_520_Quote__c where Id =: thisPiece.Project__c limit 1];	
		}
		catch(Exception e) {
			
		}
		
		
		
		
		thisProject.ILM_Completed__c = system.today();
		
		try {
			update thisProject;	
		}
		catch(Exception e) {
			
		}
		
	}
	@future
	public static void CreateTrainingEvents(Date startDate, Date endDate, Id trainer, Id relatedId)
	{
		integer numberOfDays = startDate.daysBetween(endDate);
		Event e = new Event();
		e.OwnerId = trainer;
		e.Subject = 'Training - Proposed';
		e.StartDateTime = startDate;
		e.IsAllDayEvent = true;
		e.ShowAs = 'Busy';
		e.WhatId = relatedId;
		if (numberOfDays > 0)
		{
			e.EndDateTime = startDate;
			e.IsRecurrence = true;
			e.RecurrenceStartDateTime = startDate;
			e.RecurrenceEndDateOnly = endDate;
			e.RecurrenceType = 'RecursEveryWeekday';
			e.RecurrenceDayOfWeekMask = 62;
		}
		else e.EndDateTime = endDate;
		insert e;
	}
	@future
	public static void UpdateInventoryVerification(string Id)
	{
		Project_Piece__c thisPiece = new Project_Piece__c();
		SFDC_520_Quote__c thisProject = new SFDC_520_Quote__c();
		
		
		try {
			thisPiece = [select Id, Project__c from Project_Piece__c where Id =: Id limit 1];
		}
		catch(Exception e) {
			
		}
		
		try {
			thisProject = [select Id, Inventory_Completed__c from SFDC_520_Quote__c where Id =: thisPiece.Project__c limit 1];	
		}
		catch(Exception e) {
			
		}
		
		
		thisProject.Inventory_Verified__c = system.today();
		
		try {
			update thisProject;	
		}
		catch(Exception e) {
			
		}
		
	}
	
	@future
	public static void UpdateProspectDataReceived(string Id)
	{
		Project_Piece__c thisPiece = [select Id, Project__c from Project_Piece__c where Id =: Id limit 1];
		SFDC_520_Quote__c thisProject = [select Id, Inventory_Completed__c from SFDC_520_Quote__c where Id =: thisPiece.Project__c limit 1];
		
		thisProject.Prospect_Data_Received__c = system.today();
		update thisProject;
	}
	
}