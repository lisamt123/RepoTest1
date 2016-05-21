public class salesQuotes {
	public SFDC_520_Quote__c quote { get; private set;} 
    public SFDC_520_QuoteLine__c[] quoteLineItems { get; private set; }
    public Opportunity opp { get; private set; }  
    public Boolean hasContact { get { return (opp.opportunityContactRoles.size()  == 1);} }
    public Contact contact { get; private set; }  

    private ApexPages.StandardController controller;
    
      // constructor, loads the quote and any opportunity lines
    void queryQuoteLines(id id) { 
    	quote = [  Select s.Opportunity__r.Pricebook2Id, Quote_Amount_rollup__c,
 					(Select Unit_Price__c, Unit_Net_Price__c, ServiceDate__c, Sales_Discount__c, 
 					Quote__c, Qty_Ordered__c, Product2__c, Product2__r.Name, Name, Id, Ext_Price__c, 
 					Ext_Net_Price__c, Ext_Price_tmp__c, Description__c  From Quote_Lines__r
 					order by name ), 
	 		s.Opportunity__r.HasOpportunityLineItem, s.Opportunity__r.Name, s.Name,
	 		s.Opportunity__r.Id, s.Opportunity__c  From SFDC_520_Quote__c s 
	 		where s.id = :id limit 1]; 
    	quoteLineItems = quote.Quote_Lines__r;  
    	for ( SFDC_520_QuoteLine__c ql : quoteLineItems ) { 
    		ql.Ext_Price_tmp__c = ql.Ext_Net_Price__c;
    		if ( ql.Sales_Discount__c == null ) ql.Sales_Discount__c = 0.0;
    	}
    }
    public opportunity total { get { 
		double amount = 0.0; 
		for ( SFDC_520_QuoteLine__c ql : quoteLineItems ) { 
    		amount += ql.Unit_Price__c * 
    			ql.Qty_Ordered__c * 
    			(1-(ql.Sales_Discount__c/100)) ; 
		} 
		Opportunity ret = new Opportunity( amount= amount ); 
		return ret;
	} }
	public pagereference CopyOperation() { 
		// implement copy to and from opportunity given page parameters
		string reloadQuote = ApexPages.CurrentPage().getParameters().get('reloadQuote');
    	string reloadOpp = ApexPages.CurrentPage().getParameters().get('reloadOpp');
    	
    	if ( reloadOpp != null ) { 
    		copyLineItemsFromQuoteToOppty(); 		
			return opportunityPR() ;	
    	}
    	if ( reloadQuote != null ) { 
    		copyLineItemsFromOpptyToQuote( ); 
    		return quotePR(); 
    	}
		return null;
	}
    public pagereference recalc() {
    	 
    	for ( SFDC_520_QuoteLine__c ql : quoteLineItems ) { 
    		ql.Ext_Price_tmp__c = ql.Unit_Price__c * 
    			ql.Qty_Ordered__c * 
    			(1-(ql.Sales_Discount__c/100)) ;
    			
    		// see if this is a new line, if so then, fill in a bit more info 
    		if ( ql.Product2__c != null && ql.product2__r == null ) { 
    			ql.product2__r = [ select id, name from Product2 where id = :ql.Product2__c limit 1];
    			//system.debug (	ql.product2__r );
    		}		
    	}
    	return null;
    }
    id quoteid; 
    public salesQuotes() {
    	quoteid = ApexPages.CurrentPage().getParameters().get('id');
    	init(); 
    }
    public salesQuotes(ApexPages.StandardController c) {
    	controller = c;
    	quoteid = c.getRecord().id;
    	init();
    } 
    
    // load up quote lines, opportunity lines, opportunity details and contact info
    void init() { 
 		queryQuoteLines(quoteid);
 		
 		if ( quote.opportunity__c != null ) {
            /* Set the related opportunity with the result of the query that traverses to account for display of the name
               and down to get the primary contact role. */
            opp = [select name, account.name,
                           (select contact.name, contact.mailingStreet, contact.mailingcity, contact.mailingstate, 
                                   contact.mailingpostalcode , contact.phone
                            from opportunityContactRoles 
                            where isPrimary = true)
                    from opportunity 
                    where id = :quote.opportunity__c];
            if ( hasContact ) {
            	contact = opp.opportunityContactRoles[0].contact;
            }
        }
	}

    /* The action method that will generate a PDF document from the QuotePDF page and attach it to 
       the quote provided by the standard controller. Called by the action binding for the attachQuote
       page, this will do the work and take the user back to the quote detail page. */
    public PageReference attachQuote() {
        /* Get the page definition */
        PageReference pdfPage = new PageReference( '/apex/quotePDF' );
        
        /* set the quote id on the page definition */
        pdfPage.getParameters().put('id',quote.id);
        
        /* generate the pdf blob */
        //Blob pdfBlob = pdfPage.getContent();
        
        /* create the attachment against the quote */
       //Attachment a = new Attachment(parentId = quote.id, name=quote.name + '.pdf', body = pdfBlob);
        
        /* insert the attachment */
       //insert a;
        
        /* send the user back to the quote detail page */
        return controller.view();
    }
    
	// copy lines from the oppportunity to this quote
	public void copyLineItemsFromOpptyToQuote() { 
		// delete any existing quote lines
		OpportunityLineItem[] olist;
		olist = [Select Id, OpportunityId, SortOrder, PricebookEntryId, Quantity, 
 			TotalPrice, UnitPrice, ListPrice, ServiceDate, Description, CreatedDate, 
 			CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
 			IsDeleted , PricebookEntry.Name, PricebookEntry.Product2id
 			From OpportunityLineItem 
 			where OpportunityId = :quote.Opportunity__c ];
 		
		// create new quote lines
		SFDC_520_QuoteLine__c[] qlines = new list<SFDC_520_QuoteLine__c>(); 
		for ( OpportunityLineItem oitem : olist) {
			SFDC_520_QuoteLine__c ql = new SFDC_520_QuoteLine__c(
				Quote__c = quote.id,
				Sales_Discount__c = 0.0,
				Qty_Ordered__c = oitem.Quantity,
				Unit_Price__c = oitem.UnitPrice,
				Description__c = oitem.Description,
				ServiceDate__c = oitem.ServiceDate,
				Product2__c = oitem.PricebookEntry.Product2id
				); 
			qlines.add(ql); 	
		}
		
		delete quote.Quote_Lines__r; 
		if ( qlines.size() > 0 ) {
			insert qlines;
		}
		
	}
	
	void makeQuotePrimary() { 
 		sobject[] allquotes =  Database.query( 'Select  s.Opportunity__c, S.ID, s.name '+
     		' From SFDC_520_Quote__c s  where s.Opportunity__c = \''+ quote.Opportunity__c + '\' ' );
     	for ( sobject so : allquotes) { 
     		if ( so.get('Id') == quote.id ) {
     			so.put('Primary__c',true); 	
     		} else { 
     			so.put('Primary__c',false); 	
     		}
     	}
     	update allquotes;
 	}
	 
	public void copyLineItemsFromQuoteToOppty() {
    
    	// find the appropriate pricebookentries for each product2 id
	    List<ID> productIdList = new List<ID>();
	    for (SFDC_520_QuoteLine__c q : quoteLineItems) {
	        productIdList.add((id) q.get('Product2__c'));
	    }
	    
	    List<PricebookEntry> priceBookEntries = [Select id, Product2Id, Pricebook2Id From PricebookEntry
	                                             where pricebook2id = :quote.Opportunity__r.Pricebook2Id and
	                                             product2id in :productIdList];
	                                             
	    Map<Id,Id> productIdToPricebookEntryIdMap = new Map<Id,Id>();
	    
	    for(PricebookEntry p : pricebookEntries) {
	        productIdToPricebookEntryIdMap.put(p.product2Id, p.id);
	    }
	    
	    // clear out old opportunity line items
	    id opptyId = quote.Opportunity__r.id; 
	    List<OpportunityLineItem> oldLineItems = [select id 
	    	from OpportunityLineItem where opportunityId = :opptyId];
	    delete oldLineItems;
	    
	    // insert new ones
	    List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
 		for ( SFDC_520_QuoteLine__c s: quoteLineItems){ 
 			newLineItems.add(New OpportunityLineItem(opportunityId = opptyId,
                                                 quantity = (double) s.get('Qty_ordered__c'),
                                                 unitPrice =  (Double) s.get('Unit_Net_Price__c'),
                                                 pricebookEntryId = productIdToPricebookEntryIdMap.get((id)s.get('Product2__c')),
                                                 serviceDate = (date)s.get('serviceDate__c'),
                                                 description = (string)s.get('Description__c')
                                                 ));
 		}
 		system.debug(newLineItems);
 		insert newLineItems;
 		makeQuotePrimary(); // since we just overwrote the opp 
 	} 
 	
	PageReference opportunityPR() { return new pagereference('/'+quote.Opportunity__c); }
	PageReference quotePR() { return new pagereference('/'+quote.id); }
	public list<SFDC_520_QuoteLine__c> todelete = new list<SFDC_520_QuoteLine__c>();
	
	public PageReference del() {
    	
    	string delname = ApexPages.CurrentPage().getParameters().get('delname');
    	system.assert( delname != null );
    	integer gone = -1;
    	integer i = 0; 
    	
    	for ( i=0; i< quoteLineItems.size(); i++ ) { 
    		if (quoteLineItems[i].Name == delname) { 
    			gone = i;
    		} 	
    	}
    	if ( gone >= 0) { 
    		todelete.add(  quoteLineItems.remove(gone) );	
    	}
        return null;
    }
        
	public PageReference save() { 
		try { 
			
			upsert quoteLineItems;
			if ( todelete.size() > 0 ) {         	
        		delete todelete;	
        	}
			queryQuoteLines(quote.id);
		} 
		catch ( DmlException exc) { 
			 ApexPages.addMessages(exc); 
			 return null;
		}
		return quotePR(); 
	}
	
	/* TODO 
	 * public PageReference add() { return null;}
	 */
	public PageReference add() { 
		// insert a new line, after user selects a product?
		SFDC_520_QuoteLine__c q =  new SFDC_520_QuoteLine__c( Quote__c = quote.id,
		 Unit_price__c = 0.0, qty_ordered__c = 0.0, sales_discount__c = 0.0 ) ;
		quoteLineItems.add ( q );
		return null; 
	}
		 
	public PageReference reset() { 
		queryQuoteLines(quote.id);
		return null;
	}

 	/* 
 	 * test methods below here 
 	 */
	
	static testMethod void testQuoteApp() {
      // To begin, the sample application first creates the necessary records
      // to test OpportunityLineItems: Pricebook2, Product2, and PricebookEntry
      // First it creates a product with a standard price
      Product2 p = new product2(name='x');
      insert p;
      Pricebook2 stdPb = [select Id from Pricebook2 where isStandard=true limit 1];
      insert new PricebookEntry(pricebook2id = stdPb.id, product2id = p.id, 
                                unitprice=1.0, isActive=true);
      // Next, it creates a new pricebook with an entry for this product
      Pricebook2 pb = new pricebook2(name='test');
      insert pb;
      PricebookEntry pbe = new PricebookEntry(pricebook2id=pb.id, product2id=p.id, 
                                              unitprice=1.0, isActive=true);
      insert pbe;
      // To test the first example from the sample application, the test
      // method creates an opportunity line item using the pricebook entry,
      // and then asserts that the Color field was correctly copied from the
      // product after record insertion.
      Account a = [select Id from Account where VIN_District__c != null limit 1];
      Opportunity o = new Opportunity(name='test', pricebook2id=pb.id, AccountId=a.id,
      stageName='Open', CloseDate=Date.newInstance(2006,10,10));
      insert o;
      OpportunityLineItem oli = new OpportunityLineItem(opportunityid=o.id, 
                                pricebookentryid=pbe.id, unitprice=1.5, quantity=2);
      insert oli;
    
  	  // To test the fifth example from the sample application, the test method
      // creates a primary quote and then asserts that its Primary field cannot
      // be deselected. The code uses the try...catch testing idiom to assert
      // that the error message is correct.
      SFDC_520_Quote__c q = new SFDC_520_Quote__c(opportunity__c = o.id, primary__c = true);
      insert q;
      
   	}
	
	static testmethod void t1() {
		SFDC_520_Quote__c q = new SFDC_520_Quote__c(); 
		insert q;
		salesQuotes s = new salesQuotes( new ApexPages.StandardController(q ) );
	}

 	public static  testMethod  void test1() {
 		Product2 p = new product2(name='x');
	    insert p;
	    Pricebook2 stdPb = [select Id from Pricebook2 where isStandard=true limit 1];
      	insert new PricebookEntry(pricebook2id = stdPb.id, product2id = p.id, 
                                unitprice=1.0, isActive=true);
      	// Next, it creates a new pricebook with an entry for this product
      	Pricebook2 pb = new pricebook2(name='test');
      	insert pb;
      	PricebookEntry pbe = new PricebookEntry(pricebook2id=pb.id, product2id=p.id, 
                                              unitprice=1.0, isActive=true);
      	insert pbe;
 		
      Account a = [select Id from Account where VIN_District__c != null limit 1];
 	  	Opportunity o = new Opportunity(name='test', pricebook2id=pb.id, AccountId=a.id,
      	stageName='Open', CloseDate=Date.newInstance(2006,10,10));
      	insert o;
      	OpportunityLineItem oli = new OpportunityLineItem(opportunityid=o.id, 
                                pricebookentryid=pbe.id, unitprice=1.5, quantity=2);
      	insert oli;
 		
 		
 		SFDC_520_Quote__c q = new SFDC_520_Quote__c(Opportunity__c = o.id); 
		insert q;
 		
		PageReference pageRef = new PageReference('/apex/editQuoteLines');
        Test.setCurrentPage(pageRef);
    	system.debug( 'quote id is '+q.id);
    	
    	ApexPages.currentPage().getParameters().put('id', q.id);
    	
 		salesQuotes s = new salesQuotes();
 		ApexPages.currentPage().getParameters().put('reloadQuote','1');
 		s.CopyOperation(); 
 		
		s.save(  ) ;
 		system.debug ( s.total );
 		system.assertEquals(  3.0, s.total.amount );
 		system.assert( s.opportunityPR() != null ); 
 		
 		system.debug ( s.quoteLineItems );
 		s.quoteLineItems = Database.query( 
    		' Select s.Unit_Price__c, s.Unit_Net_Price__c, s.ServiceDate__c, s.Ext_Net_Price__c,'+
    		' s.Sales_Discount__c, s.Quote__c, s.Qty_Ordered__c, s.Product2__c, s.Name, '+
    		' s.Id, s.Description__c  From SFDC_520_QuoteLine__c s '+
    	 	' where Quote__c = \''+ s.quote.Id+'\' ');
    	system.debug ( s.quoteLineItems );	
 		s.recalc(); 		
 		s.copyLineItemsFromQuoteToOppty();
 		ApexPages.currentPage().getParameters().put('reloadQuote','1');
 		s.CopyOperation(); 
 		ApexPages.currentPage().getParameters().put('reloadOpp','1');
 		s.CopyOperation(); 
 		
 		try { s.attachQuote(); } catch( System.NullPointerException npe) { }  
 		
 		ApexPages.currentPage().getParameters().put('delname', s.quoteLineItems[0].name );
 		s.del();
 		s.save(); 
 		s.reset();
 		
 		ApexPages.CurrentPage().getParameters().put('reloadOpp',null );
 		ApexPages.CurrentPage().getParameters().put('reloadQuote',null );
 		salesQuotes s3 = new salesQuotes();
 		system.assertEquals( null, s3.CopyOperation() ); 
 	}		
}