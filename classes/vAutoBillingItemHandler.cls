public class vAutoBillingItemHandler extends BillingItemHandler{ 

public virtual override void beforeDelete(Billing_Item__c billingItem){
		  billingItem = [Select Id,RecordTypeId 
  from Billing_Item__c where Id =: billingItem.Id ];
  system.debug('Deleting Billing Item with Record Type: '+StaticData.getInstance().BillingItemRecTypesMap.get(billingItem.RecordTypeId).Name);
  if( billingItem.RecordTypeId !=  StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id ){
  		Trigger.oldMap.get(billingItem.Id).addError('Can not delete Items of record Type: '+StaticData.getInstance().BillingItemRecTypesMap.get(billingItem.RecordTypeId).Name);
  }

 
 }
	
public override void afterInsert(Billing_Item__c newbillingItem){
   newbillingItem = [Select Id,Project_Type__c,LOB_Status__c,LOB__c,Related_POA__r.OwnerId, Related_POA__c,
   							Related_POA__r.Dealer__c,Related_Project_Piece__r.Project__r.Project_Type__c,
   							Related_Project_Piece__r.Project__r.Action__c,Cloned_Asset__c,Suite_Name__c, Related_POA__r.Stockwave_Manager__c
					   from Billing_Item__c
					  where Id =: newbillingItem.Id ];

	Map<string, vAuto_No_Intro_Call__c> NoIntroCalls = vAuto_No_Intro_Call__c.getAll();
	System.debug('================>>>>>> NoIntroCalls = ' + NoIntroCalls);
	if(newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c != null){
		for(vAuto_No_Intro_Call__c nic : NoIntroCalls.values()){
			if(newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c.contains('KBB')
				&& nic.Project_Type__c.contains('KBB')){
				if(newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == nic.Project_Type__c){
					//do not create Intro for Sale Lines
	 				return;
				}
			}
			else if(newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c.contains('Conquest')
				&& nic.Project_Type__c.contains('Conquest')){
				if(newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == nic.Project_Type__c
					&& newbillingItem.Related_Project_Piece__r.Project__r.Action__c == nic.Action__c){
					//do not create Intro for Conquest
	 				return;
				}
			}
			else if(newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c.contains('Auction')
				&& nic.Project_Type__c.contains('Auction')){
				if(newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == nic.Project_Type__c
					&& newbillingItem.Related_Project_Piece__r.Project__r.Action__c == nic.Action__c){
					//do not create Intro for Auction Genius
	 				return;
				}
			}
		}
	}
	else{return;}
/* Commented out code and replaced with above code to use a custom setting
	if(
		(
			newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == 'KBB PAR Used - Stand Alone'
		 	|| newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == 'KBB PAR New - Stand Alone'
		 	|| newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == 'KBB PAR Used - w/ vAuto'
		 	|| newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == 'KBB PAR New - w/ vAuto'
	 	) 
	 	||(
	 		(
	 			newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == 'Conquest'
		 		|| newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == 'Conquest Stand-Alone'
				|| newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == 'Auction Genius - Stand Alone'
			) && 
	 		(
 				newbillingItem.Related_Project_Piece__r.Project__r.Action__c == 'Sale'
		 		|| newbillingItem.Related_Project_Piece__r.Project__r.Action__c == 'Upsell'
		 		|| newbillingItem.Related_Project_Piece__r.Project__r.Action__c == 'Reactivate'
		 		|| newbillingItem.Related_Project_Piece__r.Project__r.Action__c == 'Swap'
	 		) ||
		
	 		//'Auction Genius - With Provision Client'
	  		(
	  			newbillingItem.Related_Project_Piece__r.Project__r.Project_Type__c == 'Auction Genius - With Provision Client' 
	  			&& 
				(
					newbillingItem.Related_Project_Piece__r.Project__r.Action__c == 'Upsell'
		 			|| newbillingItem.Related_Project_Piece__r.Project__r.Action__c == 'Swap'
		 		)
	 		)
	  	)
	){ 
 		//do not create Intro for Conquest , Auction Genius - Stand Alone and Sale Lines
 		return;
	}*/
 if(newbillingItem.LOB__c !=null){

 	try{
 	//update the Account field to show the latest status on vAuto products
	UpdateAccountvAutoProducts(newbillingItem.Related_POA__c,newbillingItem.Related_POA__r.Dealer__c );
	}
	catch(Exception e){
		UtilityClass.DebugException(e);
	}

	// create Intro call.
	if(	//If not a cloned line;
		!newbillingItem.Cloned_Asset__c){
		if(newbillingItem.Suite_Name__c =='Stockwave Stand Alone'){
			//create an intro call to the Stockwave Manager for assignment to an Acquisition Pro
			Task task = new Task();
			task.Subject =  '* Intro Call AP SW Stand Alone';
			task.Type = 'Call';
			task.Priority ='Normal';
			task.Description = 'A new account has been approved for Stockwave Stand Alone. AP to make Intro Call';
			task.ActivityDate = System.today();
			task.OwnerId = newbillingItem.Related_POA__r.Stockwave_Manager__c;
			task.WhatId = newbillingItem.Related_POA__c;
			System.debug('Creating Task: task.Subject: '+task.Subject+'; task.ActivityDate:'+task.ActivityDate+';task.OwnerId'+task.OwnerId+';task.WhatId'+task.WhatId);
			insert task;
		}
		if(newbillingItem.Suite_Name__c =='Stockwave'){
			//create an intro call to the Stockwave Manager for assignment to an Acquisition Pro
			Task task = new Task();
			task.Subject =  '* Intro Call AP SW';
			task.Type = 'Call';
			task.Priority ='Normal';
			task.Description = 'A new account has been approved for Stockwave. AP to make Intro Call';
			task.ActivityDate = System.today();
			task.OwnerId = newbillingItem.Related_POA__r.Stockwave_Manager__c;
			task.WhatId = newbillingItem.Related_POA__c;
			System.debug('Creating Task: task.Subject: '+task.Subject+'; task.ActivityDate:'+task.ActivityDate+';task.OwnerId'+task.OwnerId+';task.WhatId'+task.WhatId);
			insert task;
		}
		else{
		 	//create a intro call 	
		 	Task task = new Task();
			task.Subject =  '* Intro Call';
			task.Type = 'Call';
			task.Priority ='Normal';
			task.Description = 'A new account has been approved for integration PM task to include Step 1 - PM make Intro call to site Demo Info Future Users Next Step Step 2 - Close this task';
			task.ActivityDate = System.today();
			task.OwnerId = newbillingItem.Related_POA__r.OwnerId;
			task.WhatId = newbillingItem.Related_POA__c;
			System.debug('Creating Task: task.Subject: '+task.Subject+'; task.ActivityDate:'+task.ActivityDate+';task.OwnerId'+task.OwnerId+';task.WhatId'+task.WhatId);
			insert task;
		}
	}
 }
} 
  
public override void afterUpdate(Billing_Item__c newbillingItem, Billing_Item__c oldbillingItem){
 	newbillingItem = [Select Id,Project_Type__c,LOB_Status__c,LOB__c,Last_SE_Date__c,
 								Related_POA__r.OwnerId, Related_POA__c,Related_POA__r.Dealer__c,Suite_Name__c
 						from Billing_Item__c where Id =: newbillingItem.Id ];
	//if the status changes
	system.debug('newbillingItem.Suite_Name__c:'+newbillingItem.Suite_Name__c+';  oldbillingItem.Suite_Name__c:'+oldbillingItem.Suite_Name__c);
	system.debug('newbillingItem.LOB_Status__c:'+newbillingItem.LOB_Status__c+';  oldbillingItem.LOB_Status__c:'+oldbillingItem.LOB_Status__c);
	system.debug('newbillingItem.Last_SE_Date__c:'+newbillingItem.Last_SE_Date__c+';  oldbillingItem.Last_SE_Date__c:'+oldbillingItem.Last_SE_Date__c);

	//only in cases where the lineItem is nmarked as product suite
	if(newbillingItem.LOB_Status__c != oldbillingItem.LOB_Status__c && newbillingItem.LOB__c!=null){
	
		if(oldbillingItem.LOB_Status__c  != 'Good' && newbillingItem.LOB_Status__c  == 'Good'){
			system.debug('Creating task on Status set to Good on newbillingItem.Project_Type__c: '+newbillingItem.Project_Type__c);
			//Ramana: Stop comparing using the project type since this requires project assets
			//and not all converted or old assets have project assets
			//and start using the Suite_Name__c field
			//if(newbillingItem.Project_Type__c == 'Account Setup'){			
			if(newbillingItem.Suite_Name__c == 'Provision'){			
				CreateTask('# PM Review Call Good Status', 30,newbillingItem.Related_POA__r.OwnerId,newbillingItem.Related_POA__c );
			}
			//else if(newbillingItem.Project_Type__c == 'Conquest'){
			else if(newbillingItem.Suite_Name__c == 'Conquest'){
				CreateTask('# Conquest Review Call Good Status', 30,newbillingItem.Related_POA__r.OwnerId,newbillingItem.Related_POA__c );
			}
		}
		else if(oldbillingItem.LOB_Status__c  != 'At Risk' && newbillingItem.LOB_Status__c  == 'At Risk'){
			//if(newbillingItem.Project_Type__c == 'Account Setup'){
			if(newbillingItem.Suite_Name__c == 'Provision'){
				CreateTask('# PM Review Call At Risk Status', 7,newbillingItem.Related_POA__r.OwnerId,newbillingItem.Related_POA__c );
			}		
			//else if(newbillingItem.Project_Type__c == 'Conquest'){
			else if(newbillingItem.Suite_Name__c == 'Conquest'){
				CreateTask('# Conquest Review Call At Risk Status', 7,newbillingItem.Related_POA__r.OwnerId,newbillingItem.Related_POA__c );
			}
		}
		/*else if((oldbillingItem.LOB_Status__c  != 'Save - Account' && newbillingItem.LOB_Status__c  == 'Save - Account')
		||(oldbillingItem.LOB_Status__c  != 'Save - Pre Launch' && newbillingItem.LOB_Status__c  == 'Save - Pre Launch')
		||(oldbillingItem.LOB_Status__c  != 'Save - SVOC' && newbillingItem.LOB_Status__c  == 'Save - SVOC')
		||(oldbillingItem.LOB_Status__c  != 'Save - Temp' && newbillingItem.LOB_Status__c  == 'Save - Temp')
		){
			//if(newbillingItem.Project_Type__c == 'Account Setup'){
				if(newbillingItem.Suite_Name__c == 'Provision'){
					CreateTask('# PM Review Call Save Status', 7,newbillingItem.Related_POA__r.OwnerId,newbillingItem.Related_POA__c );
				}
				//else if(newbillingItem.Project_Type__c == 'Conquest'){
				else if(newbillingItem.Suite_Name__c == 'Conquest'){
					CreateTask('# Conquest Review Call Save Status', 7,newbillingItem.Related_POA__r.OwnerId,newbillingItem.Related_POA__c );
				}
		}*/
		//update the Account field to show the latest status on vAuto products
		UpdateAccountvAutoProducts(newbillingItem.Related_POA__c,newbillingItem.Related_POA__r.Dealer__c );
	}
	//in cases where the lineItem last solid emnganement changed update the vAuto Products
	else if (newbillingItem.Last_SE_Date__c != oldbillingItem.Last_SE_Date__c && newbillingItem.LOB__c!=null){
		//update the Account field to show the latest status on vAuto products
		UpdateAccountvAutoProducts(newbillingItem.Related_POA__c,newbillingItem.Related_POA__r.Dealer__c);
	}
}

private void UpdateAccountvAutoProducts(Id poaId , Id accountId){
	if(accountId == null){
		system.debug('No AccountId specified; Cannot update vAutp Products on Account');
		return;
	}
	//CR-00014210 replacing Last_SE_Date__c with vAuto_Activation_Date__c
	List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id, LOB_Status__c, Project_Type__c, Related_POA__c, Suite_Name__c,
	  															Related_POA__r.Dealer__c, Last_SE_Date__c, vAuto_Activation_Date__c,
	  															Related_Project_Piece__r.Project__r.Action__c
	  													   FROM Billing_Item__c 
	  													  WHERE Related_POA__c = :poaId
   	  														AND (Product_Status__c = 'Active'
   	  														 OR Product_Status__c = 'Pending')
   	  														AND LOB__c!=null];
   	  
   	system.debug('Collected: '+billingItemsMarkedWithLOB.size() +' billing items to update Account vAutp Products field');

	if(billingItemsMarkedWithLOB.size() > 0){
   		for(Billing_Item__c bi : billingItemsMarkedWithLOB){
   			if(bi.Related_Project_Piece__r.Project__r.Action__c != 'Swap'){
			   	String provisionStatus = '';
   	  			Date provisionLSE = null;
   	  			String conquestStatus = '';
   	  			Date conquestLSE = null;
			   	String vAutoProductStatus ='';

		   		for(Billing_Item__c item : billingItemsMarkedWithLOB){  
		   	  		system.debug('Processing: item.vAuto_Activation_Date__c: '+item.vAuto_Activation_Date__c);
		   	  		system.debug('Processing: item.Suite_Name__c: '+item.Suite_Name__c);
		   	  		//system.debug('Processing: item.Last_SE_Date__c: '+item.Last_SE_Date__c);
		   	  		system.debug('Processing: item.LOB_Status__c: '+item.LOB_Status__c);
		   	  		if(item.Suite_Name__c == 'Provision'){
		   	  			provisionStatus = item.LOB_Status__c;
		   	  			provisionLSE = item.Last_SE_Date__c;
		   	  		}
		   	  		else if(item.Suite_Name__c == 'Conquest'){
						conquestStatus = item.LOB_Status__c;
		   	  			conquestLSE = item.Last_SE_Date__c;
		   	  		}
		   	  		//}
		   	  		 /*String lseDate = 'LSE: None';
		   	  		 if(item.Last_SE_Date__c != null){
		   	  			lseDate = 'LSE: '+item.Last_SE_Date__c.month()+'-'+item.Last_SE_Date__c.day()+'-'+item.Last_SE_Date__c.year();	
		   	  		}
		   	  	 	vAutoProductStatus = vAutoProductStatus + item.Suite_Name__c +' : '+ item.LOB_Status__c +' : '+lseDate+'\r\n';*/
		   	  		String activationDate = 'Activation Date: None';
		   	  		if(item.vAuto_Activation_Date__c != null){
		   	  			activationDate = 'Activation Date: '+item.vAuto_Activation_Date__c.month()+'-'+item.vAuto_Activation_Date__c.day()+'-'+item.vAuto_Activation_Date__c.year();	
		   	  		}
		   	  	 	vAutoProductStatus = vAutoProductStatus + item.Suite_Name__c +' : '+ item.LOB_Status__c +' : '+activationDate+'\r\n';
		   	  	}  	  

			   	system.debug('Updating vAuto products: '+vAutoProductStatus);
			   	//update account field
			   	Account a = new Account(Id = accountId);
			   	a.vAuto_Products__c = vAutoProductStatus;
				update a;
			   	  
			   	//update poa Field
			   	POA__c poa = new POA__c(Id =poaId);
			   	if(provisionStatus != ''){ 	  
			   		poa.Provision_Status__c  = provisionStatus;
			   	}
			   	if(provisionLSE != null){
			   		poa.Provision_LSE__c = provisionLSE;
			   	}
			   	if(conquestStatus != ''){
			   		poa.Conquest_Status__c  = conquestStatus;
			   	}
			   	if(conquestLSE != null){
			   		poa.Conquest_LSE__c = conquestLSE;
			   	}

			   	update poa;
	   	  	}
   	  	}
	}
}

private void CreateTask(String subject, Integer dueInDays, Id ownerId, Id poaId){
  //check if the task created
  List<Task> tasks = [Select Id from Task where 
  ownerId=:ownerId
  and whatId=:poaId
  and Subject =: subject
  and Status =: 'Not Started'];

  

 if(tasks == null || tasks.size() == 0){
	Task task = new Task();
	task.Subject =  subject;
	task.ActivityDate = System.today().addDays(dueInDays);
	task.OwnerId = ownerId;
	task.WhatId = poaId;
	System.debug('Creating Task: task.Subject: '+task.Subject+'; task.ActivityDate:'+task.ActivityDate+';task.OwnerId'+task.OwnerId+';task.WhatId'+task.WhatId);
	insert task;
	}
}
}