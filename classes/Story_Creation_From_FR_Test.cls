@isTest(SeeAllData=true)
private class Story_Creation_From_FR_Test {
    
    @isTest static void TestErrorMessagesWithMissingCR() {

        Test.startTest();

            ApexPages.standardController controller;
            Story_Creation_From_FR ctrl = new Story_Creation_From_FR(controller);
            // test for error message of missing CR
            List<Apexpages.Message> msgs = Apexpages.getMessages();
            Boolean b = false;
            for(Apexpages.Message msg : msgs){
                if(msg.getDetail().contains('No Change Request Id was found')) b = true;
            }
            System.assert(b);

        Test.stopTest();
    }

    @isTest static void CreateCRMissingFRAndIncorrectInfo() {
        // Create users for CR
        User testAdmin = TestData.setupUser();
        User testUser = TestData.setupUser('VinCare L1', 'Vin Support Level 1');
        insert testUser;
        // Create CR with Change Type first to fire error message that the CR is not a Feature or Break-Fix
        Change_Request__c testCR = new Change_Request__c(OwnerId = testUser.Id,
                                                         Severity__c = 'Inquiry, routine, minimal impact, feature',
                                                         Category__c = 'Functionality',
                                                         Sub_Category__c = 'Feature',
                                                         Approval_Status__c = 'Not Submitted',
                                                         Change_Type__c = 'Routine',
                                                         BU_Impact__c = 'No',
                                                         Amount_Affected_Users__c = 'None',
                                                         Data_Integrity_Affected__c = 'No',
                                                         Details__c = 'Creating a test change request for testing functional requirement assignment for story creation',
                                                         Viable_Workaround__c = 'No',
                                                         Critical_Functionality_Affected__c = 'No');
        insert testCR;

        Test.startTest();
        
            ApexPages.standardController controller;
            ApexPages.currentPage().getParameters().put('CRId', testCR.Id);
            Story_Creation_From_FR ctrl = new Story_Creation_From_FR(controller);
            
            // Error message for not a Feature or Break-fix
            List<Apexpages.Message> msgs = Apexpages.getMessages();
            Boolean b = false;
            for(Apexpages.Message msg : msgs){
                if(msg.getDetail().contains('must be set to Feature or Break-Fix')) b = true;
            }
            System.assert(b);

        Test.stopTest();

    }

    @isTest static void CreateCRBreakFixNoFRs() {
        
        // Create users for CR
        User testAdmin = TestData.setupUser();
        User testUser = TestData.setupUser('VinCare L1', 'Vin Support Level 1');
        insert testUser;
        // Create CR with Change Type first to fire error message that the CR is not a Feature or Break-Fix
        Change_Request__c testCR = new Change_Request__c(OwnerId = testUser.Id,
                                                         Severity__c = 'Inquiry, routine, minimal impact, feature',
                                                         Category__c = 'Functionality',
                                                         Sub_Category__c = 'Feature',
                                                         Approval_Status__c = 'Approved',
                                                         Change_Type__c = 'Break-Fix',
                                                         BU_Impact__c = 'No',
                                                         Amount_Affected_Users__c = 'None',
                                                         Data_Integrity_Affected__c = 'No',
                                                         Details__c = 'Creating a test change request for testing functional requirement assignment for story creation',
                                                         Viable_Workaround__c = 'No',
                                                         Critical_Functionality_Affected__c = 'No');
        insert testCR;
        List<Functional_Requirement__c> FRs = new List<Functional_Requirement__c>();

        Test.startTest();

            ApexPages.standardController controller;
            PageReference newPage = Page.Story_Creation_From_FR;
            Test.setCurrentPage(newPage);
            newPage.getParameters().put('id', testCR.Id);
            Story_Creation_From_FR ctrl = new Story_Creation_From_FR(controller);
            // Error message for missing FRs
            List<Apexpages.Message> msgs = Apexpages.getMessages();
            Boolean b = false;
            for(Apexpages.Message msg : msgs){
                if(msg.getDetail().contains('Functional Requirements need to be created')) b = true;
            }
            System.assert(b);

         Test.stopTest(); 

     }

