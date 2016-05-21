public with sharing class vAutoHierarchyStructure{

    //Declare variables
   private Static Integer LEVEL_LIMIT = 20;
     /**
    * Allow page to set the current ID
    */
    public string currentId {get;set;}


        private Integer totalLevels;
      public Integer Levels { get {return totalLevels;} }
  
    public List<ObjectStructureMap> asm;
    public List<ObjectStructureMap> getFinalasm()
    {
        if (asm == null || asm.isEmpty())
        {
            loadHierarchy();
        }
        return asm;
    }
    public Map<String, ObjectStructureMap> masm;
    public List<Integer> maxLevel;
    
    /**
    * Contructor
    */
    public vAutoHierarchyStructure() {
        this.asm = new List<ObjectStructureMap>{};
        this.masm = new Map<String, ObjectStructureMap>{};
        this.maxLevel = new List<Integer>{};
    }


  
   public PageReference loadHierarchy() {
    

     //System.debug('$$$$$$$$$$$$$$$$$$$$ hierarchyType changed = ' + specifiedhierarchyType );

        getObjectStructure();

        return null;
    }
    /**
    * Allow page to set the current ID
    */
  
    public void setcurrentId( String cid ){
        currentId = cid;
    }

    /**
    * Return ObjectStructureMap to page
    * @return asm
    */
    public List<ObjectStructureMap> getObjectStructure(){
    
        asm.clear();
        if ( currentId == null ) {
            currentId = System.currentPageReference().getParameters().get( 'id' );
           
        }
        System.assertNotEquals( currentId, null, 'sObject ID must be provided' );
        asm = formatObjectStructure( currentId);
          //System.debug('END getObjectStructure hierarchtType = ' + specifiedhierarchyType );
        return asm;
    }
    


    /**
    * Query Account from top down to build the ObjectStructureMap
    * @param currentId
    * @return asm
    */
    public ObjectStructureMap[] formatObjectStructure( String currentId){
    
      System.debug('loading Hierarchy with currentId= ' + currentId );
        List<ObjectStructureMap> asm = new List<ObjectStructureMap>{};
        masm.clear();

        //Change below
         List<HierarchyObject> al            = new List<HierarchyObject>{};
        List<Account> hal            = new List<Account>{};
        List<ID> currentAccountParent      = new List<ID>{};
        Map<ID, String> nodeList    = new Map<ID, String>{};
        List<String> nodeSortList   = new List<String>{};
        List<Boolean> levelFlag     = new List<Boolean>{};
        List<Boolean> closeFlag     = new List<Boolean>{};
        String nodeId               = '0';
        String nodeType             = 'child';
        Integer count               = 0;
        Integer level               = 0;
        Boolean endOfStructure      = false;
        //Find highest level obejct in the structure
        
         Id currentObjectId = Id.valueOf(GetTopElement( currentId ));
   
                                currentAccountParent.add(currentObjectId);    
                 
        

        //Loop though all children
        while ( !endOfStructure ){
        
        System.Debug('Level: '+ level +'; Size of ParentAccounts : '+ String.valueOf(currentAccountParent.size())); 
            
            for ( Integer i = 0 ; i < currentAccountParent.size(); i++ ){
            
                 System.Debug('Account '+i +': '+currentAccountParent[i]);
                       
            }

                        if( level == 0 ){
            
            System.debug('Level 0');

                 
                 hal = [ SELECT a.Id,a.Type, a.vAuto_Parent_Account__c, a.OwnerId, a.Name
                 ,a.vAuto_Type__c                 
                 //,a.vAuto_Spend__c
                 //,a.vAuto_Status__c
                 //,a.vAuto_Products__c
                 ,a.vAuto_Perf_ManagerName__c
                 ,a.ShippingCity,a.ShippingState   
                 ,a.vAuto_Provision_type__c
                 ,a.vAuto_Conquest_type__c
                 ,a.vAuto_KBB_PAR_Type__c
                 ,a.vAuto_Auction_Genius_Type__c
                 ,a.Stockwave_Type__c
                 ,a.LogicalId__c
                 ,a.vAuto_POA__r.Account_Director__r.Name 
                 ,a.vAuto_POA__r.VAT_Strategic_Account__c                 
                 FROM Account a WHERE a.id IN : currentAccountParent ORDER BY a.Name ];
                
                if(hal != null){ 
               for ( Integer i = 0 ; i < hal.size(); i++ ){
                    //Change below
                    
                    HierarchyObject a = new HierarchyObject();
                    a.Id = hal[i].Id;
                    a.Name = hal[i].Name;
                    a.Type= hal[i].vAuto_Type__c;
                    a.SFType =  hal[i].Type;
                    a.ParentId = null;
                    //List<String> args = new String[]{'0','number','###,###,##0.00'};
                    
                    //if(hal[i].vAuto_Spend__c == NULL){hal[i].vAuto_Spend__c = 0; }
                    //a.vAutoSpend = String.format(hal[i].vAuto_Spend__c.format(), args);
                    //a.vAutoStatus = hal[i].vAuto_Status__c;                   
                    //a.vAutoProducts = formatProductStatus(hal[i].vAuto_Products__c);
                    a.vAutoProvisionType = hal[i].vAuto_Provision_type__c;
                    a.vAutoConquestType = hal[i].vAuto_Conquest_type__c;
                    a.vAutoKBBPARType = hal[i].vAuto_KBB_PAR_Type__c;
                    a.vAutoAuctionGeniusType = hal[i].vAuto_Auction_Genius_Type__c;
                    a.StockwaveType = hal[i].Stockwave_Type__c;
                    
                    a.ShippingState = hal[i].ShippingState;
                    a.ShippingCity = hal[i].ShippingCity;
                    a.PerformanceManager = hal[i].vAuto_Perf_ManagerName__c;
                    a.Director = hal[i].vAuto_POA__r.Account_Director__r.Name;
                    a.vAutoLogicalId = hal[i].LogicalId__c;
                    a.strategicAccount = hal[i].vAuto_POA__r.VAT_Strategic_Account__c;
                /*    System.Debug('Finding AccountTeamMembers'); 
                   List<Account> accountTeamMembers =  [Select (Select Id, UserId, TeamMemberRole From AccountTeamMembers  where TeamMemberRole  =: 'VAT Performance Manager') From Account a where a.Id =: hal[i].Id];
                        
                       if(accountTeamMembers[0].AccountTeamMembers.size() > 0)
                       {
                         System.Debug('Finding User account of the AccountTeamMember'); 
                         List<User> performanceManager = [Select u.Id, u.User_Full_Name__c From User u where u.Id =:accountTeamMembers[0].AccountTeamMembers[0].UserId ];
                         if(performanceManager.size()>0)
                         {
                          System.Debug('Performace ManagerUser Name: '+performanceManager[0].User_Full_Name__c); 
                         a.PerformanceManager = performanceManager[0].User_Full_Name__c;
                         }
                        }
                        */
                        
                   
                   
                    
                    al.add(a);
                    }
                    }
                    
                                 
                             
                System.Debug('Size of Accounts Children : '+ String.valueOf(hal.size())); 
                      
                                System.Debug('Size of All Children from Relations: '+ String.valueOf(al.size()));
                
            } 
            else {
       
        
         System.Debug('Level: '+level);
        List<String> tempAccountIds = new List<String>();
                List<String> tempGroupIds = new List<String>();
                  
                  //If the limit is over return   
                  System.debug('Limits.getQueries()  at Level :'+level+ ' is : '+Limits.getQueries())  ;    
                  if( Limits.getQueries() + 1 >= Limits.getLimitQueries()){
                  	hal = null;
                  	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Tree is not complete, stopping for system performance reasons,please contact your administrator with issue.'));
                  } 
                  else{
                           
                 hal = [ SELECT a.Type, a.vAuto_Parent_Account__c, a.OwnerId, a.Name, a.Id ,a.vAuto_Type__c,a.vAuto_Spend__c,a.vAuto_Status__c
                 ,a.vAuto_Products__c
                 ,vAuto_Perf_ManagerName__c
                 ,a.ShippingCity,a.ShippingState  
                 ,a.vAuto_Provision_type__c
                 ,a.vAuto_Conquest_type__c
                 ,a.vAuto_KBB_PAR_Type__c
                 ,a.vAuto_Auction_Genius_Type__c
                 ,a.Stockwave_Type__c  
                 ,a.vAuto_Parent_Account__r.Name
                 ,a.LogicalId__c
                 ,a.vAuto_POA__r.Account_Director__r.Name
                 ,a.vAuto_POA__r.VAT_Strategic_Account__c                      
                 FROM Account a WHERE a.vAuto_Parent_Account__c IN : currentAccountParent ORDER BY a.Name ];
                 
                 //check if there is a repetition
                 Boolean repeatedAccounts = false; 
                 Account repeatedAccount;
                 for(Account a : hal){
                 
                 if(nodeList.containsKey(a.Id)){ repeatedAccounts = true; repeatedAccount = a; break;} 
                 }
                 if(repeatedAccounts){
                 	
                 	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Invalid Parent-Child relation, Account: '+repeatedAccount.Name +' as a child of Account: '+repeatedAccount.vAuto_Parent_Account__r.Name + ' is invalid; since Account:  '+repeatedAccount.Name+ ' already appreared as a parent/grandparent.'));
                 	
                 	   hal = [ SELECT a.Type, a.vAuto_Parent_Account__c, a.OwnerId, a.Name, a.Id ,a.vAuto_Type__c,a.vAuto_Spend__c,a.vAuto_Status__c
                 ,a.vAuto_Products__c
                 ,vAuto_Perf_ManagerName__c
                 ,a.ShippingCity,a.ShippingState  
                 ,a.vAuto_Provision_type__c
                 ,a.vAuto_Conquest_type__c
                 ,a.vAuto_KBB_PAR_Type__c
                 ,a.vAuto_Auction_Genius_Type__c
                 ,a.Stockwave_Type__c
                 ,a.LogicalId__c
                 ,a.vAuto_POA__r.Account_Director__r.Name 
                 ,a.vAuto_POA__r.VAT_Strategic_Account__c                         
                 FROM Account a WHERE a.vAuto_Parent_Account__c IN : currentAccountParent and Id NOT IN: nodeList.keySet() ORDER BY a.Name ];
                 }
                 
                System.Debug('Size of Children Accounts: '+ String.valueOf(hal.size()));
                  }
                                                 if(hal != null){ 
               for ( Integer i = 0 ; i < hal.size(); i++ ){
                    
                    
                    HierarchyObject a = new HierarchyObject();
                    a.Id = hal[i].Id;
                    a.Name = hal[i].Name;
                    a.Type= hal[i].vAuto_Type__c;
                    a.SFType =  hal[i].Type;
                    //List<String> args = new String[]{'0','number','###,###,##0.00'};
                    //if(hal[i].vAuto_Spend__c == NULL){hal[i].vAuto_Spend__c = 0; }
                    //a.vAutoSpend = String.format(hal[i].vAuto_Spend__c.format(), args);
                    //a.vAutoStatus = hal[i].vAuto_Status__c;
                  
                   //a.vAutoProducts = formatProductStatus(hal[i].vAuto_Products__c);
  					a.vAutoProvisionType = hal[i].vAuto_Provision_type__c;
                    a.vAutoConquestType = hal[i].vAuto_Conquest_type__c;
                    a.vAutoKBBPARType = hal[i].vAuto_KBB_PAR_Type__c;
                    a.vAutoAuctionGeniusType = hal[i].vAuto_Auction_Genius_Type__c;
                    a.StockwaveType =hal[i].Stockwave_Type__c;
                    a.ShippingState = hal[i].ShippingState;
                    a.ShippingCity = hal[i].ShippingCity;
                    
                    a.ParentId = hal[i].vAuto_Parent_Account__c;
                    a.PerformanceManager = hal[i].vAuto_Perf_ManagerName__c;
                    a.Director = hal[i].vAuto_POA__r.Account_Director__r.Name;
                    a.vAutoLogicalId = hal[i].LogicalId__c;
                    a.strategicAccount = hal[i].vAuto_POA__r.VAT_Strategic_Account__c;
                    
                      /* System.Debug('Finding AccountTeamMembers'); 
                       List<Account> accountTeamMembers =  [Select (Select Id, UserId, TeamMemberRole From AccountTeamMembers  where TeamMemberRole  =: 'VAT Performance Manager') From Account a where a.Id =: hal[i].Id];
                       if(accountTeamMembers[0].AccountTeamMembers.size() > 0)
                       {
                       System.Debug('Finding User account of the AccountTeamMember'); 
                         List<User> performanceManager = [Select u.Id, u.User_Full_Name__c From User u where u.Id =:accountTeamMembers[0].AccountTeamMembers[0].UserId ];
                         if(performanceManager.size()>0)
                         {
                          System.Debug('Performace ManagerUser Name: '+performanceManager[0].User_Full_Name__c); 
                         a.PerformanceManager = performanceManager[0].User_Full_Name__c ;
                         }
                        }*/
                                                            
                    al.add(a);
                    }
               
                    }
                    
                  

                    
                    
                System.Debug('Size of All Children: '+ String.valueOf(al.size()));
            }

            if( al.size() == 0){
                endOfStructure = true;
            }
            else{
                
                currentAccountParent.clear();
                for ( Integer i = 0 ; i < al.size(); i++ ){
                   
                    
                    HierarchyObject a = al[i];
                    nodeId = ( level > 0 ) ? NodeList.get( a.ParentId)+'.'+String.valueOf( i ) : String.valueOf( i );
                    
                    System.Debug('Hirarchy nodeId : '+ nodeId );
                    
                    masm.put( NodeID, new ObjectStructureMap( nodeID, levelFlag, closeFlag, nodeType, false, false, a ) );
                
                    System.Debug('Added Account Id to Parent Account List: '+ a.id );
                    currentAccountParent.add( a.id );
                    
                    nodeList.put( a.id,nodeId );
                    nodeSortList.add( nodeId );
                }
                

                al.clear();
                maxLevel.add( level );                
                level++;
                totalLevels = level;
            }
        }
        
        //Account structure must now be formatted
        NodeSortList.sort();
        for( Integer i = 0; i < NodeSortList.size(); i++ ){
            List<String> pnl = new List<String> {};
            List<String> cnl = new List<String> {};
            List<String> nnl = new List<String> {};
            
            if ( i > 0 ){
                String pn   = NodeSortList[i-1];
                pnl         = pn.split( '\\.', -1 );
            }

            String cn   = NodeSortList[i];
            cnl         = cn.split( '\\.', -1 );

            if( i < NodeSortList.size()-1 ){
                String nn = NodeSortList[i+1];
                nnl = nn.split( '\\.', -1 );
            }
            
            ObjectStructureMap tasm = masm.get( cn );
            if ( cnl.size() < nnl.size() ){
                //Parent
                tasm.nodeType = ( isLastNode( cnl ) ) ? 'parent_end' : 'parent';
            }
            else if( cnl.size() > nnl.size() ){
                tasm.nodeType   = 'child_end';
                tasm.closeFlag  = setcloseFlag( cnl, nnl, tasm.nodeType );
            }
            else{
                tasm.nodeType = 'child';
            }
            
            tasm.levelFlag = setlevelFlag( cnl, tasm.nodeType ); 
            
            //Change below
            if ( tasm.account.id == currentId ) {
                tasm.currentNode = true;
            }
            asm.add( tasm );
        }
        
        if( asm.size() > 0 ){
        
        asm[0].nodeType             = 'start';
        asm[asm.size()-1].nodeType  = 'end';
        }
        
        return asm;
    }
    
    private String formatProductStatus(String input){
    	
    	try{
    	String formattedStatus = '';
    	if(input== null || input.trim() =='') {return formattedStatus;}
        List<String> allProductAndStatuses = input.split('\r\n');
       	for(String productStatus : allProductAndStatuses){
       			List<String> productAndStatus = productStatus.split(':');
       			if(productAndStatus ==null || productAndStatus.size()== 0){continue;}
       			if(productAndStatus.size()==1){
       				productAndStatus[1]='';
       			}
       			if(formattedStatus == ''){
       			formattedStatus = '<table class="list " border="0" cellpadding="0" cellspacing="0">';
       			//formattedStatus += '<tr class="headerRow"><th class="headerRow">Product</th><th class="headerRow">Status</th></tr>';
       			formattedStatus += '<tr  class="dataRow"><td class="dataCell">';
       			formattedStatus += productAndStatus[0].trim();
       			formattedStatus += '</td><td>';
       			formattedStatus += productAndStatus[1].trim();
       			formattedStatus += '</td></tr>';
       			}
       			else{
       			formattedStatus += '<tr  class="dataRow"><td class="dataCell">';
       			formattedStatus += productAndStatus[0].trim();
       			formattedStatus += '</td><td>';
       			formattedStatus += productAndStatus[1].trim();
       			formattedStatus += '</td></tr>';
       			}
       	}
       	if(formattedStatus!=''){
       		formattedStatus += '</table>';
       	}
       	
       	return formattedStatus;
    	} catch(Exception ex){
    		return input;
    	}
    }
    
    /**
    * Determin parent elements relationship to current element
    * @return flagList
    */
    public List<Boolean> setlevelFlag( List<String> nodeElements, String nodeType ){
        
        List<Boolean> flagList = new List<Boolean>{};
        String searchNode   = '';
        String workNode     = '';
        Integer cn          = 0;
        
        for( Integer i = 0; i < nodeElements.size() - 1; i++ ){
            cn = Integer.valueOf( nodeElements[i] );
            cn++;
            searchNode  = workNode + String.valueOf( cn );
            workNode    = workNode + nodeElements[i] + '.';
            if ( masm.containsKey( searchNode ) ){
                flagList.add( true );
            }
            else {
                flagList.add( false );
            }
        }
        
        return flagList;
    }
    
    /**
    * Determin if the element is a closing element
    * @return flagList
    */
    public List<Boolean> setcloseFlag( List<String> cnl, List<String> nnl, String nodeType ){
        
        List<Boolean> flagList = new List<Boolean>{};
        String searchNode   = '';
        String workNode     = '';
        Integer cn          = 0;
        
        for( Integer i = nnl.size(); i < cnl.size(); i++ ){
            flagList.add( true );
        }
        
        return flagList;
    }
    
    /**
    * Determin if Element is the bottom node  
    * @return Boolean
    */
    public Boolean isLastNode( List<String> nodeElements ){
        
        String searchNode   = '';
        Integer cn          = 0;
        
        for( Integer i = 0; i < nodeElements.size(); i++ ){
            if ( i == nodeElements.size()-1 ){
                cn = Integer.valueOf( nodeElements[i] );
                cn++;
                searchNode = searchNode + String.valueOf( cn );
            }
            else {
                searchNode = searchNode + nodeElements[i] + '.';
            }
        }
        if ( masm.containsKey( searchNode ) ){
            return false;
        }
        else{
            return true;
        }
    }
    
    /**
    * Find the tom most element in Heirarchy  
    * @return objId
    */
    public String GetTopElement( String objId ){
    	//TODO: This logic is hitting SOQL Query limit
    	//Need a better way to do this
    	//For now Limit the Level
      		
  		Integer loopCount=0;
  
              Boolean top = false;
        while (!top) {
        	loopCount++;
            //
            // Change below
            //
            System.debug('=================>>>>> objId = ' + objId);
            Account a = [Select a.id, a.vAuto_Parent_Account__c From Account a where a.id = :objId LIMIT 1];
            //
            
            if (a.vAuto_Parent_Account__c != null) {
                objId = a.vAuto_Parent_Account__c;
                if(loopCount>LEVEL_LIMIT){
                	 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Only showing: '+LEVEL_LIMIT+' Levels; for system performance reasons,please contact your administrator with issue.'));
                	 top=true;
                }
            }
            else {
                top=true;
            }
        }
        return objId ;
    }
    
    /**
    * Wrapper class
    */
        public with sharing class HierarchyObject{
        public Id Id {get; set;}
        public String Name {get; set;}   
        public String SFType {get; set;}
        public String Type {get; set;}
        public String Industry {get; set;}
        public String Owner {get; set;}
        public Id ParentId {get; set;}
        public String Monthlyspend {get; set;}
        public String BillingCity {get; set;}
        public String BillingState {get; set;}
        public String PerformanceManager {get; set;}
        public String Director {get;set;}
        public String ProvisionStatus {get; set;}
        public String ConquestStatus {get; set;}
        public String vAutoStatus {get; set;}
        public String vAutoSpend {get; set;}
        public String vAutoProducts {get; set;}
        public String ShippingCity {get; set;}
        public String ShippingState {get; set;}
        public String vAutoPerformanceManager {get; set;}
        public String vAutoProvisionType {get; set;}
        public String vAutoConquestType {get; set;}
        public String vAutoKBBPARType {get; set;}
        public String vAutoAuctionGeniusType {get; set;}
        public String StockwaveType {get;set;}
        public String vAutoLogicalId{get;set;}
        public Boolean strategicAccount{get;set;}
        }
    public with sharing class ObjectStructureMap{

        public String nodeId;
        public Boolean[] levelFlag = new Boolean[]{};
        public Boolean[] closeFlag = new Boolean[]{};
        public String nodeType;
        public Boolean currentNode;
        
        /**
        * @Change this to your sObject
        */
        public HierarchyObject account;
        
        public String getnodeId() { return nodeId; }
        public Boolean[] getlevelFlag() { return levelFlag; }
        public Boolean[] getcloseFlag() { return closeFlag; }
        public String getnodeType() { return nodeType; }
        public Boolean getcurrentNode() { return currentNode; }


        /**
        * @Change this to your sObject
        */
        public HierarchyObject getaccount() { return account; }
        
        public void setnodeId( String n ) { this.nodeId = n; }
        public void setlevelFlag( Boolean l ) { this.levelFlag.add(l); }
        public void setlcloseFlag( Boolean l ) { this.closeFlag.add(l); }
        public void setnodeType( String nt ) { this.nodeType = nt; }
        public void setcurrentNode( Boolean cn ) { this.currentNode = cn; }

        /**
        * @Change this to your sObject
        */
        public void setaccount( HierarchyObject a ) { this.account = a; }

        /**
        * @Change the parameters to your sObject
        */
        public ObjectStructureMap( String nodeId, Boolean[] levelFlag,Boolean[] closeFlag , String nodeType, Boolean lastNode, Boolean currentNode, HierarchyObject a ){
            
            this.nodeId         = nodeId;
            this.levelFlag      = levelFlag; 
            this.closeFlag      = closeFlag;
            this.nodeType       = nodeType;
            this.currentNode    = currentNode;

            this.account = a;
        }
    }
}