trigger OpportunityLineItemTriggers on OpportunityLineItem (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    
    system.debug('Bazinga... Optimize.. OpportunityLineItemTriggers.trigger');
    
    
    //Ramana&Mark: 08/20/2014: Mark is looking into see if this czn be done in Validation Rules.
    //Ramana: 08/28/2014: Mark already moved this to Validations
    /*
    if(trigger.isBefore && (trigger.isUpdate || trigger.isInsert)) {

        MAP<Id, String> searchPBEs = new MAP<Id, String>();
        

        for(OpportunityLineItem thisOLI: trigger.new) {

            searchPBEs.put(thisOLI.PricebookEntryId, null);
                
        }

        MAP<Id, PricebookEntry> theseRelatedPBEs = new MAP<Id, PricebookEntry>([select Id, Product2Id, UnitPrice from PriceBookEntry where Id IN: searchPBEs.keyset()]);

        for(OpportunityLineItem thisOLI : trigger.new) {        

            if(thisOLI.Disable_Price_Change__c == 'TRUE') { 
                
                PricebookEntry PBE = theseRelatedPBEs.get(thisOLI.PriceBookEntryId);

                if((PBE.UnitPrice < 0 && (PBE.UnitPrice > thisOLI.UnitPrice)) || (PBE.UnitPrice >= 0 && (PBE.UnitPrice != thisOLI.UnitPrice))) {                             

                    Product2 thisProduct = [select Id, Name from Product2 where Id = :PBE.Product2Id];              

                    thisOLI.addError('Product being added/edited that DOES NOT allow price differentiation. Please make sure the Sales Price and List Price are the same. Product: ' + thisProduct.Name + ' List Price: ' + PBE.UnitPrice + ' Sales Price: ' + thisOLI.UnitPrice + ' ProductId: ' + thisProduct.Id);
                }
                
            
            }
            
            */
            //if(thisOLI.Price_Book_ID__c == '01sS00000008rK9'){
            
                    
               // PricebookEntry PBE = theseRelatedPBEs.get(thisOLI.PriceBookEntryId);
                /*if(thisOLI.UnitPrice != PBE.UnitPrice){
                    thisOLI.addError('**** Price Adjustment button on Opportunity is the only way to modify prices ****');
                }
                /*if(thisOLI.UnitPrice == PBE.UnitPrice){
                    insert thisOLI;
                }*/
            //}
            
            /*
        }   
    }
    */

/*
    if(trigger.isBefore && trigger.isUpdate){
        
        Map<Id, String> searchPBEs = new Map<Id, String>();
        
        for(OpportunityLineItem thisOLI : trigger.old){
            searchPBEs.put(thisOLI.PricebookentryId, null);
        }
        
        Map<Id, PricebookEntry> theseRelatedPBEs = new Map<Id, PricebookEntry>([SELECT Id, Product2Id, UnitPrice FROM PricebookEntry WHERE Id IN: searchPBEs.keyset()]);
        
        for(OpportunityLineItem thisOLI : trigger.old){
            PricebookEntry PBE = theseRelatedPBEs.get(thisOLI.PricebookentryId);
            
            //if(PBE.UnitPrice != thisOLI.UnitPrice){
            //    trigger.old[0].addError('****You must use the Price Adjustment button to modify prices****');
            }//
            
         }
    }
    */

  //Ramana&Mark: 08/20/2014: Mark confirmed that validation rules cannot handle deletions
    if(trigger.isBefore && trigger.isDelete) {

        MAP<Id, Id> theseOpptyIds = new MAP<Id, Id>();      

        for(OpportunityLineItem theseOLIs : trigger.old) {

            theseOpptyIds.put(theseOLIs.OpportunityId, null);           
        }

        LIST<Opportunity> theseOpptys = new LIST<Opportunity>();        

        for(Opportunity O: [select Id, StageName 
                            from Opportunity
                            where Id IN:theseOpptyIds.keySet()]) {
                
            
            if(O.StageName == 'Closed or Won' || O.StageName == 'Closed or Lost') {
                
                Id roleId = [SELECT UserRoleId FROM User WHERE Id = :UserInfo.getUserId()].UserRoleId;
                
                system.debug('Bazinga... lastmodifiedby roleid: ' + roleId);
                
                if(roleId != '00E70000001GBsB' &&  //Business Analyst
                   roleId != '00E70000001GJu5' &&  //CRM Systems Administrator
                   roleId != '00E70000001GE8B' &&  //Salesforce Developer
                   roleId != '00E70000001G9uk' &&  //Consumer Campaign Marketing Manager
                   roleId != '00E70000001GJrp' &&  //Director of Inside Sales
                   roleId != '00E70000000wHfS') {  //VP of Sales
                        
                    trigger.old[0].addError('**** ERROR:  Cannot delete Products from a Closed Opportunity ****');
                }
            }
            
                /*if(O.StageName != null){
                
                Id roleId = [SELECT UserRoleId FROM User WHERE Id = :UserInfo.getUserId()].UserRoleId;
                if(roleId != '00E70000001GJrp' && //Director of Inside Sales
                   roleId != '00E70000001GE8B' &&  //Salesforce Developer 
                   roleId != '00E70000001GJu5' &&  //CRM Systems Administrator 
                   roleId != '00E70000001GBsB' ){  //Business Analyst{
                    trigger.old[0].addError('**** ERROR:  Only Directors and Admins may delete  child products from opportunities *****');
            }
        }*/
        }       
    }
    
    /*for(OpportunityLineItem OLIs: trigger.old){
        if(OLIs.IsPackageChild__c == true){
            trigger.old[0].addError('****You cannot delete package children****');
        }
    }*/
    
      //Ramana&Mark: 08/20/2014: Mark is looking into see if this czn be done in Validation Rules.
      // 08282014: Mark finished moving this to Validation rules; So commenting out.
      /*
    if(trigger.isAfter && trigger.isUpdate) {

        MAP<Id, Id> theseOpptyIds = new MAP<Id, Id>();      

        for(OpportunityLineItem theseOLIs : trigger.old) {

            theseOpptyIds.put(theseOLIs.OpportunityId, null);
            //theseOLIs.UserPriceChange__c = true;          
        }

        LIST<Opportunity> theseOpptys = new LIST<Opportunity>();        

        for(Opportunity O: [select Id, StageName, RecordType.Name
                            from Opportunity
                            where Id IN:theseOpptyIds.keySet()]) {
            
                
            if((O.StageName == 'Closed or Won' || O.StageName == 'Closed or Lost') && !O.RecordType.Name.toLowercase().startsWith('vauto')) {
                
                Id roleId = [SELECT UserRoleId FROM User WHERE Id = :UserInfo.getUserId()].UserRoleId;
                
                system.debug('Bazinga... lastmodifiedby roleid: ' + roleId);
                
                if(roleId != '00E70000001GBsB' &&  //Business Analyst
                   roleId != '00E70000001GJu5' &&  //CRM Systems Administrator
                   roleId != '00E70000001GE8B' &&  //Salesforce Developer
                   roleId != '00E70000001G9uk' &&  //Consumer Campaign Marketing Manager
                   roleId != '00E70000001GJrp' &&  //Director of Inside Sales
                   roleId != '00E70000000wHfS' &&  //VP of Sales
                   roleId != '00E70000001CFeO' && //Director of Training
                   roleId != '00E70000001GB6f' && //Training Coordinator
                   roleId != '00E70000001HAge' && //Corporate Trainer
                   roleId != '00E70000001GMm9') {  //Developer (API)
                        
                    trigger.new[0].addError('**** ERROR: Cannot change Products on a Closed Opportunity ****');
                }
            }
            
        }
        
        
        
    }
    */
    
     //Ramana&Mark: 08/20/2014: Mark is looking into see if this czn be done in Validation Rules.
     // 08282014: Mark finished moving this to Validation rules; So commenting out.
     /*
    if(trigger.isAfter && trigger.isInsert) {

        MAP<Id, Id> theseOpptyIds = new MAP<Id, Id>();      

        for(OpportunityLineItem theseOLIs : trigger.new) {

            theseOpptyIds.put(theseOLIs.OpportunityId, null);           
        }

        LIST<Opportunity> theseOpptys = new LIST<Opportunity>();        

        for(Opportunity O: [select Id, StageName 
                            from Opportunity
                            where Id IN:theseOpptyIds.keySet()]) {
            
            
            if(O.StageName == 'Closed or Won' || O.StageName == 'Closed or Lost') {
                
                system.debug('Bazinga... createdbyid: ' + trigger.new[0].CreatedById);
                
                system.debug('Bazinga... lastmodifiedbyid: ' + trigger.new[0].LastModifiedById);
                
                
                
                Id roleId = [SELECT UserRoleId FROM User WHERE Id = :UserInfo.getUserId()].UserRoleId;
                
                system.debug('Bazinga... lastmodifiedby roleid: ' + roleId);
                
                if(roleId != '00E70000001GBsB' &&  //Business Analyst
                   roleId != '00E70000001GJu5' &&  //CRM Systems Administrator
                   roleId != '00E70000001GE8B' &&  //Salesforce Developer
                   roleId != '00E70000001G9uk' &&  //Consumer Campaign Marketing Manager
                   roleId != '00E70000001GJrp' &&  //Director of Inside Sales
                   roleId != '00E70000000wHfS' &&  //VP of Sales
                   roleId != '00E70000001GMm9') {  //Developer (API)
                        
                    trigger.new[0].addError('**** ERROR:  Cannot add Products to a Closed Opportunity ****');
                }
            }
        }
    }
    */
    
    
    if(trigger.isAfter && trigger.isDelete) {

        MAP<Id, Id> theseOpptyIds = new MAP<Id, Id>();

        MAP<Id, Id> theseOpptysWithPackagesDeleted = new MAP<Id, Id>();

        for(OpportunityLineItem theseOLIs : trigger.old) {

            theseOpptyIds.put(theseOLIs.OpportunityId, null);

            if(theseOLIs.ProductIsParent__c == 'T') {

                theseOpptysWithPackagesDeleted.put(theseOLIs.OpportunityId,null);
            }
        }

        if(theseOpptysWithPackagesDeleted != null) {

            LIST<OpportunityLineItem> OLIsToClear = [select Id, OpportunityId from OpportunityLineItem where OpportunityId IN: theseOpptysWithPackagesDeleted.keyset()];

            delete OLIsToClear;
        }

        

        LIST<Opportunity> theseOpptys = new LIST<Opportunity>();

        for(Opportunity O : [select Id, Cloned_with_Products__c 
                             from Opportunity
                             where Id IN :theseOpptyIds.keySet()]) {

            O.Cloned_with_Products__c = false;

            theseOpptys.add(O);
        }       

        try {

            update theseOpptys;
        }
        catch(Exception Ex) {
            String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';
            Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
            String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'paul.duryee@vinsolutions.com'};
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('dean.lukowski@vinsolutions.com');
            mail.setSubject('OLI Insert Error for ' + theseOpptys[0].Id);
            mail.setPlainTextBody('OLI Error ' + theseOpptys[0].Id + '<br /> Error: ' + Ex);
            mail.setHtmlBody('OLI Error for opportunity <a href=' + fullURL + theseOpptys[0].Id + '>' +
            theseOpptys[0].Id + '</a><br /> Error:' + Ex);

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

            system.debug(Ex);
        }
    }

    