    @isTest static void CreateCRBreakFix() { 

        // Create users for CR
        User testAdmin = TestData.setupUser();
        // Query your permission set name from Organization that your want to test.
        PermissionSet ps1 = [SELECT Id FROM PermissionSet WHERE Name = 'Agile_Accelerator_Admin'];
        // Assign the above inserted user for the above Permission Set.
        PermissionSetAssignment psa1 = new PermissionSetAssignment(AssigneeId = testAdmin.Id, PermissionSetId = ps1.Id);
        insert psa1;
        User testUser = TestData.setupUser('VinCare L1', 'Vin Support Level 1');
        insert testUser;
        // Query to pull the permission set into the database. Don't ask why, it just worked.
        System.debug('===================>>>>>>>>>>>>>> Permission Sets = ' + [Select Count() From PermissionSetAssignment Where AssigneeId =: testAdmin.Id]);

        Change_Request__c testCR = new Change_Request__c(OwnerId = testUser.Id,
                                                         Severity__c = 'Inquiry, routine, minimal impact, feature',
                                                         Category__c = 'Functionality',
                                                         Sub_Category__c = 'Feature',
                                                         Approval_Status__c = 'Approved',
                                                         Change_Type__c = 'Break-Fix',
                                                         BU_Impact__c = 'Yes',
                                                         Amount_Affected_Users__c = 'None',
                                                         Data_Integrity_Affected__c = 'No',
                                                         Details__c = 'Creating a test change request for testing functional requirement assignment for story creation',
                                                         Viable_Workaround__c = 'No',
                                                         Critical_Functionality_Affected__c = 'No');
        insert testCR;

        List<Functional_Requirement__c> FRs = new List<Functional_Requirement__c>();
        // Create FRs for CR
        Functional_Requirement__c fr1 = new Functional_Requirement__c(Change_Request__c = testCR.Id,
                                                                      Functional_Requirement__c = 'Creating FR 1',
                                                                      Technical_Requirement__c = 'Creating TR 1',
                                                                      User_Approval__c = true);
        FRs.add(fr1);
        Functional_Requirement__c fr2 = new Functional_Requirement__c(Change_Request__c = testCR.Id,
                                                                      Functional_Requirement__c = 'Creating FR 2',
                                                                      Technical_Requirement__c = 'Creating TR 2',
                                                                      User_Approval__c = true);
        FRs.add(fr2);
        insert FRs;

        System.runas(testAdmin) {
            Test.startTest();
            
                ApexPages.standardController controller;
                ApexPages.currentPage().getParameters().put('CRId', testCR.Id);
                Story_Creation_From_FR ctrl = new Story_Creation_From_FR(controller);

                ctrl.Save();
                // Check required fields
                System.assertEquals(ctrl.nrv.asArequired, true);
                System.assertEquals(ctrl.nrv.iNeedaRequired, true);
                System.assertEquals(ctrl.nrv.soThatICanRequired, true);
                System.assertEquals(ctrl.isValid, false);

                ctrl.WorkObj.As_a__c = 'Vin Support employeed';
                ctrl.WorkObj.I_need_a__c = 'Break-Fix story';
                ctrl.WorkObj.so_that_I_can__c = 'test that creating a Break-Fix story from this VF page works.';

                ctrl.Save();

                // Error message for creating a stroy without any FRs
                List<Apexpages.Message> msgs2 = Apexpages.getMessages();
                Boolean c = false;
                for(Apexpages.Message msg : msgs2){
                    if(msg.getDetail().contains('You cannot create a story without a Functional Requirement')) c = true;
                }
                System.assert(c);

                // Create the story
                ctrl.WorkObj.As_a__c = 'Vin Support employeed';
                ctrl.WorkObj.I_need_a__c = 'Break-Fix story';
                ctrl.WorkObj.so_that_I_can__c = 'test creating a Break-Fix story from this VF page works.';
                ctrl.frWrpList[0].selected = true;
                ctrl.frWrpList[1].selected = true;

                
                PageReference var1 = ctrl.Save();
                // If getting error messages on the below line, check that all Agile Accelerator records referenced in the the class have been created.
                // If the record is not saved or created it will throw a null exception error
                System.assertEquals(var1.getUrl(), '/'+testCR.Id);

            Test.stopTest();
        }
    }

    @isTest static void CreateCRFeature() {
        // Create users for CR
        User testAdmin = TestData.setupUser();
        //User testAdmin = [Select Id From User Where Id = '00570000003L0mn'];
        // Query your permission set name from Organization that your want to test.
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Agile_Accelerator_Admin'];
       
        // Assign the above inserted user for the above Permission Set.
        PermissionSetAssignment psa = new PermissionSetAssignment(AssigneeId = testAdmin.Id, PermissionSetId = ps.Id);
        insert psa;
        User testUser = TestData.setupUser('VinCare L1', 'Vin Support Level 1');
        testUser.CompanyName = 'VinSolutions';
        insert testUser;
        // Query to pull the permission set into the database. Don't ask why, it just worked.
        System.debug('===================>>>>>>>>>>>>>> Permission Sets = ' + [Select Count() From PermissionSetAssignment Where AssigneeId =: testAdmin.Id]);
        // Create CR with Change Type first to fire error message that the CR is not a Feature or Break-Fix
        Change_Request__c testCR = new Change_Request__c(OwnerId = testUser.Id,
                                                         Severity__c = 'Inquiry, routine, minimal impact, feature',
                                                         Category__c = 'Functionality',
                                                         Sub_Category__c = 'Feature',
                                                         Approval_Status__c = 'Approved',
                                                         Change_Type__c = 'Feature',
                                                         BU_Impact__c = 'No',
                                                         Amount_Affected_Users__c = 'None',
                                                         Data_Integrity_Affected__c = 'No',
                                                         Details__c = 'Creating a test change request for testing functional requirement assignment for story creation',
                                                         Viable_Workaround__c = 'No',
                                                         Critical_Functionality_Affected__c = 'No');
        insert testCR;
        List<Functional_Requirement__c> FRs = new List<Functional_Requirement__c>();
        // Create FRs for CR
        Functional_Requirement__c fr1 = new Functional_Requirement__c(Change_Request__c = testCR.Id,
                                                                      Functional_Requirement__c = 'Creating FR 1',
                                                                      Technical_Requirement__c = 'Creating TR 1',
                                                                      User_Approval__c = true);
        FRs.add(fr1);
        Functional_Requirement__c fr2 = new Functional_Requirement__c(Change_Request__c = testCR.Id,
                                                                      Functional_Requirement__c = 'Creating FR 2',
                                                                      Technical_Requirement__c = 'Creating TR 2',
                                                                      User_Approval__c = true);
        FRs.add(fr2);
        Functional_Requirement__c fr3 = new Functional_Requirement__c(Change_Request__c = testCR.Id,
                                                                      Functional_Requirement__c = 'Creating FR 3',
                                                                      Technical_Requirement__c = 'Creating TR 3',
                                                                      User_Approval__c = true);
        FRs.add(fr3);
        // Leaving one FR unapproved in order to fire custom validations
        Functional_Requirement__c fr4 = new Functional_Requirement__c(Change_Request__c = testCR.Id,
                                                                      Functional_Requirement__c = 'Creating FR 4',
                                                                      Technical_Requirement__c = 'Creating TR 4',
                                                                      User_Approval__c = false);
        FRs.add(fr4);
        insert FRs;

        System.runas(testAdmin) {
            Test.startTest();

                ApexPages.standardController controller;
                ApexPages.currentPage().getParameters().put('id', testCR.Id);
                Story_Creation_From_FR ctrl = new Story_Creation_From_FR(controller);
                // Error message for not having all FRs approved
                List<Apexpages.Message> msgs2 = Apexpages.getMessages();
                Boolean c = false;
                for(Apexpages.Message msg : msgs2){
                    if(msg.getDetail().contains('create any stories until they are all approved')) c = true;
                }
                System.assert(c);

                // Create the story
                ctrl.WorkObj.As_a__c = 'Vin Support employeed';
                ctrl.WorkObj.I_need_a__c = 'Feature story';
                ctrl.WorkObj.so_that_I_can__c = 'test creating a Feature story from this VF page works.';
                ctrl.frWrpList[0].selected = true;
                ctrl.frWrpList[1].selected = true;

                
                PageReference var1 = ctrl.SaveNew();
                // If getting error messages on the below line, check that all Agile Accelerator records referenced in the the class have been created.
                // If the record is not saved or created it will throw a null exception error
                System.assertEquals(var1.getUrl(), '/apex/Story_Creation_From_FR?CRId='+testCR.Id);

                // Delete existing story
                ApexPages.currentPage().getParameters().put('id', testCR.Id);
                Story_Creation_From_FR ctrl2 = new Story_Creation_From_FR(controller);

                ctrl2.viewStoryID = ctrl2.storyWrpList[0].stIdVal;
                ctrl2.recordView();
                ctrl2.removeStoryID = ctrl2.storyWrpList[0].stIdVal;
                ctrl2.StoryDelete();

                ApexPages.currentPage().getParameters().put('id', testCR.Id);
                Story_Creation_From_FR ctrl3 = new Story_Creation_From_FR(controller);

                // After the story is deleted, check that there are no existing stories
                System.assertEquals(ctrl3.storyWrpList, null);
                
                // Create a 2nd story
                ctrl3.WorkObj.As_a__c = 'Vin Support employeed';
                ctrl3.WorkObj.I_need_a__c = '2nd Feature story';
                ctrl3.WorkObj.so_that_I_can__c = 'test creating multiple Feature stories from this VF page works.';
                ctrl3.frWrpList[0].selected = true;
                ctrl3.frWrpList[1].selected = true;

                PageReference var2 = ctrl3.Save();
                System.assertEquals(var2.getUrl(), '/'+testCR.Id);

            Test.stopTest();
        }
    }
    
    
}