/*Ramana 08/21/2014: Commented to find more details on its use
    if(trigger.isBefore && trigger.isInsert) {

        MAP<Id, Id> theseOpptyIds = new MAP<Id, Id>();

        for(OpportunityLineItem theseOLIs : trigger.new) {

            theseOpptyIds.put(theseOLIs.OpportunityId, null);           
        }

        LIST<Opportunity> theseOpptys = [select Id, Cloned_with_Products__c
                                         from Opportunity
                                         where Id IN :theseOpptyIds.keySet()];
        

        for(OpportunityLineItem OLI : trigger.new) {

            if(OLI.StickyOpportunityID__c == null) {

                OLI.StickyOpportunityID__c = OLI.OpportunityId;

                for(Opportunity O : theseOpptys) {

                    if(O.Id == OLI.OpportunityId) {

                        O.Cloned_with_Products__c=false;
                    }
                }
            }
            else if(OLI.StickyOpportunityId__c != null) {

                for(Opportunity O : theseOpptys) {

                    if(O.Id == OLI.OpportunityId) {

                        O.Cloned_with_Products__c = true;
                    }
                }
            }
        }

        try {
            
            update theseOpptys;
        }
        catch(Exception Ex) {
            String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';
            Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
            String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'mark.ross@vinsolutions.com'};
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('dean.lukowski@vinsolutions.com');
            mail.setSubject('OLI Insert Error for ' + theseOpptys[0].Id);
            mail.setPlainTextBody('OLI Error ' + theseOpptys[0].Id + '<br /> Error: ' + Ex);
            mail.setHtmlBody('OLI Error for opportunity <a href=' + fullURL + theseOpptys[0].Id + '>' + theseOpptys[0].Id + '</a><br /> Error:' + Ex);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            system.debug(Ex);
        }
    }
    
    */
    

    if(trigger.isafter && trigger.isInsert) {

        //Find out if any of the Products being added are "website" products
        //and if so, update the "Includes_Website_Product__c" field on the 
        //parent opportunity of the product being added.        

        MAP<Id, OpportunityLineItem> theseOLIOpptys = new MAP<Id, OpportunityLineItem>();

        LIST<Opportunity> parentOppty = new LIST<Opportunity>();

        for(OpportunityLineItem OLI : Trigger.new) {

            theseOLIOpptys.put(OLI.OpportunityId, OLI);
        }

        LIST<Opportunity> theseOpportunities = [select id, Includes_Website_Product__c
                                                from Opportunity
                                                where id IN :theseOLIOpptys.keyset()];  
        
/*
			Ramana&Mark: 08-20-2014: Will maka aRollUp SUmmary field to control Includes_Website_Product__c to be true of false. 
        for(OpportunityLineItem OLI : Trigger.new) {

			
            if(OLI.ProductDescription__c != null) {

                string lowerADescription = OLI.ProductDescription__c.toLowerCase();

                if(lowerADescription.contains('website')) { 

                    for(Opportunity thisOppty : theseOpportunities) {

                        if(thisOppty.Id == OLI.OpportunityId) {

                            thisOppty.Includes_Website_Product__c = True;

                            parentOppty.add(thisOppty);
                        }
                    }

                    try {

                        update parentOppty;
                    }
                    catch(Exception Ex) {
                        String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';
                        Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
                        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'mark.ross@vinsolutions.com'};
                        mail.setToAddresses(toAddresses);
                        mail.setReplyTo('dean.lukowski@vinsolutions.com');
                        mail.setSubject('OLI Insert Error for ' + parentOppty[0].Id);
                        mail.setPlainTextBody('OLI Error ' + parentOppty[0].Id + '<br /> Error: ' + Ex);
                        mail.setHtmlBody('OLI Error for opportunity <a href=' + fullURL + parentOppty[0].Id + '>' +
                        parentOppty[0].Id + '</a><br /> Error:' + Ex);

                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

                        system.debug(Ex);
                    }               
                }

                parentOppty.clear();
            }
        

        }
    */
        

        LIST<OpportunityLineItem> childProductsToInsert = new LIST<OpportunityLineItem>();

        

        for(OpportunityLineItem OLI : trigger.new) {

            //Determine if the product being added is the Parent Product of a package,
            //and if so, find all of the related child products.

            //Ramana:08/21/2014 -Mark confirmed IsBeingCloned__c is from Smart clone
            if(OLI.ProductIsParent__c == 'T' && OLI.IsBeingCloned__c == false) {                            
                
                system.debug('Bazinga... ProductIsParent and Not Being Cloned');
                
                //WARNING!!:
                //This next section contains 3 queries inside of the for loop.  This is NOT best practice;
                //however, it might not be possible to properly pull out the information needed to generate the
                //proper list of products to be added.  Due to time, I was unable to write a better replacement
                //for this; however, it doesn't appear to throw any errors presently -- this may not be the case
                //in the future if there are any modifications to the code.

                //The reason it was done like this in the first place is because of the governing limitations that 
                //Salesforce has on the number of query rows it will pull (MAX 100).  Trying to pull all of the data
                //without determining whether or not it even needs to be pulled for the product being added could
                //result in meeting/exceeding these governing limits.  While the below code is not proper and would
                //prevent multiple package parent products from being added at 1 time, it is more likely that only 
                //1 parent package product will be added to an opportunity at a time, and therefore less likely that
                //the governing limit of 20 SOQL queries will be reached.   

                //Query the related information for this line item (i.e. Pricebook Id, PricebookEntry Id, Oppty Id)

                OpportunityLineItem O = [Select o.OpportunityId, o.Opportunity.Parent_Clone_ID__c, o.Opportunity.Cloned_with_products__c,
                                                o.PricebookEntry.Product2Id, OpportunityLineItem.ProductIsParent__c, 
                                                o.PricebookEntry.Pricebook2Id, o.PricebookEntryId, One_Time_Fee__c 
                                         From OpportunityLineItem o
                                         where o.Id =:OLI.Id];      

                //If the Opportunity is not being cloned from a parent or is being cloned without Products              

                if(O.Opportunity.Parent_Clone_ID__c == O.OpportunityId || O.Opportunity.Cloned_with_products__c == false) { 

                    //Find the proper Product id and Package Field for the line item being added

                    Product2 p = [select id, Package__c, Package_Discount_Percentage__c, Family  
                                  from Product2 
                                  where id = :O.PricebookEntry.Product2Id limit 1]; 

                    //Map a list of Product Ids for products that are included in the Parent Product Package
                    //(i.e. if a parent product package__c field == "Silver 1" then find all non-parent 
                    //products that include "Silver 1" in the package field).

                    Map<Id, Product2> productList = new Map<Id, Product2>([select id , Family
                                                                           from Product2 
                                                                           where Product2.IsPackageParent__c =false 
                                                                           and IsActive = true 
                                                                           and Package__c includes(:p.Package__c)]);                

                    //Go through and collect the PriceBookEntry info within this pricebookinfo for all of the products 
                    //in the Map (all child products).

                    for(PricebookEntry PBE : [select id, UnitPrice, PricebookEntry.Product2.IsPackage__c, PricebookEntry.Product2.Child_Product_No_Cost_Override__c, PricebookEntry.Product2.Family
                                              from PricebookEntry
                                              where Pricebook2Id = :O.PricebookEntry.Pricebook2Id 
                                              and PricebookEntry.IsActive = true 
                                              and Product2Id in :productList.keySet()]) {   

                        //For each product in the list, use the queried pricebookEntry info
                        //to build a list of new products to be added

                        OpportunityLineItem child = new OpportunityLineItem();                  

                        child.OpportunityId = OLI.OpportunityId;
                        child.PricebookEntryId = PBE.id;
                        child.Quantity = OLI.Quantity;
                        //01s70000000McD6 (2013 PROD), 01s70000000MvXN (2014 PROD), 01sS00000008rK9 (2014 Sandbox), 01s190000004jJm (Canada Sandbox)
                        if(PBE.Product2.IsPackage__c != true && PBE.Product2.Child_Product_No_Cost_Override__c != true && PBE.Product2.Family != 'One Time' && (OLI.Price_Book_ID__c == '01s70000000McD6' || OLI.Price_Book_ID__c == '01s70000000MvXN' || OLI.Price_Book_ID__c == '01s190000004jJm')) {
                            //if(OLI.Price_Book_ID__c == '01sS00000008rK9'){//PROD: 01s70000000McD6 Sandbox: 01sS00000008rK9
                                system.debug('Bazinga1');
                                if(p.Package_Discount_Percentage__c == null){
                                    system.debug('Bazinga2');
                                    p.Package_Discount_Percentage__c = 100;
                                    decimal percentage = p.Package_Discount_Percentage__c * .01;
                                    child.UnitPrice = (PBE.UnitPrice * percentage).setscale(2);
                                    child.Package_Discount_Percentage__c = p.Package_Discount_Percentage__c;    
                                    child.IsPackageChild__c=True;
                                    child.Source_Package_Product__c=p.Id;
                                    system.debug('Bazinga3');
                                    if(PBE.Product2.Family == 'One Time'){
                                        child.UnitPrice = 0.00;
                                        child.IsPackageChild__c = true;
                                    }
                                    
                                }
                                else if(p.Package_Discount_Percentage__c != null){
                                    system.debug('Bazinga4');
                                    decimal percentage = p.Package_Discount_Percentage__c * .01;
                                    child.UnitPrice = (PBE.UnitPrice * percentage).setscale(2);
                                    child.Package_Discount_Percentage__c = p.Package_Discount_Percentage__c;    
                                    child.IsPackageChild__c=True;
                                    child.Source_Package_Product__c=p.Id;
                                    
                                }
                            //}
                            /*else if(OLI.Price_Book_ID__c == '01s70000000MZ4f'){
                                system.debug('Bazinga5');
                                child.UnitPrice = 0.00;
                                child.IsPackageChild__c = true;
                            }*/
                            
                        }
                        

                        else if(PBE.Product2.IsPackage__c != true && PBE.Product2.Child_Product_No_Cost_Override__c == true) {

                            child.UnitPrice = PBE.UnitPrice;
                            child.Non_Monthly_Created_by_Pkg__c = TRUE;
                            child.Source_Package_Product__c=p.Id;
                            system.debug('Bazinga8');                           
                        }
                        
                        else {
                            system.debug('Bazinga6');
                            child.UnitPrice = PBE.UnitPrice;
                            child.Non_Monthly_Created_by_Pkg__c = TRUE;
                            child.Source_Package_Product__c=p.Id;
                        }
                        //Production if statement including all needed PB IDs
                        if(PBE.Product2.IsPackage__c != true && PBE.Product2.Child_Product_No_Cost_Override__c != true && OLI.Price_Book_ID__c == '01s70000000MZ4f'  ||OLI.Price_Book_ID__c == '01s70000000Mc9Y' || OLI.Price_Book_ID__c == '01s70000000MWpT' || OLI.Price_Book_ID__c == '01s70000000MaLr' || OLI.Price_Book_ID__c == '01s70000000McD1' || OLI.Price_Book_ID__c == '01s70000000Mdtc')
                        //sandbox if statement
                        //if(PBE.Product2.IsPackage__c != true && PBE.Product2.Child_Product_No_Cost_Override__c != true && OLI.Price_Book_ID__c == '01s70000000MZ4f' || OLI.Price_Book_ID__c == '01s70000000MWpT')
                         {
                            system.debug('Bazinga10');
                            child.UnitPrice = 0.00;
                            child.IsPackageChild__c = true;
                        }                   

                        childProductsToInsert.add(child);
                            
                    }
                                        
                }       
            }
        }

        try {

            insert childProductsToInsert;
        }
        catch(Exception Ex) {
            String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';
            Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
            String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'paul.duryee@vinsolutions.com'};
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('dean.lukowski@vinsolutions.com');
            mail.setSubject('OLI Insert Error for ' + childProductsToInsert[0].opportunityId);
            mail.setPlainTextBody('OLI Error ' + childProductsToInsert[0].opportunityId + '<br /> Error: ' + Ex);
            mail.setHtmlBody('OLI Error for opportunity <a href=' + fullURL + childProductsToInsert[0].opportunityId + '>' +
            childProductsToInsert[0].opportunityId + '</a><br /> Error:' + Ex);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

            system.debug(Ex);
        }   
    }
}