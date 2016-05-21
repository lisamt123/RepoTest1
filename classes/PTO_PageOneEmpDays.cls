public with sharing class PTO_PageOneEmpDays {
    
    public String totalApproved {get; Set;}
    public String totalApprovedEdit {get; set;}
    public String balName {get; Set;}
    public String balNameEdit {get; set;}
    public String avail {get; Set;}
    public String availEdit {get; set;}
    public String balId {get; Set;}
    public String balIdEdit {get; set;}
    public String myId {get; Set;}
    public String userName {get; Set;}
    public String userNameEdit {get; set;}
    public String recordId {get; set;}
    public String avail2015 {get; set;}
    public String totalApp2015 {get; set;}
    public SFDC_Paid_Time_Off__c pto {get; Set;}
    public SFDC_Paid_Time_Off__c ptoEdit {get; set;}
    public SFDC_Paid_Time_Off__c tor {get; set;}
    public String selectedPTOType {get; Set;}
    public String days {get; Set;}
    public String typePUPChoice {get; set;}
    public String lunches {get; set;}
    public String userId {get; Set;}
    public String partialTimeStart {get; set;}
    public String partialTimeEnd {get; set;}
    public String multiDayPartialDay1StartTime {get; set;}
    public String multiDayPartialDay1EndTime {get; set;}
    public String multiDayPartialDay2StartTime {get; set;}
    public String multiDayPartialDay2EndTime {get; set;}
    public String multiDayPartialDay3StartTime {get; set;}
    public String multiDayPartialDay3EndTime {get; set;}
    public String multiDayPartialDay4StartTime {get; set;}
    public String multiDayPartialDay4EndTime {get; set;}
    public String multiDayPartialDay5StartTime {get; set;}
    public String multiDayPartialDay5EndTime {get; set;}
    public Decimal partialDayHours {get; set;}
    public Decimal day1Hours {get; set;}
    public Decimal day2Hours {get; set;}
    public Decimal day3Hours {get; set;}
    public Decimal day4Hours {get; set;}
    public Decimal day5Hours {get; set;}
    public String fromDateString {get; set;}
    public String toDateString {get; set;}
    public Date day1Date {get; set;}
    public Date day2Date {get; set;}
    public Date day3Date {get; set;}
    public Date day4Date {get; set;}
    public Date day5Date {get; set;}
    public Decimal daysBetween {get; set;}
    public Integer sameWeek1 {get; set;}
    public Integer sameWeek2 {get; set;}
    public Date startOfWeekDate {get; set;}
    public Boolean sameWeekError {get; set;}
    public Boolean overEightHours {get; set;}
    public Integer monthStart {get; set;}
    public Integer monthEnd {get; set;}
    public decimal day1HoursDisplay {get; set;}
    public decimal day2HoursDisplay {get; set;}
    public decimal day3HoursDisplay {get; set;}
    public decimal day4HoursDisplay {get; set;}
    public decimal day5HoursDisplay {get; set;}
    public Boolean negativeTime {get; set;}
    public Boolean day1NegTime {get; set;}
    public Boolean day2NegTime {get; set;}
    public Boolean day3NegTime {get; set;}
    public Boolean day4NegTime {get; set;}
    public Boolean day5NegTime {get; set;}
    public Boolean day1OverEight {get; set;}
    public Boolean day2OverEight {get; set;}
    public Boolean day3OverEight {get; set;}
    public Boolean day4OverEight {get; set;}
    public Boolean day5OverEight {get; set;}
    public Boolean nullDate {get; set;}
    public Boolean nullDatePartial {get; set;}
    public Boolean nullDateMulti {get; set;}
    public Boolean partialTimeError {get; set;}
    public Boolean multi1TimeError {get; set;}
    public Boolean multi2TimeError {get; set;}
    public Boolean multi3TimeError {get; set;}
    public Boolean multi4TimeError {get; set;}
    public Boolean multi5TimeError {get; set;}
    public String lunch1 {get; set;}
    public String lunch2 {get; set;}
    public String lunch3 {get; set;}
    public String lunch4 {get; set;}
    public String lunch5 {get; set;}
    public Decimal totalMultiHours {get; set;}
    public decimal totalHoursPlaceholder {get; set;}
    public Decimal totalDays {get; set;}
    public decimal totalHours1 {get; set;}
    public decimal totalHours2 {get; set;}
    public decimal totalHours3 {get; set;}
    public decimal totalHours4 {get; set;}
    public decimal totalHours5 {get; set;}
    public decimal d1 {get; set;}
    public decimal d2 {get; set;}
    public decimal d3 {get; set;}
    public decimal d4 {get; set;}
    public decimal d5 {get; set;}
    public String day1StartTime {get; set;}
    public String day1EndTime {get; set;}
    public String day2StartTime {get; set;}
    public String day2EndTime {get; set;}
    public String day3StartTime {get; set;}
    public String day3EndTime {get; set;}
    public String day4StartTime {get; set;}
    public String day4EndTime {get; set;}
    public String day5StartTime {get; set;}
    public String day5EndTime {get; set;}
    public Boolean endBeforeStart {get; set;}
    public Boolean holidayDate {get; set;}
    public decimal totalAvailable {get; set;}
    public Boolean negHours {get; set;}
    public Boolean pd1Count {get; set;}
    public Boolean pd2Count {get; set;}
    public Boolean pd3Count {get; set;}
    public Boolean pd4Count {get; set;}
    public Boolean pd5Count {get; set;}
    public Boolean sameYearError {get; set;}
    public Boolean unpaidPaid {get; set;}
    public Boolean lunchNeg {get; set;}
    public String userProf {get; set;}
    public Boolean typeVisible {get; set;}
     
    
    public PTO_PageOneEmpDays(ApexPages.StandardController stdController){//constructor for pulling in values from start page - also pulling values for edit page
        
        this.pto = (SFDC_Paid_Time_Off__c)stdController.getRecord();
        balName = ApexPages.currentPage().getParameters().get('balName');
        avail = ApexPages.currentPage().getParameters().get('avail');
        totalApproved = ApexPages.currentPage().getParameters().get('totalApproved');
        balId = ApexPages.currentPage().getParameters().get('balId');
        userName = ApexPages.currentPage().getParameters().get('userName');
        userId = ApexPages.currentPage().getParameters().get('userId');
        userProf = ApexPages.currentPage().getParameters().get('userProf');
        avail2015 = ApexPages.CurrentPage().getParameters().get('avail2015');
        totalApp2015 = ApexPages.CurrentPage().getParameters().get('totalApp2015');
    
        this.ptoEdit = (SFDC_Paid_Time_Off__c)stdController.getRecord();
        userNameEdit = ApexPages.currentPage().getParameters().get('userNameEdit');
        recordId = ApexPages.currentPage().getParameters().get('recordId');
        
        userProf = userinfo.getProfileId();
        
        if(userProf == '00e70000000wzUb' || userProf == '00e70000001Fhw2' || userProf == '00e70000000wzXQ' || userProf == '00e70000001FaWM' || userProf == '00e70000001FiDh'){
            typeVisible = true;
        }
        else{
            typeVisible = false;
        }
        
        if(recordId == null){
            totalAvailable = decimal.valueOf(avail);
        }
        if(recordId != null){
            
            updatePTOInfo();
            
        }   
    }
    
    public void updatePTOInfo(){
        //query to set the edit page when user select a record to edit
        ptoEdit = [SELECT Id, Name, Employee_s_Name__c, Full_Day_Date__c, Partial_Day_Date__c, Partial_Day_Lunch__c, StartTimePH__c, EndTimePH__c, Hours_to_be_Used__c, Multi_Day_From__c, Multi_Day_To__c, RecordTypeId,
                    Day_1_Date__c, Day_2_Date__c, Day_3_Date__c, Day_4_Date__c, Day_5_Date__c, Day_1_Start_Time__c, Day_1_End_Time__c, Day_2_Start_Time__c, Day_2_End_Time__c, Day_3_Start_Time__c, Day_3_End_Time__c,
                    Day_4_Start_Time__c, Day_4_End_Time__c, Day_5_Start_Time__c, Day_5_End_Time__c, Day_1_Lunch__c, Day_2_Lunch__c, Day_3_Lunch__c, Day_4_Lunch__c, Day_5_Lunch__c, Partial_Day_1__c, Partial_Day_2__c, Partial_Day_3__c,
                    Partial_Day_4__c, Partial_Day_5__c, StartTime1PH__c, EndTime1PH__c, StartTime2PH__c, EndTime2PH__c, StartTime3PH__c, EndTime3PH__c, StartTime4PH__c, EndTime4PH__c, StartTime5PH__c, EndTime5PH__c,
                    Day_1_Hours_To_Be_Used__c, Day_2_Hours_To_Be_Used__c, Day_3_Hours_To_Be_Used__c, Day_4_Hours_To_Be_Used__c, Day_5_Hours_To_Be_Used__c, Type__c, Notes__c, Approval_Status__c
                   FROM SFDC_Paid_Time_Off__c
                   WHERE Id =: recordId];
        //query to update the PTO request record - getting this information here to make tor available throughout the various methods and calls        
        tor = [SELECT Id, Name, Employee_s_Name__c, Full_Day_Date__c, Partial_Day_Date__c, Partial_Day_Lunch__c, StartTimePH__c, EndTimePH__c, Hours_to_be_Used__c, Multi_Day_From__c, Multi_Day_To__c, RecordTypeId,
                    Day_1_Date__c, Day_2_Date__c, Day_3_Date__c, Day_4_Date__c, Day_5_Date__c, Day_1_Start_Time__c, Day_1_End_Time__c, Day_2_Start_Time__c, Day_2_End_Time__c, Day_3_Start_Time__c, Day_3_End_Time__c,
                    Day_4_Start_Time__c, Day_4_End_Time__c, Day_5_Start_Time__c, Day_5_End_Time__c, Day_1_Lunch__c, Day_2_Lunch__c, Day_3_Lunch__c, Day_4_Lunch__c, Day_5_Lunch__c, Partial_Day_1__c, Partial_Day_2__c, Partial_Day_3__c,
                    Partial_Day_4__c, Partial_Day_5__c, StartTime1PH__c, EndTime1PH__c, StartTime2PH__c, EndTime2PH__c, StartTime3PH__c, EndTime3PH__c, StartTime4PH__c, EndTime4PH__c, StartTime5PH__c, EndTime5PH__c,
                    Day_1_Hours_To_Be_Used__c, Day_2_Hours_To_Be_Used__c, Day_3_Hours_To_Be_Used__c, Day_4_Hours_To_Be_Used__c, Day_5_Hours_To_Be_Used__c, Type__c, Notes__c
                   FROM SFDC_Paid_Time_Off__c
                   WHERE Id =: recordId];
        
        // setting edit page if the record type is Full Day
        //if(ptoEdit.RecordTypeId == '012S00000008sJj'){ //This is Full Day Record Type Id for full sandbox
        if(ptoEdit.RecordTypeId == '01270000000Q9s6'){ //This is Full Day ecord Type Id for production  
            days = 'Full Day';
            pto.Full_Day_Date__c = ptoEdit.Full_Day_Date__c;
            pto.Notes__c = ptoEdit.Notes__c;
            pto.Type__c = ptoEdit.Type__c;
            pto.Approval_Status__c = ptoEdit.Approval_Status__c;
            
        }
        // setting edit page if the record type is Partial Day
        //else if(ptoEdit.RecordTypeId == '012S00000008sJo'){ // This is the Partial Day RecordType Id for full sandbox
        else if(ptoEdit.RecordTypeId == '01270000000Q9sB'){// This is the Partial Day RecordType Id for production
            days = 'Partial Day';
            pto.Partial_Day_Date__c = ptoEdit.Partial_Day_Date__c;
            partialTimeStart = ptoEdit.StartTimePH__c;
            partialTimeEnd = ptoEdit.EndTimePH__c;
            lunches = ptoEdit.Partial_Day_Lunch__c;
            partialDayHours = ptoEdit.Hours_to_be_Used__c;
            pto.Notes__c = ptoEdit.Notes__c;
            pto.Type__c = ptoEdit.Type__c;
            pto.Approval_Status__c = ptoEdit.Approval_Status__c;
        
        // setting edit page if the record type is Multiple Days    
        }
        //else if(ptoEdit.RecordTypeId == '012S00000008sJt'){ // This is the Multiple Days RecordType Id for full sandbox
        else if(ptoEdit.RecordTypeId == '01270000000Q9sG'){ // This is the Multiple Days RecordType Id for production
            
            days = 'Multiple Days';
            pto.Multi_Day_From__c = ptoEdit.Multi_Day_From__c;
            pto.Multi_Day_To__c = ptoEdit.Multi_Day_To__c;
            day1Date = ptoEdit.Day_1_Date__c;
            day2Date = ptoEdit.Day_2_Date__c;
            day3Date = ptoEdit.Day_3_Date__c;
            day4Date = ptoEdit.Day_4_Date__c;
            day5Date = ptoEdit.Day_5_Date__c;
            day1HoursDisplay = ptoEdit.Day_1_Hours_To_Be_Used__c;
            day2HoursDisplay = ptoEdit.Day_2_Hours_To_Be_Used__c;
            day3HoursDisplay = ptoEdit.Day_3_Hours_To_Be_Used__c;
            day4HoursDisplay = ptoEdit.Day_4_Hours_To_Be_Used__c;
            day5HoursDisplay = ptoEdit.Day_5_Hours_To_Be_Used__c;
            lunch1 = ptoEdit.Day_1_Lunch__c;
            lunch2 = ptoEdit.Day_2_Lunch__c;
            lunch3 = ptoEdit.Day_3_Lunch__c;
            lunch4 = ptoEdit.Day_4_Lunch__c;
            lunch5 = ptoEdit.Day_5_Lunch__c;
            pto.Partial_Day_1__c = ptoEdit.Partial_Day_1__c;
            pto.Partial_Day_2__c = ptoEdit.Partial_Day_2__c;
            pto.Partial_Day_3__c = ptoEdit.Partial_Day_3__c;
            pto.Partial_Day_4__c = ptoEdit.Partial_Day_4__c;
            pto.Partial_Day_5__c = ptoEdit.Partial_Day_5__c;
            multiDayPartialDay1StartTime = ptoEdit.StartTime1PH__c;
            multiDayPartialDay1EndTime = ptoEdit.EndTime1PH__c;
            multiDayPartialDay2StartTime = ptoEdit.StartTime2PH__c;
            multiDayPartialDay2EndTime = ptoEdit.EndTime2PH__c;
            multiDayPartialDay3StartTime = ptoEdit.StartTime3PH__c;
            multiDayPartialDay3EndTime = ptoEdit.EndTime3PH__c;
            multiDayPartialDay4StartTime = ptoEdit.StartTime4PH__c;
            multiDayPartialDay4EndTime = ptoEdit.EndTime4PH__c;
            multiDayPartialDay5StartTime = ptoEdit.StartTime5PH__c;
            multiDayPartialDay5EndTime = ptoEdit.EndTime5PH__c;
            totalMultiHours = ptoEdit.Hours_to_be_Used__c;
            pto.Notes__c = ptoEdit.Notes__c;
            pto.Type__c = ptoEdit.Type__c;
            pto.Approval_Status__c = ptoEdit.Approval_Status__c;
            
            multiDaysEdit();
            multiPartialDays();
            multiPartialDayHours();
            
        }
    }
    
    
    //used to set the visual only field to display total hours taken - this information DOES NOT get commited to the record - it is for visual purposes only    
    public void totalHoursTaken(){
        if(daysBetween > 1){
            totalMultiHours = day1HoursDisplay + day2HoursDisplay;
            //totalMultiHours = totalHours1 + totalHours2;
        }
        if(daysBetween > 2){
            totalMultiHours = day1HoursDisplay + day2HoursDisplay + day3HoursDisplay;
            //totalMultiHours = totalHours1 + totalHours2 + totalHours3;
        }
        if(daysBetween > 3){
            totalMultiHours = day1HoursDisplay + day2HoursDisplay + day3HoursDisplay + day4HoursDisplay;
            //totalMultiHours = totalHours1 + totalHours2 + totalHours3 + totalHours4;
        }
        if(daysBetween > 4){
            totalMultiHours = day1HoursDisplay + day2HoursDisplay + day3HoursDisplay + day4HoursDisplay + day5HoursDisplay;
            //totalMultiHours = totalHours1 + totalHours2 + totalHours3 + totalHours4 + totalHours5;
        }       
    }
    //defaulting the multiTimeError to false for the visual force page
    public PageReference typeChange(){
        
        nullDate = false;
        holidayDate = false;
        
        if (days == 'Full Day'){
            
            multi1TimeError = false;
            multi2TimeError = false;
            multi3TimeError = false;
            multi4TimeError = false;
            multi5TimeError = false;
            pd1Count = false;
            pd2Count = false;
            pd3Count = false;
            pd4Count = false;
            pd5Count = false;
            
        }
        if(days == 'Partial Day'){
            
            multi1TimeError = false;
            multi2TimeError = false;
            multi3TimeError = false;
            multi4TimeError = false;
            multi5TimeError = false;
            pd1Count = false;
            pd2Count = false;
            pd3Count = false;
            pd4Count = false;
            pd5Count = false;
            
        }
        
        return null; 
        
    }
    
    public PageReference paidUnpaid(){
        if(pto.Type__c == 'Planned' || pto.Type__c == 'Unplanned' || pto.Type__c == 'LOA 1: these hours DO come out of the PTO balance'){
            unpaidPaid = true;
        }
        else if(pto.Type__c == 'Unpaid Time Off' || pto.Type__c == 'LOA 2: these hours DO NOT come out of the PTO balance' || pto.Type__c == 'JURY: these hours do NOT come out of the PTO balance' || pto.Type__c == 'BEREAVE: these hours do NOT come out of the PTO balance' || pto.Type__c == 'VinGives'){
            unpaidPaid = false;
        }
        
        return null;
    }
    
    //gives the function to disable the save button unless times are chosen from the select lists on multiple days with partial day = true
    public PageReference multiPartialDays(){
        
        decimal pd1 = 0;
        decimal pd2 = 0;
        decimal pd3 = 0;
        decimal pd4 = 0;
        decimal pd5 = 0; 
        
        if(pto.Partial_Day_1__c == true){
            
            multi1TimeError = true;
            pd1Count = true;
            
        }
        else if(pto.Partial_Day_1__c == false){
            
            system.debug('BAZINGA' + multiDayPartialDay1StartTime);
            multi1TimeError = false;
            totalHours1 = 8;
            pto.Day_1_Hours_To_Be_Used__c = 8;
            multiDayPartialDay1StartTime = '99.99';
            multiDayPartialDay1EndTime = '99.99';
            lunch1 = 'NO';
            //multiDays();
            getMultiDayTimes();
            //totalHoursTaken();
            //pd1Count = false;
            
        }
        if(pto.Partial_Day_2__c == true){
            
            multi2TimeError = true;
            pd2Count = true;
            
        }
        else if(pto.Partial_Day_2__c != true){
            
            multi2TimeError = false;
            totalHours2 = 8;
            pto.Day_3_Hours_To_Be_Used__c = 8;
            multiDayPartialDay2StartTime = '99.99';
            multiDayPartialDay2EndTime = '99.99';
            lunch2 = 'NO';
            //multiDays();
            getMultiDayTimes();
            //totalHoursTaken();
            
        }
        if(pto.Partial_Day_3__c == true){
            
            multi3TimeError = true;
            pd3Count = true;
            
        }
        else if(pto.Partial_Day_3__c != true){
            
            multi3TimeError = false;
            totalHours3 = 8;
            pto.Day_3_Hours_To_Be_Used__c = 8;
            multiDayPartialDay3StartTime = '99.99';
            multiDayPartialDay3EndTime = '99.99';
            lunch3 = 'NO';
            //multiDays();
            getMultiDayTimes();
            //totalHoursTaken();
        }
        if(pto.Partial_Day_4__c == true){
            
            multi4TimeError = true;
            pd4Count = true;
            
        }
        else if(pto.Partial_Day_4__c != true){
            
            multi4TimeError = false;
            totalHours4 = 8;
            pto.Day_4_Hours_To_Be_Used__c = 8;
            multiDayPartialDay4StartTime = '99.99';
            multiDayPartialDay4EndTime = '99.99';
            lunch4 = 'NO';
            multiDays();
            getMultiDayTimes();
            totalHoursTaken();
        }
        if(pto.Partial_Day_5__c == true){
            
            multi5TimeError = true;
            pd5Count = true;
            
        }
        else if(pto.Partial_Day_5__c != true){
            
            multi5TimeError = false;
            totalHours5 = 8;
            pto.Day_5_Hours_To_Be_Used__c = 8;
            multiDayPartialDay5StartTime = '99.99';
            multiDayPartialDay5EndTime = '99.99';
            lunch5 = 'NO';
            multiDays();
            getMultiDayTimes();
            totalHoursTaken();
        }
        
        system.debug('BAZINGA' + multiDayPartialDay1StartTime);
        return null;
    }
    public PageReference multiPartialDaysEdit(){
        
        if(pto.Partial_Day_1__c == true){
            
            multi1TimeError = true;
            
        }
        else if(pto.Partial_Day_1__c != true){
            
            multi1TimeError = false;
            totalHours1 = 8;
            tor.Day_1_Hours_To_Be_Used__c = 8;
            multiDaysEdit();
            
        }
        if(pto.Partial_Day_2__c == true){
            
            multi2TimeError = true;
            
        }
        else if(pto.Partial_Day_2__c != true){
            
            multi2TimeError = false;
            totalHours2 = 8;
            tor.Day_3_Hours_To_Be_Used__c = 8;
            multiDaysEdit();
            
        }
        if(pto.Partial_Day_3__c == true){
            
            multi3TimeError = true;
            
        }
        else if(pto.Partial_Day_3__c != true){
            
            multi3TimeError = false;
            totalHours3 = 8;
            tor.Day_3_Hours_To_Be_Used__c = 8;
            multiDaysEdit();
            
        }
        if(pto.Partial_Day_4__c == true){
            
            multi4TimeError = true;
            
        }
        else if(pto.Partial_Day_4__c != true){
            
            multi4TimeError = false;
            totalHours4 = 8;
            tor.Day_4_Hours_To_Be_Used__c = 8;
            multiDaysEdit();
            
        }
        if(pto.Partial_Day_5__c == true){
            
            multi5TimeError = true;
            
        }
        else if(pto.Partial_Day_5__c != true){
            
            multi5TimeError = false;
            totalHours5 = 8;
            tor.Day_5_Hours_To_Be_Used__c = 8;
            multiDaysEdit();
            
        }
            
    
        return null;
    }
    public PageReference fullDay(){
        
        nullDate = false;
        /*if(totalAvailable < 8  && unpaidPaid == true){
            negHours = true;
        }
        else if(totalAvailable > 8 || unpaidPaid == false){
            negHours = false;
        }*/
        holidays();
        
        return null;
    }
    public PageReference partialDateNull(){
        
        nullDatePartial = false;
        holidays();
        
        return null;
    }
    
    public void partialDay1(){
            
        Decimal partialStart = decimal.valueOf(partialTimeStart);
        Decimal partialEnd = decimal.valueOf(partialTimeEnd);
        
        Decimal timeBetween = partialEnd - partialStart;
        
        if(totalAvailable < timeBetween && unpaidPaid == true ){
            negHours = true;
        }
        else if(totalAvailable >= timeBetween && unpaidPaid == false){
            negHours = false;
        }
        
        if(lunches == 'NO'){
            
            partialDayHours = timeBetween;
            lunchNeg = false;   

        }
        if(lunches == 'YES'){
            
            partialDayHours = timeBetween - 1;
            
            if(partialDayHours < 0){
                lunchNeg = true;
            }
            else if(partialDayHours > 0 ){
                lunchNeg = false;
            }
            
        }
        
        if(partialTimeStart != 'Select Time...' || partialTimeEnd != 'Select Time...'){
            
            partialTimeError = false;
            
        }
        
        if(partialEnd < partialStart){
            
            negativeTime = true;
        }
        else{
            
            negativeTime = false;
        }
        
        if(timeBetween > 8){
            
            overEightHours = true;
        }
        else{
            
            overEightHours = false;
            
        }
        if(days == 'Multiple Days'){
            
            overEightHours = false;
            
        }
        
    }
    
    public void partialDay1Edit(){
        
        
    }
    
    public PageReference partialDays(){
        
        partialDay1();
        
        return null;
        
    }
    
    public PageReference partialDaysEdit(){
        
        partialDay1Edit();
        
        return null;
    }
    public PageReference multiPartialDayHoursEdit(){
        
        totalHours1 = 0;
        totalHours2 = 0;
        totalHours3 = 0;
        totalHours4 = 0;
        totalHours5 = 0;
        if(pto.Partial_Day_1__c == false){
            
            multiDayPartialDay1StartTime = 'Select Time...';
            multiDayPartialDay1EndTime = 'Select Time...';
            
        }
        if(pto.Partial_Day_1__c == true){
                
                
            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
            
            String mpds1 = string.valueOf(multiDayPartialDay1StartTime);
            String mpds1Hour = mpds1.substringBefore('.');
            Decimal mpds1HourDecimal = decimal.valueOf(mpds1Hour);
            String mpds1Minutes = mpds1.substringAfter('.');
            String mpds1Time;
            String mpds1PartOfDay = 'AM';
            String mpde1PartOfDay = 'AM';
            
            String mpde1 = string.valueOf(multiDayPartialDay1EndTime);
            String mpde1Hour = mpde1.substringBefore('.');
            Decimal mpde1HourDecimal = decimal.valueOf(mpde1Hour);
            String mpde1Minutes = mpde1.substringAfter('.');
            String mpde1Time;
            
            
            if(mpds1HourDecimal > 11.99){
                if(mpds1HourDecimal > 12){
                    mpds1HourDecimal = mpds1HourDecimal - 12;
                }
                mpds1Hour = string.valueOf(mpds1HourDecimal);
                mpds1PartOfDay = 'PM';
                
            }
            if(mpde1HourDecimal > 11.99){
                if(mpde1HourDecimal >12){
                    mpde1HourDecimal = mpde1HourDecimal - 12;
                }
                mpde1Hour = string.valueOf(mpde1HourDecimal);
                mpde1PartOfDay = 'PM';
                
            }
            
            if(mpds1Minutes == '00'){
                
                mpds1Time = '00';
                
            }
            else if(mpds1Minutes == '25'){
                
                mpds1Time = '15';
                
            }
            else if(mpds1Minutes == '50'){
                
                mpds1Time = '30';
                
            }
            else if(mpds1Minutes == '75'){
            
                mpds1Time = '45';
                
            }
            
            if(mpde1Minutes == '00'){
            
                mpde1Time = '00';   
                
            }
            else if(mpde1Minutes == '25'){
                
                mpde1Time = '15';
                
            }
            else if(mpde1Minutes == '50'){
                
                mpde1Time = '30';
                
            }
            else if(mpde1Minutes == '75'){
                
                mpde1Time = '45';
                
            }
            
            if(day1End < day1Start){
                
                day1NegTime = true;
                
            }
            else{
                
                day1NegTime = false;
                
            }
            if(day1End - day1Start > 8){
                
                day1OverEight = true;
                
            }
            else{
                
                day1OverEight = false;
                
            }
            if(lunch1 == 'NO'){
                
                day1HoursDisplay = day1End - day1Start;
                tor.Day_1_Hours_To_Be_Used__c = day1HoursDisplay;
                lunchNeg = false;
                
            }
            else if(lunch1 == 'YES'){
                
                day1HoursDisplay = day1End - day1start - 1;
                if(day1HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day1HoursDisplay > 0){
                    lunchNeg = false;
                }
                tor.Day_1_Hours_To_Be_Used__c = day1HoursDisplay;
                    
            }
            if(multiDayPartialDay1StartTime != 'Select Time...' && multiDayPartialDay1EndTime != 'Select Time...'){
            
                multi1TimeError = false;
                
            }
            
            totalHours1 = day1HoursDisplay;
            day1StartTime = mpds1Hour + ':' + mpds1Time + ' ' + mpds1PartOfDay;
            day1EndTime = mpde1Hour + ':' + mpde1Time + ' ' + mpde1PartOfDay;
            
                                
        }
        
        if(pto.Partial_Day_2__c == true){
                
                
            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
            
            String mpds2 = string.valueOf(multiDayPartialDay2StartTime);
            String mpds2Hour = mpds2.substringBefore('.');
            Decimal mpds2HourDecimal = decimal.valueOf(mpds2Hour);
            String mpds2Minutes = mpds2.substringAfter('.');
            String mpds2Time;
            String mpds2PartOfDay = 'AM';
            String mpde2PartOfDay = 'AM';
            
            String mpde2 = string.valueOf(multiDayPartialDay2EndTime);
            String mpde2Hour = mpde2.substringBefore('.');
            Decimal mpde2HourDecimal = decimal.valueOf(mpde2Hour);
            String mpde2Minutes = mpde2.substringAfter('.');
            String mpde2Time;
            
            
            
            if(mpds2HourDecimal > 11.99){
                if(mpds2HourDecimal > 12){
                    mpds2HourDecimal = mpds2HourDecimal - 12;
                }
                mpds2Hour = string.valueOf(mpds2HourDecimal);
                mpds2PartOfDay = 'PM';
                
            }
            if(mpde2HourDecimal > 11.99){
                if(mpde2HourDecimal >12){
                    mpde2HourDecimal = mpde2HourDecimal - 12;
                }
                mpde2Hour = string.valueOf(mpde2HourDecimal);
                mpde2PartOfDay = 'PM';
                
            }
            
            if(mpds2Minutes == '00'){
                
                mpds2Time = '00';
                
            }
            else if(mpds2Minutes == '25'){
                
                mpds2Time = '15';
                
            }
            else if(mpds2Minutes == '50'){
                
                mpds2Time = '30';
                
            }
            else if(mpds2Minutes == '75'){
            
                mpds2Time = '45';
                
            }
            
            if(mpde2Minutes == '00'){
            
                mpde2Time = '00';   
                
            }
            else if(mpde2Minutes == '25'){
                
                mpde2Time = '15';
                
            }
            else if(mpde2Minutes == '50'){
                
                mpde2Time = '30';
                
            }
            else if(mpde2Minutes == '75'){
                
                mpde2Time = '45';
                
            }
            
            if(day2End < day2Start){
                
                day2NegTime = true;
                
            }
            else{
                
                day2NegTime = false;
                
            }
            if(day2End - day2Start > 8){
                
                day2OverEight = true;
                
            }
            else{
                
                day2OverEight = false;
                
            }
            
            if(lunch2 == 'NO'){
                
                day2HoursDisplay = day2End - day2Start;
                tor.Day_2_Hours_To_Be_Used__c = day2HoursDisplay;
                lunchNeg = false;
            }
            else if(lunch2 == 'YES'){
                
                day2HoursDisplay = day2End - day2start - 1;
                if(day2HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day2HoursDisplay > 0){
                    lunchNeg = false;
                }
                tor.Day_2_Hours_To_Be_Used__c = day2HoursDisplay;
            }
            if(multiDayPartialDay2StartTime != 'Select Time...' && multiDayPartialDay2EndTime != 'Select Time...'){
            
                multi2TimeError = false;
                
            }
            
            totalHours2 = day2HoursDisplay;
            day2StartTime = mpds2Hour + ':' + mpds2Time + ' ' + mpds2PartOfDay;
            day2EndTime = mpde2Hour + ':' + mpde2Time + ' ' + mpde2PartOfDay;
                
        }

        if(pto.Partial_Day_3__c == true){
                
                
            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
            
            String mpds3 = string.valueOf(multiDayPartialDay3StartTime);
            String mpds3Hour = mpds3.substringBefore('.');
            Decimal mpds3HourDecimal = decimal.valueOf(mpds3Hour);
            String mpds3Minutes = mpds3.substringAfter('.');
            String mpds3Time;
            String mpds3PartOfDay = 'AM';
            String mpde3PartOfDay = 'AM';
            
            String mpde3 = string.valueOf(multiDayPartialDay3EndTime);
            String mpde3Hour = mpde3.substringBefore('.');
            Decimal mpde3HourDecimal = decimal.valueOf(mpde3Hour);
            String mpde3Minutes = mpde3.substringAfter('.');
            String mpde3Time;
            
            
            if(mpds3HourDecimal > 11.99){
                if(mpds3HourDecimal > 12){
                    mpds3HourDecimal = mpds3HourDecimal - 12;
                }
                mpds3Hour = string.valueOf(mpds3HourDecimal);
                mpds3PartOfDay = 'PM';
                
            }
            if(mpde3HourDecimal > 11.99){
                if(mpde3HourDecimal >12){
                    mpde3HourDecimal = mpde3HourDecimal - 12;
                }
                mpde3Hour = string.valueOf(mpde3HourDecimal);
                mpde3PartOfDay = 'PM';
                
            }
            
            if(mpds3Minutes == '00'){
                
                mpds3Time = '00';
                
            }
            else if(mpds3Minutes == '25'){
                
                mpds3Time = '15';
                
            }
            else if(mpds3Minutes == '50'){
                
                mpds3Time = '30';
                
            }
            else if(mpds3Minutes == '75'){
            
                mpds3Time = '45';
                
            }
            
            if(mpde3Minutes == '00'){
            
                mpde3Time = '00';   
                
            }
            else if(mpde3Minutes == '25'){
                
                mpde3Time = '15';
                
            }
            else if(mpde3Minutes == '50'){
                
                mpde3Time = '30';
                
            }
            else if(mpde3Minutes == '75'){
                
                mpde3Time = '45';
                
            }
            
            if(day3End < day3Start){
                
                day3NegTime = true;
                
            }
            else{
                
                day3NegTime = false;
                
            }
            if(day3End - day3Start > 8){
                
                day3OverEight = true;
                
            }
            else{
                
                day3OverEight = false;
                
            }
            
            if(lunch3 == 'NO'){
                
                day3HoursDisplay = day3End - day3Start;
                tor.Day_3_Hours_To_Be_Used__c = day3HoursDisplay;
                lunchNeg = false;
            }
            else if(lunch3 == 'YES'){
                
                day3HoursDisplay = day3End - day3start - 1;
                if(day3HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day3HoursDisplay > 0){
                    lunchNeg = false;
                }
                tor.Day_3_Hours_To_Be_Used__c = day3HoursDisplay;
            }
            if(multiDayPartialDay3StartTime != 'Select Time...' && multiDayPartialDay3EndTime != 'Select Time...'){
            
                multi3TimeError = false;
                
            }
            
            totalHours3 = day3HoursDisplay;
            day3StartTime = mpds3Hour + ':' + mpds3Time + ' ' + mpds3PartOfDay;
            day3EndTime = mpde3Hour + ':' + mpde3Time + ' ' + mpde3PartOfDay;
        }
        if(pto.Partial_Day_4__c == true){
                
                
            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
            
            String mpds4 = string.valueOf(multiDayPartialDay4StartTime);
            String mpds4Hour = mpds4.substringBefore('.');
            Decimal mpds4HourDecimal = decimal.valueOf(mpds4Hour);
            String mpds4Minutes = mpds4.substringAfter('.');
            String mpds4Time;
            String mpds4PartOfDay = 'AM';
            String mpde4PartOfDay = 'AM';
            
            String mpde4 = string.valueOf(multiDayPartialDay4EndTime);
            String mpde4Hour = mpde4.substringBefore('.');
            Decimal mpde4HourDecimal = decimal.valueOf(mpde4Hour);
            String mpde4Minutes = mpde4.substringAfter('.');
            String mpde4Time;
            
            
            if(mpds4HourDecimal > 11.99){
                if(mpds4HourDecimal > 12){
                    mpds4HourDecimal = mpds4HourDecimal - 12;
                }
                mpds4Hour = string.valueOf(mpds4HourDecimal);
                mpds4PartOfDay = 'PM';
                
            }
            if(mpde4HourDecimal > 11.99){
                if(mpde4HourDecimal >12){
                    mpde4HourDecimal = mpde4HourDecimal - 12;
                }
                mpde4Hour = string.valueOf(mpde4HourDecimal);
                mpde4PartOfDay = 'PM';
                
            }
            
            if(mpds4Minutes == '00'){
                
                mpds4Time = '00';
                
            }
            else if(mpds4Minutes == '25'){
                
                mpds4Time = '15';
                
            }
            else if(mpds4Minutes == '50'){
                
                mpds4Time = '30';
                
            }
            else if(mpds4Minutes == '75'){
            
                mpds4Time = '45';
                
            }
            
            if(mpde4Minutes == '00'){
            
                mpde4Time = '00';   
                
            }
            else if(mpde4Minutes == '25'){
                
                mpde4Time = '15';
                
            }
            else if(mpde4Minutes == '50'){
                
                mpde4Time = '30';
                
            }
            else if(mpde4Minutes == '75'){
                
                mpde4Time = '45';
                
            }
            
            if(day4End < day4Start){
                
                day4NegTime = true;
                
            }
            else{
                
                day4NegTime = false;
                
            }
            if(day4End - day4Start > 8){
                
                day4OverEight = true;
                
            }
            else{
                
                day4OverEight = false;
                
            }
            
            if(lunch4 == 'NO'){
                
                day4HoursDisplay = day4End - day4Start;
                tor.Day_4_Hours_To_Be_Used__c = day4HoursDisplay;
                lunchNeg =false;
            }
            else if(lunch4 == 'YES'){
                
                day4HoursDisplay = day4End - day4start - 1;
                if(day4HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day4HoursDisplay > 0){
                    lunchNeg = false;
                }
                tor.Day_4_Hours_To_Be_Used__c = day4HoursDisplay;
            }
            if(multiDayPartialDay4StartTime != 'Select Time...' && multiDayPartialDay4EndTime != 'Select Time...'){
            
                multi4TimeError = false;
                
            }
            
            totalHours4 = day4HoursDisplay;
            day4StartTime = mpds4Hour + ':' + mpds4Time + ' ' + mpds4PartOfDay;
            day4EndTime = mpde4Hour + ':' + mpde4Time + ' ' + mpde4PartOfDay;
                
        }
        if(pto.Partial_Day_5__c == true){
                
                
            decimal day5Start = decimal.valueOf(multiDayPartialDay5StartTime);
            decimal day5End = decimal.valueOf(multiDayPartialDay5EndTime);
            
            String mpds5 = string.valueOf(multiDayPartialDay5StartTime);
            String mpds5Hour = mpds5.substringBefore('.');
            Decimal mpds5HourDecimal = decimal.valueOf(mpds5Hour);
            String mpds5Minutes = mpds5.substringAfter('.');
            String mpds5Time;
            String mpds5PartOfDay = 'AM';
            String mpde5PartOfDay = 'AM';
            
            String mpde5 = string.valueOf(multiDayPartialDay5EndTime);
            String mpde5Hour = mpde5.substringBefore('.');
            Decimal mpde5HourDecimal = decimal.valueOf(mpde5Hour);
            String mpde5Minutes = mpde5.substringAfter('.');
            String mpde5Time;
            
            
            if(mpds5HourDecimal > 11.99){
                if(mpds5HourDecimal > 12){
                    mpds5HourDecimal = mpds5HourDecimal - 12;
                }
                mpds5Hour = string.valueOf(mpds5HourDecimal);
                mpds5PartOfDay = 'PM';
                
            }
            if(mpde5HourDecimal > 11.99){
                if(mpde5HourDecimal >12){
                    mpde5HourDecimal = mpde5HourDecimal - 12;
                }
                mpde5Hour = string.valueOf(mpde5HourDecimal);
                mpde5PartOfDay = 'PM';
                
            }
            
            if(mpds5Minutes == '00'){
                
                mpds5Time = '00';
                
            }
            else if(mpds5Minutes == '25'){
                
                mpds5Time = '15';
                
            }
            else if(mpds5Minutes == '50'){
                
                mpds5Time = '30';
                
            }
            else if(mpds5Minutes == '75'){
            
                mpds5Time = '45';
                
            }
            
            if(mpde5Minutes == '00'){
            
                mpde5Time = '00';   
                
            }
            else if(mpde5Minutes == '25'){
                
                mpde5Time = '15';
                
            }
            else if(mpde5Minutes == '50'){
                
                mpde5Time = '30';
                
            }
            else if(mpde5Minutes == '75'){
                
                mpde5Time = '45';
                
            }
            
            if(day5End < day5Start){
                
                day5NegTime = true;
                
            }
            else{
                
                day5NegTime = false;
                
            }
            if(day5End - day5Start > 8){
                
                day5OverEight = true;
                
            }
            else{
                
                day5OverEight = false;
                
            }
            
            if(lunch5 == 'NO'){
                
                day5HoursDisplay = day5End - day5Start;
                tor.Day_5_Hours_To_Be_Used__c = day5HoursDisplay;
                lunchNeg = false;
            }
            else if(lunch5 == 'YES'){
                
                day5HoursDisplay = day5End - day5start - 1;
                if(day5HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day5HoursDisplay > 0){
                    lunchNeg = false;
                }
                tor.Day_5_Hours_To_Be_Used__c = day5HoursDisplay;
            }
            if(multiDayPartialDay5StartTime != 'Select Time...' && multiDayPartialDay5EndTime != 'Select Time...'){
            
                multi5TimeError = false;
                
            }
            
            totalHours5 = day5HoursDisplay;
            day5StartTime = mpds5Hour + ':' + mpds5Time + ' ' + mpds5PartOfDay;
            day5EndTime = mpde5Hour + ':' + mpde5Time + ' ' + mpde5PartOfDay;   
        }
        
         totalHoursTaken();
            
        return null;
    }
    public PageReference multiPartialDayHours(){
        
        totalHours1 = 0;
        totalHours2 = 0;
        totalHours3 = 0;
        totalHours4 = 0;
        totalHours5 = 0;
        
        if(pto.Partial_Day_1__c == false){
            
            multiDayPartialDay1StartTime = '99.99';
            multiDayPartialDay1EndTime = '99.99';
        }
        if(pto.Partial_Day_1__c == true){
            
                
            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
            
            String mpds1 = string.valueOf(multiDayPartialDay1StartTime);
            String mpds1Hour = mpds1.substringBefore('.');
            Decimal mpds1HourDecimal = decimal.valueOf(mpds1Hour);
            String mpds1Minutes = mpds1.substringAfter('.');
            String mpds1Time;
            String mpds1PartOfDay = 'AM';
            String mpde1PartOfDay = 'AM';
            
            String mpde1 = string.valueOf(multiDayPartialDay1EndTime);
            String mpde1Hour = mpde1.substringBefore('.');
            Decimal mpde1HourDecimal = decimal.valueOf(mpde1Hour);
            String mpde1Minutes = mpde1.substringAfter('.');
            String mpde1Time;
            
            
            if(mpds1HourDecimal > 11.99){
                if(mpds1HourDecimal > 12){
                    mpds1HourDecimal = mpds1HourDecimal - 12;
                }
                mpds1Hour = string.valueOf(mpds1HourDecimal);
                mpds1PartOfDay = 'PM';
                
            }
            if(mpde1HourDecimal > 11.99){
                if(mpde1HourDecimal >12){
                    mpde1HourDecimal = mpde1HourDecimal - 12;
                }
                mpde1Hour = string.valueOf(mpde1HourDecimal);
                mpde1PartOfDay = 'PM';
                
            }
            
            if(mpds1Minutes == '00'){
                
                mpds1Time = '00';
                
            }
            else if(mpds1Minutes == '25'){
                
                mpds1Time = '15';
                
            }
            else if(mpds1Minutes == '50'){
                
                mpds1Time = '30';
                
            }
            else if(mpds1Minutes == '75'){
            
                mpds1Time = '45';
                
            }
            
            if(mpde1Minutes == '00'){
            
                mpde1Time = '00';   
                
            }
            else if(mpde1Minutes == '25'){
                
                mpde1Time = '15';
                
            }
            else if(mpde1Minutes == '50'){
                
                mpde1Time = '30';
                
            }
            else if(mpde1Minutes == '75'){
                
                mpde1Time = '45';
                
            }
            
            if(day1End < day1Start){
                
                day1NegTime = true;
                
            }
            else{
                
                day1NegTime = false;
                
            }
            if(day1End - day1Start > 8){
                
                day1OverEight = true;
                
            }
            else{
                
                day1OverEight = false;
                
            }
            if(lunch1 == 'NO'){
                
                day1HoursDisplay = day1End - day1Start;
                pto.Day_1_Hours_To_Be_Used__c = day1HoursDisplay;
                lunchNeg = false;
                
            }
            else if(lunch1 == 'YES'){
                
                day1HoursDisplay = day1End - day1start - 1;
                if(day1HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day1HoursDisplay > 0){
                    lunchNeg = false;
                }
                pto.Day_1_Hours_To_Be_Used__c = day1HoursDisplay;
                    
            }
            if(multiDayPartialDay1StartTime != 'Select Time...' && multiDayPartialDay1EndTime != 'Select Time...'){
            
                multi1TimeError = false;
                
            }
            
            totalHours1 = day1HoursDisplay;
            day1StartTime = mpds1Hour + ':' + mpds1Time + ' ' + mpds1PartOfDay;
            day1EndTime = mpde1Hour + ':' + mpde1Time + ' ' + mpde1PartOfDay;
            
                                
        }
        if(pto.Partial_Day_1__c == false){
            
            multiDayPartialDay1StartTime = 'Select Time...';
            multiDayPartialDay1EndTime = 'Select Time...';
            //totalHours1 = 8;
            
        }
        
        if(pto.Partial_Day_2__c == true){
                
                
            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
            
            String mpds2 = string.valueOf(multiDayPartialDay2StartTime);
            String mpds2Hour = mpds2.substringBefore('.');
            Decimal mpds2HourDecimal = decimal.valueOf(mpds2Hour);
            String mpds2Minutes = mpds2.substringAfter('.');
            String mpds2Time;
            String mpds2PartOfDay = 'AM';
            String mpde2PartOfDay = 'AM';
            
            String mpde2 = string.valueOf(multiDayPartialDay2EndTime);
            String mpde2Hour = mpde2.substringBefore('.');
            Decimal mpde2HourDecimal = decimal.valueOf(mpde2Hour);
            String mpde2Minutes = mpde2.substringAfter('.');
            String mpde2Time;
            
            
            if(mpds2HourDecimal > 11.99){
                if(mpds2HourDecimal > 12){
                    mpds2HourDecimal = mpds2HourDecimal - 12;
                }
                mpds2Hour = string.valueOf(mpds2HourDecimal);
                mpds2PartOfDay = 'PM';
                
            }
            if(mpde2HourDecimal > 11.99){
                if(mpde2HourDecimal >12){
                    mpde2HourDecimal = mpde2HourDecimal - 12;
                }
                mpde2Hour = string.valueOf(mpde2HourDecimal);
                mpde2PartOfDay = 'PM';
                
            }
            
            if(mpds2Minutes == '00'){
                
                mpds2Time = '00';
                
            }
            else if(mpds2Minutes == '25'){
                
                mpds2Time = '15';
                
            }
            else if(mpds2Minutes == '50'){
                
                mpds2Time = '30';
                
            }
            else if(mpds2Minutes == '75'){
            
                mpds2Time = '45';
                
            }
            
            if(mpde2Minutes == '00'){
            
                mpde2Time = '00';   
                
            }
            else if(mpde2Minutes == '25'){
                
                mpde2Time = '15';
                
            }
            else if(mpde2Minutes == '50'){
                
                mpde2Time = '30';
                
            }
            else if(mpde2Minutes == '75'){
                
                mpde2Time = '45';
                
            }
            
            if(day2End < day2Start){
                
                day2NegTime = true;
                
            }
            else{
                
                day2NegTime = false;
                
            }
            if(day2End - day2Start > 8){
                
                day2OverEight = true;
                
            }
            else{
                
                day2OverEight = false;
                
            }
            
            if(lunch2 == 'NO'){
                
                day2HoursDisplay = day2End - day2Start;
                pto.Day_2_Hours_To_Be_Used__c = day2HoursDisplay;
                lunchNeg = false;
            }
            else if(lunch2 == 'YES'){
                
                day2HoursDisplay = day2End - day2start - 1;
                if(day2HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day2HoursDisplay > 0){
                    lunchNeg = false;
                }
                pto.Day_2_Hours_To_Be_Used__c = day2HoursDisplay;
            }
            if(multiDayPartialDay2StartTime != 'Select Time...' && multiDayPartialDay2EndTime != 'Select Time...'){
            
                multi2TimeError = false;
                
            }
            
            totalHours2 = day2HoursDisplay;
            day2StartTime = mpds2Hour + ':' + mpds2Time + ' ' + mpds2PartOfDay;
            day2EndTime = mpde2Hour + ':' + mpde2Time + ' ' + mpde2PartOfDay;
                
        }

        if(pto.Partial_Day_3__c == true){
                
                
            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
            
            String mpds3 = string.valueOf(multiDayPartialDay3StartTime);
            String mpds3Hour = mpds3.substringBefore('.');
            Decimal mpds3HourDecimal = decimal.valueOf(mpds3Hour);
            String mpds3Minutes = mpds3.substringAfter('.');
            String mpds3Time;
            String mpds3PartOfDay = 'AM';
            String mpde3PartOfDay = 'AM';
            
            String mpde3 = string.valueOf(multiDayPartialDay3EndTime);
            String mpde3Hour = mpde3.substringBefore('.');
            Decimal mpde3HourDecimal = decimal.valueOf(mpde3Hour);
            String mpde3Minutes = mpde3.substringAfter('.');
            String mpde3Time;
            
            
            if(mpds3HourDecimal > 11.99){
                if(mpds3HourDecimal > 12){
                    mpds3HourDecimal = mpds3HourDecimal - 12;
                }
                mpds3Hour = string.valueOf(mpds3HourDecimal);
                mpds3PartOfDay = 'PM';
                
            }
            if(mpde3HourDecimal > 11.99){
                if(mpde3HourDecimal >12){
                    mpde3HourDecimal = mpde3HourDecimal - 12;
                }
                mpde3Hour = string.valueOf(mpde3HourDecimal);
                mpde3PartOfDay = 'PM';
                
            }
            
            if(mpds3Minutes == '00'){
                
                mpds3Time = '00';
                
            }
            else if(mpds3Minutes == '25'){
                
                mpds3Time = '15';
                
            }
            else if(mpds3Minutes == '50'){
                
                mpds3Time = '30';
                
            }
            else if(mpds3Minutes == '75'){
            
                mpds3Time = '45';
                
            }
            
            if(mpde3Minutes == '00'){
            
                mpde3Time = '00';   
                
            }
            else if(mpde3Minutes == '25'){
                
                mpde3Time = '15';
                
            }
            else if(mpde3Minutes == '50'){
                
                mpde3Time = '30';
                
            }
            else if(mpde3Minutes == '75'){
                
                mpde3Time = '45';
                
            }
            
            if(day3End < day3Start){
                
                day3NegTime = true;
                
            }
            else{
                
                day3NegTime = false;
                
            }
            if(day3End - day3Start > 8){
                
                day3OverEight = true;
                
            }
            else{
                
                day3OverEight = false;
                
            }
            
            if(lunch3 == 'NO'){
                
                day3HoursDisplay = day3End - day3Start;
                pto.Day_3_Hours_To_Be_Used__c = day3HoursDisplay;
                lunchNeg = false;
            }
            else if(lunch3 == 'YES'){
                
                day3HoursDisplay = day3End - day3start - 1;
                if(day3HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day3HoursDisplay > 0){
                    lunchNeg = false;
                }
                pto.Day_3_Hours_To_Be_Used__c = day3HoursDisplay;
            }
            if(multiDayPartialDay3StartTime != 'Select Time...' && multiDayPartialDay3EndTime != 'Select Time...'){
            
                multi3TimeError = false;
                
            }
            
            totalHours3 = day3HoursDisplay;
            day3StartTime = mpds3Hour + ':' + mpds3Time + ' ' + mpds3PartOfDay;
            day3EndTime = mpde3Hour + ':' + mpde3Time + ' ' + mpde3PartOfDay;
        }
        if(pto.Partial_Day_4__c == true){
                
                
            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
            
            String mpds4 = string.valueOf(multiDayPartialDay4StartTime);
            String mpds4Hour = mpds4.substringBefore('.');
            Decimal mpds4HourDecimal = decimal.valueOf(mpds4Hour);
            String mpds4Minutes = mpds4.substringAfter('.');
            String mpds4Time;
            String mpds4PartOfDay = 'AM';
            String mpde4PartOfDay = 'AM';
            
            String mpde4 = string.valueOf(multiDayPartialDay4EndTime);
            String mpde4Hour = mpde4.substringBefore('.');
            Decimal mpde4HourDecimal = decimal.valueOf(mpde4Hour);
            String mpde4Minutes = mpde4.substringAfter('.');
            String mpde4Time;
            
            
            if(mpds4HourDecimal > 11.99){
                if(mpds4HourDecimal > 12){
                    mpds4HourDecimal = mpds4HourDecimal - 12;
                }
                mpds4Hour = string.valueOf(mpds4HourDecimal);
                mpds4PartOfDay = 'PM';
                
            }
            if(mpde4HourDecimal > 11.99){
                if(mpde4HourDecimal >12){
                    mpde4HourDecimal = mpde4HourDecimal - 12;
                }
                mpde4Hour = string.valueOf(mpde4HourDecimal);
                mpde4PartOfDay = 'PM';
                
            }
            
            if(mpds4Minutes == '00'){
                
                mpds4Time = '00';
                
            }
            else if(mpds4Minutes == '25'){
                
                mpds4Time = '15';
                
            }
            else if(mpds4Minutes == '50'){
                
                mpds4Time = '30';
                
            }
            else if(mpds4Minutes == '75'){
            
                mpds4Time = '45';
                
            }
            
            if(mpde4Minutes == '00'){
            
                mpde4Time = '00';   
                
            }
            else if(mpde4Minutes == '25'){
                
                mpde4Time = '15';
                
            }
            else if(mpde4Minutes == '50'){
                
                mpde4Time = '30';
                
            }
            else if(mpde4Minutes == '75'){
                
                mpde4Time = '45';
                
            }
            
            if(day4End < day4Start){
                
                day4NegTime = true;
                
            }
            else{
                
                day4NegTime = false;
                
            }
            if(day4End - day4Start > 8){
                
                day4OverEight = true;
                
            }
            else{
                
                day4OverEight = false;
                
            }
            
            if(lunch4 == 'NO'){
                
                day4HoursDisplay = day4End - day4Start;
                pto.Day_4_Hours_To_Be_Used__c = day4HoursDisplay;
                lunchNeg = false;
            }
            else if(lunch4 == 'YES'){
                
                day4HoursDisplay = day4End - day4start - 1;
                if(day4HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day4HoursDisplay > 0){
                    lunchNeg = false;
                }
                pto.Day_4_Hours_To_Be_Used__c = day4HoursDisplay;
            }
            if(multiDayPartialDay4StartTime != 'Select Time...' && multiDayPartialDay4EndTime != 'Select Time...'){
            
                multi4TimeError = false;
                
            }
            
            totalHours4 = day4HoursDisplay;
            day4StartTime = mpds4Hour + ':' + mpds4Time + ' ' + mpds4PartOfDay;
            day4EndTime = mpde4Hour + ':' + mpde4Time + ' ' + mpde4PartOfDay;
                
        }
        if(pto.Partial_Day_5__c == true){
                
                
            decimal day5Start = decimal.valueOf(multiDayPartialDay5StartTime);
            decimal day5End = decimal.valueOf(multiDayPartialDay5EndTime);
            
            String mpds5 = string.valueOf(multiDayPartialDay5StartTime);
            String mpds5Hour = mpds5.substringBefore('.');
            Decimal mpds5HourDecimal = decimal.valueOf(mpds5Hour);
            String mpds5Minutes = mpds5.substringAfter('.');
            String mpds5Time;
            String mpds5PartOfDay = 'AM';
            String mpde5PartOfDay = 'AM';
            
            String mpde5 = string.valueOf(multiDayPartialDay5EndTime);
            String mpde5Hour = mpde5.substringBefore('.');
            Decimal mpde5HourDecimal = decimal.valueOf(mpde5Hour);
            String mpde5Minutes = mpde5.substringAfter('.');
            String mpde5Time;
            
            
            if(mpds5HourDecimal > 11.99){
                if(mpds5HourDecimal > 12){
                    mpds5HourDecimal = mpds5HourDecimal - 12;
                }
                mpds5Hour = string.valueOf(mpds5HourDecimal);
                mpds5PartOfDay = 'PM';
                
            }
            if(mpde5HourDecimal > 11.99){
                if(mpde5HourDecimal >12){
                    mpde5HourDecimal = mpde5HourDecimal - 12;
                }
                mpde5Hour = string.valueOf(mpde5HourDecimal);
                mpde5PartOfDay = 'PM';
                
            }
            
            if(mpds5Minutes == '00'){
                
                mpds5Time = '00';
                
            }
            else if(mpds5Minutes == '25'){
                
                mpds5Time = '15';
                
            }
            else if(mpds5Minutes == '50'){
                
                mpds5Time = '30';
                
            }
            else if(mpds5Minutes == '75'){
            
                mpds5Time = '45';
                
            }
            
            if(mpde5Minutes == '00'){
            
                mpde5Time = '00';   
                
            }
            else if(mpde5Minutes == '25'){
                
                mpde5Time = '15';
                
            }
            else if(mpde5Minutes == '50'){
                
                mpde5Time = '30';
                
            }
            else if(mpde5Minutes == '75'){
                
                mpde5Time = '45';
                
            }
            
            if(day5End < day5Start){
                
                day5NegTime = true;
                
            }
            else{
                
                day5NegTime = false;
                
            }
            if(day5End - day5Start > 8){
                
                day5OverEight = true;
                
            }
            else{
                
                day5OverEight = false;
                
            }
            
            if(lunch5 == 'NO'){
                
                day5HoursDisplay = day5End - day5Start;
                pto.Day_5_Hours_To_Be_Used__c = day5HoursDisplay;
                lunchNeg = false;
            }
            else if(lunch5 == 'YES'){
                
                day5HoursDisplay = day5End - day5start - 1;
                if(day5HoursDisplay < 0){
                    lunchNeg = true;
                }
                else if(day5HoursDisplay > 0){
                    lunchNeg = false;
                }
                pto.Day_5_Hours_To_Be_Used__c = day5HoursDisplay;
            }
            if(multiDayPartialDay5StartTime != 'Select Time...' && multiDayPartialDay5EndTime != 'Select Time...'){
            
                multi5TimeError = false;
                
            }
            
            totalHours5 = day5HoursDisplay;
            day5StartTime = mpds5Hour + ':' + mpds5Time + ' ' + mpds5PartOfDay;
            day5EndTime = mpde5Hour + ':' + mpde5Time + ' ' + mpde5PartOfDay;   
        }
        
         totalHoursTaken();
         decimal total = totalHours1 + totalHours2 + totalHours3  + totalHours4  + totalHours5;
         if(totalAvailable < total && unpaidPaid == true){
            negHours = true;
         }
         else if(totalAvailable > total && unpaidPaid == false){
            negHours = false;
         } 
            
        return null;
    }
    public void holidays(){     
    /**********************************************************************************/
    /**************** HARD CODED COMPANY HOLIDAYS  ************************************/
    /**************** TO BE CHANGED ON 12/26 EVERY YEAR *******************************/
    /**************** FORMAT - YEAR - MONTH - DAY *************************************/
    /**************** LOGIC DOES NOT NEED TO BE CHANGED JUST THE DATES ****************/
    /**/date newYearsDay = Date.newInstance(2015, 01, 01);/****************************/
    /**/date mlk = Date.newInstance(2015, 01, 19);/************************************/
    /**/date memorialDay = Date.newInstance(2015, 05, 25);/****************************/
    /**/date independenceDay = Date.newInstance(2015, 07, 03);/************************/
    /**/date laborDay = Date.newInstance(2015, 09, 07);/*******************************/
    /**/date thanksgiving = Date.newInstance(2015, 11, 26);/***************************/
    /**/date dayAfterThanksgiving = Date.newInstance(2015, 11, 27);/*******************/
    /**/date christmasEve = Date.newInstance(2015, 12, 24);/***************************/
    /**/date christmasDay = Date.newInstance(2015, 12, 25);/***************************/
    /**/integer sameYear = system.today().year();/*************************************/
    /**********************************************************************************/
    /**********************************************************************************/
    /**********************************************************************************/
    /**********************************************************************************/
    
        if(days == 'Full Day'){
            if(pto.Full_Day_Date__c == newYearsDay || pto.Full_Day_Date__c == mlk || pto.Full_Day_Date__c == memorialDay || pto.Full_Day_Date__c == independenceDay || pto.Full_Day_Date__c == laborDay || pto.Full_Day_Date__c == thanksgiving || pto.Full_Day_Date__c == dayAfterThanksgiving || pto.Full_Day_Date__c == christmasEve || pto.Full_Day_Date__c == christmasDay){
                holidayDate = true;
            }
            else{
                holidayDate = false;
            }
            /*if(pto.Full_Day_Date__c.year() != system.today().year()){
                sameYearError = true;
            }
            else{
                sameYearError = false;
            }*/
        }
        if(days == 'Partial Day'){
            if(pto.Partial_Day_Date__c == newYearsDay || pto.Partial_Day_Date__c == mlk || pto.Partial_Day_Date__c == memorialDay || pto.Partial_Day_Date__c == independenceDay || pto.Partial_Day_Date__c == laborDay || pto.Partial_Day_Date__c == thanksgiving || pto.Partial_Day_Date__c == dayAfterThanksgiving || pto.Partial_Day_Date__c == christmasEve || pto.Partial_Day_Date__c == christmasDay){
                holidayDate = true;
            }
            else{
                holidayDate = false;
            }
            /*if(pto.Partial_Day_Date__c.year() != sameYear){
                sameYearError = true;
            }
            else{
                sameYearError = false;
            }*/
        }   
        if(days == 'Multiple Days'){
            if(daysBetween > 1){
                if(day1Date == newYearsDay || day2Date == newYearsDay){
                    holidayDate = true;
                }
                else if(day1Date == mlk || day2Date == mlk){
                    holidayDate = true; 
                }
                else if(day1Date == memorialDay || day2Date == memorialDay){
                    holidayDate = true; 
                }
                else if(day1Date == independenceDay || day2Date == independenceDay){
                    holidayDate = true; 
                }
                else if(day1Date == laborDay || day2Date == laborDay){
                    holidayDate = true; 
                }
                else if(day1Date == thanksgiving || day2Date == thanksgiving){
                    holidayDate = true; 
                }
                else if(day1Date == dayAfterThanksgiving || day2Date == dayAfterThanksgiving){
                    holidayDate = true; 
                }
                else if(day1Date == christmasEve || day2Date == christmasEve){
                    holidayDate = true; 
                }
                else if(day1Date == christmasDay || day2Date == christmasDay){
                    holidayDate = true; 
                }
                else{
                    holidayDate = false;
                }
            }
            
            if(daysBetween > 2){
                if(day1Date == newYearsDay || day2Date == newYearsDay || day3Date == newYearsDay){
                    holidayDate = true;
                }
                else if(day1Date == mlk || day2Date == mlk || day3Date == mlk){
                    holidayDate = true; 
                }
                else if(day1Date == memorialDay || day2Date == memorialDay || day3Date == memorialDay){
                    holidayDate = true; 
                }
                else if(day1Date == independenceDay || day2Date == independenceDay || day3Date == independenceDay){
                    holidayDate = true; 
                }
                else if(day1Date == laborDay || day2Date == laborDay || day3Date == laborDay){
                    holidayDate = true; 
                }
                else if(day1Date == thanksgiving || day2Date == thanksgiving || day3Date == thanksgiving){
                    holidayDate = true; 
                }
                else if(day1Date == dayAfterThanksgiving || day2Date == dayAfterThanksgiving || day3Date == dayAfterThanksgiving){
                    holidayDate = true; 
                }
                else if(day1Date == christmasEve || day2Date == christmasEve || day3Date == christmasEve){
                    holidayDate = true; 
                }
                else if(day1Date == christmasDay || day2Date == christmasDay || day3Date == christmasDay){
                    holidayDate = true; 
                }
                else if(day1Date == newYearsDay || day2Date == newYearsDay || day3Date == newYearsDay || day4Date == newYearsDay){
                    holidayDate = true;
                }
                else{
                    holidayDate = false;
                }
            }
            if(daysBetween > 3){
                if(day1Date == newYearsDay || day2Date == newYearsDay || day3Date == newYearsDay || day4Date == newYearsDay){
                    holidayDate = true;
                }
                else if(day1Date == mlk || day2Date == mlk || day3Date == mlk || day4Date == mlk){
                    holidayDate = true;
                }
                else if(day1Date == memorialDay || day2Date == memorialDay || day3Date == memorialDay || day4Date == memorialDay){
                    holidayDate = true;
                }
                else if(day1Date == independenceDay || day2Date == independenceDay || day3Date == independenceDay || day4Date == independenceDay){
                    holidayDate = true;
                }
                else if(day1Date == laborDay || day2Date == laborDay || day3Date == laborDay || day4Date == laborDay){
                    holidayDate = true;
                }
                else if(day1Date == thanksgiving || day2Date == thanksgiving || day3Date == thanksgiving || day4Date == thanksgiving){
                    holidayDate = true;
                }
                else if(day1Date == dayAfterThanksgiving || day2Date == dayAfterThanksgiving || day3Date == dayAfterThanksgiving || day4Date == dayAfterThanksgiving){
                    holidayDate = true;
                }
                else if(day1Date == christmasEve || day2Date == christmasEve || day3Date == christmasEve || day4Date == christmasEve){
                    holidayDate = true;
                }
                else if(day1Date == christmasDay || day2Date == christmasDay || day3Date == christmasDay || day4Date == christmasDay){
                    holidayDate = true;
                }
                else{
                    holidayDate = false;
                }
            }           
            if(daysBetween > 4){
                if(day1Date == newYearsDay || day2Date == newYearsDay || day3Date == newYearsDay || day4Date == newYearsDay || day5Date == newYearsDay){
                    holidayDate = true;
                }
                else if(day1Date == mlk || day2Date == mlk || day3Date == mlk || day4Date == mlk || day5Date == mlk){
                    holidayDate = true;
                }
                else if(day1Date == memorialDay || day2Date == memorialDay || day3Date == memorialDay || day4Date == memorialDay || day5Date == memorialDay){
                    holidayDate = true;
                }
                else if(day1Date == independenceDay || day2Date == independenceDay || day3Date == independenceDay || day4Date == independenceDay || day5Date == independenceDay){
                    holidayDate = true;
                }
                else if(day1Date == laborDay || day2Date == laborDay || day3Date == laborDay || day4Date == laborDay || day5Date == laborDay){
                    holidayDate = true;
                }
                else if(day1Date == thanksgiving || day2Date == thanksgiving || day3Date == thanksgiving || day4Date == thanksgiving || day5Date == thanksgiving){
                    holidayDate = true;
                }
                else if(day1Date == dayAfterThanksgiving || day2Date == dayAfterThanksgiving || day3Date == dayAfterThanksgiving || day4Date == dayAfterThanksgiving || day5Date == dayAfterThanksgiving){
                    holidayDate = true;
                }
                else if(day1Date == christmasEve || day2Date == christmasEve || day3Date == christmasEve || day4Date == christmasEve || day5Date == christmasEve){
                    holidayDate = true;
                }
                else if(day1Date == christmasDay || day2Date == christmasDay || day3Date == christmasDay || day4Date == christmasDay || day5Date == christmasDay){
                    holidayDate = true;
                }
                else{
                    holidayDate = false;
                }
            }
            /*if(pto.Multi_Day_From__c.year() != sameYear){
                sameYearError = true;
            }
            else{
                sameYearError = false;
            }
            if(pto.Multi_Day_To__c.year() != sameYear){
                sameYearError = true;
            }
            else{
                sameYearError = false;
            }*/
        }
    }
    
    public PageReference multiDays(){
        
        pto.Day_1_Date__c = null;
        pto.Day_2_Date__c = null;
        pto.Day_3_Date__c = null;
        pto.Day_4_Date__c = null;
        pto.Day_5_Date__c = null;
        
        pto.Day_1_Hours_to_be_Used__c = null;
        pto.Day_2_Hours_to_be_Used__c = null;
        pto.Day_3_Hours_to_be_Used__c = null;
        pto.Day_4_Hours_to_be_Used__c = null;
        pto.Day_5_Hours_to_be_Used__c = null;
        
        if(pto.Multi_Day_From__c != null && pto.Multi_Day_To__c != null){
            
            /*totalHours1 = 8;
            totalHours2 = 8;
            totalHours3 = 8;
            totalHours4 = 8;
            totalHours5 = 8;*/
            
            totalHours1 = null;
            totalHours2 = null;
            totalHours3 = null;
            totalHours4 = null;
            totalHours5 = null;
            
            day1HoursDisplay = 0;
            day2HoursDisplay = 0;
            day3HoursDisplay = 0;
            day4HoursDisplay = 0;
            day5HoursDisplay = 0;
            
            nullDateMulti = false;
            
            date startDate = pto.Multi_Day_From__c;
            date endDate = pto.Multi_Day_To__c;
            startOfWeekDate = startDate.toStartofWeek();
            monthStart = startDate.month();
            daysBetween = startDate.daysBetween(endDate) + 1;
             
            day1Date = pto.Multi_Day_From__c;
            pto.Day_1_Date__c = pto.Multi_Day_From__c;
            day1HoursDisplay = 8;
            pto.Day_1_Hours_To_Be_Used__c = day1HoursDisplay;
            /*if(pto.Partial_Day_1__c == false){
            multiDayPartialDay1StartTime = '99.99';
            multiDayPartialDay1EndTime = '99.99';
            }*/
            
            if(endDate < startDate){
                
                endBeforeStart = true;
            }
            else{
                
                endBeforeStart = false;
                
            }
            
            if(endDate > startOfWeekDate + 7){
                
                sameWeekError = true;
            }
            else{
                
                sameWeekError = false;
            }
            
            if(daysBetween > 1){
                
                day2Date = startDate.addDays(1);
                pto.Day_2_Date__c = startDate.addDays(1);               
                day1HoursDisplay = 8;
                day2HoursDisplay = 8;
                day3HoursDisplay = 0;
                day4HoursDisplay = 0;
                day5HoursDisplay = 0;
                
                totalHoursPlaceholder = day1HoursDisplay + day2HoursDisplay;
                pto.Day_2_Hours_To_Be_Used__c = day2HoursDisplay;
                holidays();
                
            }else{
                
                day2Date = pto.Multi_Day_To__c;
                pto.Day_2_Date__c = pto.Multi_Day_To__c;
                day2HoursDisplay = 8;
                pto.Day_2_Hours_To_Be_Used__c = day2HoursDisplay;
                holidays();
                
            }
            if(daysBetween > 2){
                day2Date = startDate.addDays(1);
                pto.Day_2_Date__c = startDate.addDays(1);
                day3Date = startDate.addDays(2);
                pto.Day_3_Date__c = startDate.addDays(2);
                system.debug('WTF');    
                totalHoursPlaceholder = 24;
                day3HoursDisplay = 8;
                pto.Day_3_Hours_To_Be_Used__c = day3HoursDisplay;
                holidays();
                    
            }
            if(daysBetween > 3){
                
                day2Date = startDate.addDays(1);
                pto.Day_2_Date__c = startDate.addDays(1);
                day3Date = startDate.addDays(2);
                pto.Day_3_Date__c = startDate.addDays(2);
                day4Date = startDate.addDays(3);
                pto.Day_4_Date__c = startDate.addDays(3);   
                totalHoursPlaceholder = 32;
                day4HoursDisplay = 8;
                pto.Day_4_Hours_To_Be_Used__c = day4HoursDisplay;
                holidays();
                    
                
            }
            if(daysBetween > 4){
                
                day2Date = startDate.addDays(1);
                pto.Day_2_Date__c = startDate.addDays(1);
                day3Date = startDate.addDays(2);
                pto.Day_3_Date__c = startDate.addDays(2);
                day4Date = startDate.addDays(3);
                pto.Day_4_Date__c = startDate.addDays(3);
                day5Date = startDate.addDays(4);
                pto.Day_5_Date__c = startDate.addDays(4);   
                totalHoursPlaceholder = 40;
                day5HoursDisplay = 8;
                pto.Day_5_Hours_To_Be_Used__c = day5HoursDisplay;
                holidays();

            }
            //totalHoursPlaceHolder = day1HoursDisplay + day2HoursDisplay + day3HoursDisplay + day4HoursDisplay + day5HoursDisplay;
            totalMultiHours = totalHoursPlaceHolder;
            
            /*if(totalAvailable < totalMultiHours && unpaidPaid == true){
                negHours = true;
            }
            else if(totalAvailable > totalMultiHours && unpaidPaid == false){
                negHours = false;
            }*/
            
        }
        
        
        
        return null;
    }
    
    
    public PageReference multiDaysEdit(){
        
        tor.Day_1_Date__c = null;
        tor.Day_2_Date__c = null;
        tor.Day_3_Date__c = null;
        tor.Day_4_Date__c = null;
        tor.Day_5_Date__c = null;
        
        tor.Day_1_Hours_To_Be_Used__c = null;
        tor.Day_2_Hours_To_Be_Used__c = null;
        tor.Day_3_Hours_To_Be_Used__c = null;
        tor.Day_4_Hours_To_Be_Used__c = null;
        tor.Day_5_Hours_To_Be_Used__c = null;
        
        if(pto.Multi_Day_From__c != null && pto.Multi_Day_To__c != null){
            
            totalHours1 = 8;
            totalHours2 = 8;
            totalHours3 = 8;
            totalHours4 = 8;
            totalHours5 = 8;
            
            
            
            nullDateMulti = false;
            
            date startDate = pto.Multi_Day_From__c;
            date endDate = pto.Multi_Day_To__c;
            startOfWeekDate = startDate.toStartofWeek();
            monthStart = startDate.month();
            daysBetween = startDate.daysBetween(endDate) + 1;
             
            day1Date = pto.Multi_Day_From__c;
            tor.Day_1_Date__c = pto.Multi_Day_From__c;
            day1HoursDisplay = 8;
            tor.Day_1_Hours_To_Be_Used__c = day1HoursDisplay;
            
            if(endDate > startOfWeekDate + 7){
                
                sameWeekError = true;
            }
            else{
                
                sameWeekError = false;
            }
            
            if(daysBetween > 1){
                
                day2Date = startDate.addDays(1);
                tor.Day_2_Date__c = startDate.addDays(1);
                totalHoursPlaceholder = 16;
                day2HoursDisplay = 8;
                tor.Day_2_Hours_To_Be_Used__c = day2HoursDisplay;
                pto.Partial_Day_3__c = false;
                pto.Partial_Day_4__c = false;
                pto.Partial_Day_5__c = false;
                    
                
            }else{
                
                day2Date = pto.Multi_Day_To__c;
                tor.Day_2_Date__c = pto.Multi_Day_To__c;
                day2HoursDisplay = 8;
                tor.Day_2_Hours_To_Be_Used__c = day2HoursDisplay;
                
            }
            if(daysBetween > 2){
                day2Date = startDate.addDays(1);
                tor.Day_2_Date__c = startDate.addDays(1);
                day3Date = startDate.addDays(2);
                tor.Day_3_Date__c = startDate.addDays(2);   
                totalHoursPlaceholder = 24;
                day3HoursDisplay = 8;
                tor.Day_3_Hours_To_Be_Used__c = day3HoursDisplay;
                pto.Partial_Day_4__c = false;
                pto.Partial_Day_5__c = false;
                    
            }
            if(daysBetween > 3){
                
                day2Date = startDate.addDays(1);
                tor.Day_2_Date__c = startDate.addDays(1);
                day3Date = startDate.addDays(2);
                tor.Day_3_Date__c = startDate.addDays(2);
                day4Date = startDate.addDays(3);
                tor.Day_4_Date__c = startDate.addDays(3);   
                totalHoursPlaceholder = 32;
                day4HoursDisplay = 8;
                tor.Day_4_Hours_To_Be_Used__c = day4HoursDisplay;
                pto.Partial_Day_5__c = false;
                    
                
            }
            if(daysBetween > 4){
                
                day2Date = startDate.addDays(1);
                tor.Day_2_Date__c = startDate.addDays(1);
                day3Date = startDate.addDays(2);
                tor.Day_3_Date__c = startDate.addDays(2);
                day4Date = startDate.addDays(3);
                tor.Day_4_Date__c = startDate.addDays(3);
                day5Date = startDate.addDays(4);
                tor.Day_5_Date__c = startDate.addDays(4);   
                totalHoursPlaceholder = 40;
                day5HoursDisplay = 8;
                tor.Day_5_Hours_To_Be_Used__c = day5HoursDisplay;

            }
            
            totalMultiHours = totalHoursPlaceHolder;
        }
        
        return null;
    }
        
    public List<SelectOption> pup = new List<SelectOption>();
    
    public List<SelectOption> getPup(){
        List<SelectOption> pupChoice = new List<SelectOption>();
        pupChoice.add(new SelectOption('Planned', 'Planned'));
        pupChoice.add(new SelectOption('Unplanned', 'Unplanned'));
        return pupChoice;
    }
    
    public List<SelectOption> lunch = new List<SelectOption>();
    
    public List<SelectOption> getLunch(){
        
        List<SelectOption> lunchHour = new List<SelectOption>();
        lunchHour.add(new SelectOption('NO', 'NO'));
        lunchHour.add(new SelectOption('YES', 'YES'));
        return lunchHour;
    }
    
    public List<SelectOption> items = new List<SelectOption>();
    
    public List<SelectOption> getItems() {
    
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select PTO Type...', 'Select PTO Type...'));
        options.add(new SelectOption('Full Day', 'Full Day'));
        options.add(new SelectOption('Partial Day', 'Partial Day'));
        options.add(new SelectOption('Multiple Days', 'Multiple Days'));
        return options;
        
    }
    
    public List<SelectOption> partialTimes = new List<SelectOption>();
    
    public List<selectOption> getpartialTimes(){
        
        List<SelectOption> times = new List<SelectOption>();
        times.add(new SelectOption('Select Time...', 'Select Time...'));
        times.add(new SelectOption('7.00', '7:00 AM'));
        times.add(new SelectOption('7.25', '7:15 AM'));
        times.add(new SelectOption('7.50', '7:30 AM'));
        times.add(new SelectOption('7.75', '7:45 AM'));
        times.add(new SelectOption('8.00', '8:00 AM'));
        times.add(new SelectOption('8.25', '8:15 AM'));
        times.add(new SelectOption('8.50', '8:30 AM'));
        times.add(new SelectOption('8.75', '8:45 AM'));
        times.add(new SelectOption('9.00', '9:00 AM'));
        times.add(new SelectOption('9.25', '9:15 AM'));
        times.add(new SelectOption('9.50', '9:30 AM'));
        times.add(new SelectOption('9.75', '9:45 AM'));
        times.add(new SelectOption('10.00', '10:00 AM'));
        times.add(new SelectOption('10.25', '10:15 AM'));
        times.add(new SelectOption('10.50', '10:30 AM'));
        times.add(new SelectOption('10.75', '10:45 AM'));
        times.add(new SelectOption('11.00', '11:00 AM'));
        times.add(new SelectOption('11.25', '11:15 AM'));
        times.add(new SelectOption('11.50', '11:30 AM'));
        times.add(new SelectOption('11.75', '11:45 AM'));
        times.add(new SelectOption('12.00', '12:00 PM'));
        times.add(new SelectOption('12.25', '12:15 PM'));
        times.add(new SelectOption('12.50', '12:30 PM'));
        times.add(new SelectOption('12.75', '12:45 PM'));
        times.add(new SelectOption('13.00', '1:00 PM'));
        times.add(new SelectOption('13.25', '1:15 PM'));
        times.add(new SelectOption('13.50', '1:30 PM'));
        times.add(new SelectOption('13.75', '1:45 PM'));
        times.add(new SelectOption('14.00', '2:00 PM'));
        times.add(new SelectOption('14.25', '2:15 PM'));
        times.add(new SelectOption('14.50', '2:30 PM'));
        times.add(new SelectOption('14.75', '2:45 PM'));
        times.add(new SelectOption('15.00', '3:00 PM'));
        times.add(new SelectOption('15.25', '3:15 PM'));
        times.add(new SelectOption('15.50', '3:30 PM'));
        times.add(new SelectOption('15.75', '3:45 PM'));
        times.add(new SelectOption('16.00', '4:00 PM'));
        times.add(new SelectOption('16.25', '4:15 PM'));
        times.add(new SelectOption('16.50', '4:30 PM'));
        times.add(new SelectOption('16.75', '4:45 PM'));
        times.add(new SelectOption('17.00', '5:00 PM'));
        times.add(new SelectOption('17.25', '5:15 PM'));
        times.add(new SelectOption('17.50', '5:30 PM'));
        times.add(new SelectOption('17.75', '5:45 PM'));
        times.add(new SelectOption('18.00', '6:00 PM'));
        times.add(new SelectOption('18.25', '6:15 PM'));
        times.add(new SelectOption('18.50', '6:30 PM'));
        times.add(new SelectOption('18.75', '6:45 PM'));
        times.add(new SelectOption('19.00', '7:00 PM'));
        times.add(new SelectOption('19.25', '7:15 PM'));
        times.add(new SelectOption('19.50', '7:30 PM'));
        times.add(new SelectOption('19.75', '7:45 PM'));
        times.add(new SelectOption('20.00', '8:00 PM'));
         
        return times;
    }
    
    public List<SelectOption> multiDayTimes = new List<SelectOption>();
    
    public List<SelectOption> getMultiDayTimes(){
        
        List<SelectOption> times = new List<SelectOption>();
        times.add(new SelectOption('99.99', 'Select Time...'));
        times.add(new SelectOption('7.00', '7:00 AM'));
        times.add(new SelectOption('7.25', '7:15 AM'));
        times.add(new SelectOption('7.50', '7:30 AM'));
        times.add(new SelectOption('7.75', '7:45 AM'));
        times.add(new SelectOption('8.00', '8:00 AM'));
        times.add(new SelectOption('8.25', '8:15 AM'));
        times.add(new SelectOption('8.50', '8:30 AM'));
        times.add(new SelectOption('8.75', '8:45 AM'));
        times.add(new SelectOption('9.00', '9:00 AM'));
        times.add(new SelectOption('9.25', '9:15 AM'));
        times.add(new SelectOption('9.50', '9:30 AM'));
        times.add(new SelectOption('9.75', '9:45 AM'));
        times.add(new SelectOption('10.00', '10:00 AM'));
        times.add(new SelectOption('10.25', '10:15 AM'));
        times.add(new SelectOption('10.50', '10:30 AM'));
        times.add(new SelectOption('10.75', '10:45 AM'));
        times.add(new SelectOption('11.00', '11:00 AM'));
        times.add(new SelectOption('11.25', '11:15 AM'));
        times.add(new SelectOption('11.50', '11:30 AM'));
        times.add(new SelectOption('11.75', '11:45 AM'));
        times.add(new SelectOption('12.00', '12:00 PM'));
        times.add(new SelectOption('12.25', '12:15 PM'));
        times.add(new SelectOption('12.50', '12:30 PM'));
        times.add(new SelectOption('12.75', '12:45 PM'));
        times.add(new SelectOption('13.00', '1:00 PM'));
        times.add(new SelectOption('13.25', '1:15 PM'));
        times.add(new SelectOption('13.50', '1:30 PM'));
        times.add(new SelectOption('13.75', '1:45 PM'));
        times.add(new SelectOption('14.00', '2:00 PM'));
        times.add(new SelectOption('14.25', '2:15 PM'));
        times.add(new SelectOption('14.50', '2:30 PM'));
        times.add(new SelectOption('14.75', '2:45 PM'));
        times.add(new SelectOption('15.00', '3:00 PM'));
        times.add(new SelectOption('15.25', '3:15 PM'));
        times.add(new SelectOption('15.50', '3:30 PM'));
        times.add(new SelectOption('15.75', '3:45 PM'));
        times.add(new SelectOption('16.00', '4:00 PM'));
        times.add(new SelectOption('16.25', '4:15 PM'));
        times.add(new SelectOption('16.50', '4:30 PM'));
        times.add(new SelectOption('16.75', '4:45 PM'));
        times.add(new SelectOption('17.00', '5:00 PM'));
        times.add(new SelectOption('17.25', '5:15 PM'));
        times.add(new SelectOption('17.50', '5:30 PM'));
        times.add(new SelectOption('17.75', '5:45 PM'));
        times.add(new SelectOption('18.00', '6:00 PM'));
        times.add(new SelectOption('18.25', '6:15 PM'));
        times.add(new SelectOption('18.50', '6:30 PM'));
        times.add(new SelectOption('18.75', '6:45 PM'));
        times.add(new SelectOption('19.00', '7:00 PM'));
        times.add(new SelectOption('19.25', '7:15 PM'));
        times.add(new SelectOption('19.50', '7:30 PM'));
        times.add(new SelectOption('19.75', '7:45 PM'));
        times.add(new SelectOption('20.00', '8:00 PM'));
         
        return times;
    }
    
    
    public void createNewPTO(){
        
        day1Hours = 0;
        day2Hours = 0;
        day3Hours = 0;
        day4Hours = 0;
        day5Hours = 0;
                
        pto.Time_Off_Balance__c = balId;
        pto.Employee_s_Name__c = userId;
        
        if(days == 'Full Day'){

                pto.Hours_to_be_Used__c = 8;
                Date fromDate = pto.Full_Day_Date__c;
                Date toDate = pto.Full_Day_Date__c;
                Datetime dt1 = datetime.newInstance(fromDate.year(), fromDate.month(), fromDate.day());
                Datetime dt2 = datetime.newInstance(toDate.year(), toDate.month(), toDate.day());
                pto.From__c = pto.Full_Day_Date__c;
                pto.To__c = pto.Full_Day_Date__c;
                pto.From_Date__c = dt1;
                pto.To_Date__c = dt2;
                //pto.RecordTypeId = '012S00000008sJj';  //sandbox
                pto.RecordTypeId = '01270000000Q9s6';  //prod
                pto.Type__c = pto.Type__c;
                pto.Notes__c = pto.Notes__c;
            
            
        }
        
        if(days == 'Partial Day'){
        
            Date fromDate = pto.Partial_Day_Date__c;
            Date toDate = pto.Partial_Day_Date__c;
            
            Datetime dt1 = datetime.newInstance(fromDate.year(), fromDate.month(), fromDate.day());
            Datetime dt2 = datetime.newInstance(toDate.year(), toDate.month(), toDate.day());
            
            Decimal partialStart = decimal.valueOf(partialTimeStart);
            Decimal partialEnd = decimal.valueOf(partialTimeEnd);
            
            String partialStartString = string.valueOf(partialTimeStart);
            String pssHour = partialStartString.substringBefore('.');
            Decimal pssHourDecimal = decimal.valueOf(pssHour);
            String pssMinutes = partialStartString.substringAfter('.'); 
            String pssTime;
            //String pssHour1;
            String partOfDay = 'AM';
            String partOfDayEnd = 'AM';
            
            String partialEndString = string.valueOf(partialTimeEnd);
            String pesHour = partialEndString.substringBefore('.');
            Decimal pesHourDecimal = decimal.valueOf(pesHour);
            String pesMinutes = partialEndString.substringAfter('.');
            String pesTime;
            
            if(pssHourDecimal > 11.99){
                if(pssHourDecimal > 12){
                    pssHourDecimal = pssHourDecimal - 12;
                }
                pssHour = string.valueOf(pssHourDecimal);
                partOfDay = 'PM';
                
            }
            
            if(pesHourDecimal > 11.99){
                if(pesHourDecimal > 12){
                    pesHourDecimal = pesHourDecimal - 12;
                }
                pesHour = string.valueOf(pesHourDecimal);
                partOfDayEnd = 'PM';
                
            }
            
            if(pssMinutes == '00'){
                
                pssTime = '00';
                
            }
            else if(pssMinutes == '25'){
                
                pssTime = '15';
                
            }
            else if(pssMinutes == '50'){
                
                pssTime = '30';
                
            }
            else if(pssMinutes == '75'){
            
                pssTime = '45';
                
            }
            
            if(pesMinutes == '00'){
            
                pesTime = '00'; 
                
            }
            else if(pesMinutes == '25'){
                
                pesTime = '15';
                
            }
            else if(pesMinutes == '50'){
                
                pesTime = '30';
                
            }
            else if(pesMinutes == '75'){
                
                pesTime = '45';
                
            }
            Decimal timeBetween = partialEnd - partialStart;
            Decimal timeBetweenLunch = partialEnd - partialStart - 1;
            
            if(lunches == 'NO'){
                
                pto.Hours_To_be_Used__c = timeBetween;
            }
            else if(lunches == 'YES'){
                
                pto.Hours_To_be_Used__c = timeBetweenLunch;
            }
            
            pto.From__c = pto.Partial_Day_Date__c;
            pto.To__c = pto.Partial_Day_Date__c;
            pto.From_Date__c = dt1;
            pto.To_Date__c = dt2;
            //pto.RecordTypeId = '012S00000008sJo';  //sandbox
            pto.RecordTypeId = '01270000000Q9sB';  //prod
            pto.Partial_Day_Start_Time__c = pssHour + ':' + pssTime + ' ' + partOfDay; 
            pto.Partial_Day_End_Time__c = pesHour + ':' + pesTime + ' ' + partOfDayEnd;
            pto.Partial_Day_Lunch__c = lunches;
            pto.StartTimePH__c = partialTimeStart;
            pto.EndTimePH__c = partialTimeEnd;
            pto.Type__c = pto.Type__c;
            pto.Notes__c = pto.Notes__c;
            
            
        }
        
        if(days == 'Multiple Days'){
            
            Date fromDate = pto.Multi_Day_From__c;
            Date toDate = pto.Multi_Day_To__c;
            
            Datetime dt1 = datetime.newInstance(fromDate.year(), fromDate.month(), fromDate.day(), 01, 0, 0);
            Datetime dt2 = datetime.newInstance(toDate.year(), toDate.month(), toDate.day(), 01, 0, 0);
                    
            date startDate = pto.Multi_Day_From__c;
            date endDate = pto.Multi_Day_To__c;
            startOfWeekDate = startDate.toStartofWeek();
            daysBetween = startDate.daysBetween(endDate);
            totaldays = startDate.daysBetween(endDate) + 1;
            //pto.RecordTypeId = '012S00000008sJt';  //sandbox
            pto.RecordTypeId = '01270000000Q9sG';  //prod
            pto.Type__c = pto.Type__c;
            pto.Notes__c = pto.Notes__c;
             
        
            if(pto.Multi_Day_From__c != null && pto.Multi_Day_To__c != null){
                
                
                if(daysBetween == 1){
                    
                    if(pto.Partial_Day_1__c == false){
                        
                        day1hours = 8;
                        pto.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_1__c == true){
                        
                        if(lunch1 == 'NO'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start;
                            pto.Day_1_Times__c = day1End - day1Start;
                            pto.Day_1_Lunch__c = 'NO';
                            
                        }
                        else if(lunch1 == 'YES'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start - 1;
                            pto.Day_1_Times__c = day1End - day1Start - 1;
                            pto.Day_1_Lunch__c = 'YES';
                            
                        }
                        pto.Day_1_Start_Time__c = day1StartTime;
                        pto.Day_1_End_Time__c = day1EndTime;
                        pto.StartTime1PH__c = multiDayPartialDay1StartTime;
                        pto.EndTime1PH__c = multiDayPartialDay1EndTime;
                        
                    }
                    if(pto.Partial_Day_2__c == false){
                        
                            day2hours = 8;
                            pto.Day_2_Times__c = 8;
                    }
                     else if(pto.Partial_Day_2__c == true){
                        
                        if(lunch2 == 'NO'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start;
                            pto.Day_2_Times__c = day2End - day2Start;
                            pto.Day_2_Lunch__c = 'NO';
                            
                        }
                        else if(lunch2 == 'YES'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start - 1;
                            pto.Day_2_Times__c = day2End - day2Start - 1;
                            pto.Day_2_Lunch__c = 'YES'; 
                        }
                        
                        pto.Day_2_Start_Time__c = day2StartTime;
                        pto.Day_2_End_Time__c = day2EndTime;
                        pto.StartTime2PH__c = multiDayPartialDay2StartTime;
                        pto.EndTime2PH__c = multiDayPartialDay2EndTime;
                    }
                }
                    
                if(daysBetween == 2){
                    
                    if(pto.Partial_Day_1__c == false){
                        
                        day1hours = 8;
                        pto.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_1__c == true){
                        
                        if(lunch1 == 'NO'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start;
                            pto.Day_1_Times__c = day1End - day1Start;
                            pto.Day_1_Lunch__c = 'NO';
                            
                            
                        }
                        else if(lunch1 == 'YES'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start - 1;
                            pto.Day_1_Times__c = day1End - day1Start - 1;
                            pto.Day_1_Lunch__c = 'YES';
                            
                        }
                        
                        pto.Day_1_Start_Time__c = day1StartTime;
                        pto.Day_1_End_Time__c = day1EndTime;
                        pto.StartTime1PH__c = multiDayPartialDay1StartTime;
                        pto.EndTime1PH__c = multiDayPartialDay1EndTime;
                        
                    }
                    if(pto.Partial_Day_2__c == false){
                        
                            day2hours = 8;
                            pto.Day_2_Times__c = 8;
                    }
                    else if(pto.Partial_Day_2__c == true){
                        
                        if(lunch2 == 'NO'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start;
                            pto.Day_2_Times__c = day2End - day2Start;
                            pto.Day_2_Lunch__c = 'NO';
                            
                        }
                        else if(lunch2 == 'YES'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start - 1;
                            pto.Day_2_Times__c = day2End - day2Start - 1;
                            pto.Day_2_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_2_Start_Time__c = day2StartTime;
                        pto.Day_2_End_Time__c = day2EndTime;
                        pto.StartTime2PH__c = multiDayPartialDay2StartTime;
                        pto.EndTime2PH__c = multiDayPartialDay2EndTime;
                        
                    }
                    if(pto.Partial_Day_3__c == false){
                        
                            day3hours = 8;
                            pto.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_3__c == true){
                        
                        if(lunch3 == 'NO'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start;
                            pto.Day_3_Times__c = day3End - day3Start;
                            pto.Day_3_Lunch__c = 'NO';
                            
                        }
                        else if(lunch3 == 'YES'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start - 1;
                            pto.Day_3_Times__c = day3End - day3Start - 1;
                            pto.Day_3_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_3_Start_Time__c = day3StartTime;
                        pto.Day_3_End_Time__c = day3EndTime;
                        pto.StartTime3PH__c = multiDayPartialDay3StartTime;
                        pto.EndTime3PH__c = multiDayPartialDay3EndTime;
                    }
                    
                }
                
                if(daysBetween == 3){
                    
                    if(pto.Partial_Day_1__c == false){
                        
                        day1hours = 8;
                        pto.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_1__c == true){
                        
                        if(lunch1 == 'NO'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start;
                            pto.Day_1_Times__c = day1End - day1Start;
                            pto.Day_1_Lunch__c = 'NO';
                            
                        }
                        else if(lunch1 == 'YES'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start - 1;
                            pto.Day_1_Times__c = day1End - day1Start - 1;
                            pto.Day_1_Lunch__c = 'YES';
                            
                        }
                        
                        pto.Day_1_Start_Time__c = day1StartTime;
                        pto.Day_1_End_Time__c = day1EndTime;
                        pto.StartTime1PH__c = multiDayPartialDay1StartTime;
                        pto.EndTime1PH__c = multiDayPartialDay1EndTime;
                        
                    }
                    if(pto.Partial_Day_2__c == false){
                        
                            day2hours = 8;
                            pto.Day_2_Times__c = 8;
                    }
                    else if(pto.Partial_Day_2__c == true){
                        
                        if(lunch2 == 'NO'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start;
                            pto.Day_2_Times__c = day2End - day2Start;
                            pto.Day_2_Lunch__c = 'NO';
                            
                        }
                        else if(lunch2 == 'YES'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start - 1;
                            pto.Day_2_Times__c = day2End - day2Start - 1;
                            pto.Day_2_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_2_Start_Time__c = day2StartTime;
                        pto.Day_2_End_Time__c = day2EndTime;
                        pto.StartTime2PH__c = multiDayPartialDay2StartTime;
                        pto.EndTime2PH__c = multiDayPartialDay2EndTime;
                        
                    }
                    if(pto.Partial_Day_3__c == false){
                        
                            day3hours = 8;
                            pto.Day_3_Times__c = 8;
                    }
                    else if(pto.Partial_Day_3__c == true){
                        
                        if(lunch3 == 'NO'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start;
                            pto.Day_3_Times__c = day3End - day3Start;
                            pto.Day_3_Lunch__c = 'NO';
                            
                        }
                        else if(lunch3 == 'YES'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start - 1;
                            pto.Day_3_Times__c = day3End - day3Start - 1;
                            pto.Day_3_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_3_Start_Time__c = day3StartTime;
                        pto.Day_3_End_Time__c = day3EndTime;
                        pto.StartTime3PH__c = multiDayPartialDay3StartTime;
                        pto.EndTime3PH__c = multiDayPartialDay3EndTime;
                        
                    }
                    if(pto.Partial_Day_4__c == false){
                        
                            day4hours = 8;
                            pto.Day_4_Times__c = 8;
                    }
                    else if(pto.Partial_Day_4__c == true){
                        
                        if(lunch4 == 'NO'){
                            
                            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
                            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
                            day4hours = day4End - day4Start;
                            pto.Day_4_Times__c = day4End - day4Start;
                            pto.Day_4_Lunch__c = 'NO';
                            
                        }
                        else if(lunch4 == 'YES'){
                            
                            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
                            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
                            day4hours = day4End - day4Start - 1;
                            pto.Day_4_Times__c = day4End - day4Start - 1;
                            pto.Day_4_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_4_Start_Time__c = day4StartTime;
                        pto.Day_4_End_Time__c = day4EndTime;
                        pto.StartTime4PH__c = multiDayPartialDay4StartTime;
                        pto.EndTime4PH__c = multiDayPartialDay4EndTime;
                    }
                    
                }
                
                if(daysBetween == 4){
                    
                    if(pto.Partial_Day_1__c == false){
                        
                        day1hours = 8;
                        pto.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_1__c == true){
                        
                        if(lunch1 == 'NO'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start;
                            pto.Day_1_Times__c = day1End - day1Start;
                            pto.Day_1_Lunch__c = 'NO';
                            
                        }
                        else if(lunch1 == 'YES'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start - 1;
                            pto.Day_1_Times__c = day1End - day1Start -1;
                            pto.Day_1_Lunch__c = 'YES';
                            
                        }
                        
                        pto.Day_1_Start_Time__c = day1StartTime;
                        pto.Day_1_End_Time__c = day1EndTime;
                        pto.StartTime1PH__c = multiDayPartialDay1StartTime;
                        pto.EndTime1PH__c = multiDayPartialDay1EndTime;
                        
                    }
                    if(pto.Partial_Day_2__c == false){
                        
                            day2hours = 8;
                            pto.Day_2_Times__c = 8;
                    }
                    else if(pto.Partial_Day_2__c == true){
                        
                        if(lunch2 == 'NO'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start;
                            pto.Day_2_Times__c = day2End - day2Start;
                            pto.Day_2_Lunch__c = 'NO';
                            
                        }
                        else if(lunch2 == 'YES'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start - 1;
                            pto.Day_2_Times__c = day2End - day2Start - 1;
                            pto.Day_2_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_2_Start_Time__c = day2StartTime;
                        pto.Day_2_End_Time__c = day2EndTime;
                        pto.StartTime2PH__c = multiDayPartialDay2StartTime;
                        pto.EndTime2PH__c = multiDayPartialDay2EndTime;
                        
                    }
                    if(pto.Partial_Day_3__c == false){
                        
                            day3hours = 8;
                            pto.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_3__c == true){
                        
                        if(lunch3 == 'NO'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start;
                            pto.Day_3_Times__c = day3End - day3Start;
                            pto.Day_3_Lunch__c = 'NO';
                            
                        }
                        else if(lunch3 == 'YES'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start - 1;
                            pto.Day_3_Times__c = day3End - day3Start - 1;
                            pto.Day_3_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_3_Start_Time__c = day3StartTime;
                        pto.Day_3_End_Time__c = day3EndTime;
                        pto.StartTime3PH__c = multiDayPartialDay3StartTime;
                        pto.EndTime3PH__c = multiDayPartialDay3EndTime;
                        
                    }
                    if(pto.Partial_Day_4__c == false){
                        
                            day4hours = 8;
                            pto.Day_4_Times__c = 8;
                    }
                    else if(pto.Partial_Day_4__c == true){
                        
                        if(lunch4 == 'NO'){
                            
                            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
                            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
                            day4hours = day4End - day4Start;
                            pto.Day_4_Times__c = day4End - day4Start;
                            pto.Day_4_Lunch__c = 'NO';
                            
                        }
                        else if(lunch4 == 'YES'){
                            
                            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
                            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
                            day4hours = day4End - day4Start - 1;
                            pto.Day_4_Times__c = day4End - day4Start - 1;
                            pto.Day_4_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_4_Start_Time__c = day4StartTime;
                        pto.Day_4_End_Time__c = day4EndTime;
                        pto.StartTime4PH__c = multiDayPartialDay4StartTime;
                        pto.EndTime4PH__c = multiDayPartialDay4EndTime;
                    }
                    if(pto.Partial_Day_5__c == false){
                        
                            day5hours = 8;
                            pto.Day_5_Times__c = 8;
                    }
                    else if(pto.Partial_Day_5__c == true){
                        
                        if(lunch5 == 'NO'){
                            
                            decimal day5Start = decimal.valueOf(multiDayPartialDay5StartTime);
                            decimal day5End = decimal.valueOf(multiDayPartialDay5EndTime);
                            day5hours = day5End - day5Start;
                            pto.Day_5_Times__c = day5End - day5Start;
                            pto.Day_5_Lunch__c = 'NO';
                            
                        }
                        else if(lunch5 == 'YES'){
                            
                            decimal day5Start = decimal.valueOf(multiDayPartialDay5StartTime);
                            decimal day5End = decimal.valueOf(multiDayPartialDay5EndTime);
                            day5hours = day5End - day5Start - 1;
                            pto.Day_5_Times__c = day5End - day5Start - 1;
                            pto.Day_5_Lunch__c = 'YES';
                                
                        }
                        
                        pto.Day_5_Start_Time__c = day5StartTime;
                        pto.Day_5_End_Time__c = day5EndTime;
                        pto.StartTime5PH__c = multiDayPartialDay5StartTime;
                        pto.EndTime5PH__c = multiDayPartialDay5EndTime;
                        
                    }
                    
                }
            }
                
            pto.From__c = pto.Multi_Day_From__c;
            pto.To__c = pto.Multi_Day_To__c;
            pto.From_Date__c = dt1;
            pto.To_Date__c = dt2;
            pto.Multiple_Days__c = daysBetween;
            pto.Hours_to_be_Used__c = day1hours + day2hours + day3hours + day4hours +  day5hours;
                
        }
        
        //if(totalAvailable >= pto.Hours_to_be_Used__c || unpaidPaid == false){
            insert pto;
        //}
    }
    
    public PageReference balReturn(){
                        
            if(days != 'Select PTO Type...'){
                
                if(days == 'Full Day' && pto.Full_Day_Date__c != null){
                    
                    createNewPTO();
                    PageReference pr = new PageReference('/' + pto.Id);
                    return pr;
                    
                }
                if(days == 'Partial Day' && pto.Partial_Day_Date__c != null && partialTimeStart != 'Select Time..' && partialTimeEnd != 'Select Time...'){
                    
                    createNewPTO();
                    PageReference pr = new PageReference('/' + pto.Id);
                    return pr;
                    
                }
                if(days == 'Multiple Days' && pto.Multi_Day_From__c != null && pto.Multi_Day_To__c != null){
                    
                    createNewPTO();
                    PageReference pr = new PageReference('/' + pto.Id);
                    return pr;
    
                }
            }
            
            if(days == 'Full Day' && pto.Full_Day_Date__c == null){
                
                nullDate = true;
                
            }
            if(days == 'Partial Day' && pto.Partial_Day_Date__c == null){
                
                nullDatePartial = true;
                
            }
            if(days == 'Multiple Days' && pto.Multi_Day_From__c == null || pto.Multi_Day_To__c == null){
                
                nullDateMulti = true;
                
            }
            if(partialTimeStart == 'Select Time...'){
            
                partialTimeError = true;
                
            }
            if(partialTimeEnd == 'Select Time...'){
                
                partialTimeError = true;
                
            }
            if(pto.Partial_Day_1__c == true && multiDayPartialDay1StartTime == 'Select Time...'){
                
                multi1TimeError = true;
            }
            
            
            
        
        return null;
    }
    
    public PageReference updatePTO(){
        
        if(days != 'Select PTO Type...'){
                
                if(days == 'Full Day' && pto.Full_Day_Date__c != null){
                    
                    editPTO();
                    PageReference pr = new PageReference('/' + tor.Id);
                    return pr;
                    
                }
                if(days == 'Partial Day' && pto.Partial_Day_Date__c != null){
                    
                    editPTO();
                    PageReference pr = new PageReference('/' + tor.Id);
                    return pr;
                    
                }
                if(days == 'Multiple Days' && pto.Multi_Day_From__c != null && pto.Multi_Day_To__c != null){
                    
                    editPTO();
                    PageReference pr = new PageReference('/' + tor.Id);
                    return pr;
    
                }
                
        }
        
            if(days == 'Full Day' && pto.Full_Day_Date__c == null){
                
                nullDate = true;
                
            }
            if(days == 'Partial Day' && pto.Partial_Day_Date__c == null){
                
                nullDatePartial = true;
                
            }
            if(days == 'Multiple Days' && pto.Multi_Day_From__c == null || pto.Multi_Day_To__c == null){
                
                nullDateMulti = true;
                
            }
            if(partialTimeStart == 'Select Time...'){
            
                partialTimeError = true;
                
            }
            if(partialTimeEnd == 'Select Time...'){
                
                partialTimeError = true;
                
            }
            if(pto.Partial_Day_1__c == true && multiDayPartialDay1StartTime == 'Select Time...'){
                
                multi1TimeError = true;
            }
        
        return null;
    }
    
    public void editPTO(){
        
        /*tor = [SELECT Id, Name, Employee_s_Name__c, Full_Day_Date__c, Partial_Day_Date__c, Partial_Day_Lunch__c, StartTimePH__c, EndTimePH__c, Hours_to_be_Used__c, Multi_Day_From__c, Multi_Day_To__c, RecordTypeId,
                    Day_1_Date__c, Day_2_Date__c, Day_3_Date__c, Day_4_Date__c, Day_5_Date__c, Day_1_Start_Time__c, Day_1_End_Time__c, Day_2_Start_Time__c, Day_2_End_Time__c, Day_3_Start_Time__c, Day_3_End_Time__c,
                    Day_4_Start_Time__c, Day_4_End_Time__c, Day_5_Start_Time__c, Day_5_End_Time__c, Day_1_Lunch__c, Day_2_Lunch__c, Day_3_Lunch__c, Day_4_Lunch__c, Day_5_Lunch__c, Partial_Day_1__c, Partial_Day_2__c, Partial_Day_3__c,
                    Partial_Day_4__c, Partial_Day_5__c, StartTime1PH__c, EndTime1PH__c, StartTime2PH__c, EndTime2PH__c, StartTime3PH__c, EndTime3PH__c, StartTime4PH__c, EndTime4PH__c, StartTime5PH__c, EndTime5PH__c,
                    Day_1_Hours_To_Be_Used__c, Day_2_Hours_To_Be_Used__c, Day_3_Hours_To_Be_Used__c, Day_4_Hours_To_Be_Used__c, Day_5_Hours_To_Be_Used__c
                   FROM SFDC_Paid_Time_Off__c
                   WHERE Id =: recordId];*/
        
        if(days == 'Full Day'){

            Date fromDate = pto.Full_Day_Date__c;
            Date toDate = pto.Full_Day_Date__c;
            
            Datetime dt1 = datetime.newInstance(fromDate.year(), fromDate.month(), fromDate.day());
            Datetime dt2 = datetime.newInstance(toDate.year(), toDate.month(), toDate.day());
            
            //pto.From__c = pto.Full_Day_Date__c;
            //pto.To__c = pto.Full_Day_Date__c;
            tor.Full_Day_Date__c = pto.Full_Day_Date__c;
            tor.From__c = pto.Full_Day_Date__c;
            tor.To__c = pto.Full_Day_Date__c;
            //pto.From_Date__c = dt1;
            //pto.To_Date__c = dt2;
            tor.From_Date__c = dt1;
            tor.To_Date__c = dt2;
            tor.Hours_to_be_Used__c = 8;
            //tor.RecordTypeId = '012S00000008sJj';  //sandbox
            tor.RecordTypeId = '01270000000Q9s6';  //prod
            tor.Type__c = pto.Type__c;
            tor.Approval_Status__c = pto.Approval_Status__c;
            tor.Notes__c = pto.Notes__c;
            
        }
        
        if(days == 'Partial Day'){
            
            Date fromDate = pto.Partial_Day_Date__c;
            Date toDate = pto.Partial_Day_Date__c;
            
            Datetime dt1 = datetime.newInstance(fromDate.year(), fromDate.month(), fromDate.day());
            Datetime dt2 = datetime.newInstance(toDate.year(), toDate.month(), toDate.day());
            
            Decimal partialStart = decimal.valueOf(partialTimeStart);
            Decimal partialEnd = decimal.valueOf(partialTimeEnd);
            
            String partialStartString = string.valueOf(partialTimeStart);
            String pssHour = partialStartString.substringBefore('.');
            Decimal pssHourDecimal = decimal.valueOf(pssHour);
            String pssMinutes = partialStartString.substringAfter('.'); 
            String pssTime;
            //String pssHour1;
            String partOfDay = 'AM';
            String partOfDayEnd = 'AM';
            
            String partialEndString = string.valueOf(partialTimeEnd);
            String pesHour = partialEndString.substringBefore('.');
            Decimal pesHourDecimal = decimal.valueOf(pesHour);
            String pesMinutes = partialEndString.substringAfter('.');
            String pesTime;
            
            if(pssHourDecimal > 11.99){
                if(pssHourDecimal > 12){
                    pssHourDecimal = pssHourDecimal - 12;
                }
                pssHour = string.valueOf(pssHourDecimal);
                partOfDay = 'PM';
                
            }
            
            if(pesHourDecimal > 11.99){
                if(pesHourDecimal > 12){
                    pesHourDecimal = pesHourDecimal - 12;
                }
                pesHour = string.valueOf(pesHourDecimal);
                partOfDayEnd = 'PM';
                
            }
            
            if(pssMinutes == '00'){
                
                pssTime = '00';
                
            }
            else if(pssMinutes == '25'){
                
                pssTime = '15';
                
            }
            else if(pssMinutes == '50'){
                
                pssTime = '30';
                
            }
            else if(pssMinutes == '75'){
            
                pssTime = '45';
                
            }
            
            if(pesMinutes == '00'){
            
                pesTime = '00'; 
                
            }
            else if(pesMinutes == '25'){
                
                pesTime = '15';
                
            }
            else if(pesMinutes == '50'){
                
                pesTime = '30';
                
            }
            else if(pesMinutes == '75'){
                
                pesTime = '45';
                
            }
            Decimal timeBetween = partialEnd - partialStart;
            Decimal timeBetweenLunch = partialEnd - partialStart - 1;
            
            if(lunches == 'NO'){
                
                tor.Hours_To_be_Used__c = timeBetween;
            }
            else if(lunches == 'YES'){
                
                tor.Hours_To_be_Used__c = timeBetweenLunch;
            }
            
            
            tor.From__c = pto.Partial_Day_Date__c;
            tor.To__c = pto.Partial_Day_Date__c;
            tor.From_Date__c = dt1;
            tor.To_Date__c = dt2;
            //tor.RecordTypeId = '012S00000008sJo';  //sandbox
            tor.RecordTypeId = '01270000000Q9sB';  //prod
            tor.Partial_Day_Start_Time__c = pssHour + ':' + pssTime + ' ' + partOfDay; 
            tor.Partial_Day_End_Time__c = pesHour + ':' + pesTime + ' ' + partOfDayEnd;
            tor.Partial_Day_Lunch__c = lunches;
            tor.StartTimePH__c = partialTimeStart;
            tor.EndTimePH__c = partialTimeEnd;
            tor.Partial_Day_Date__c = pto.Partial_Day_Date__c;
            tor.Type__c = pto.Type__c;
            tor.Approval_Status__c = pto.Approval_Status__c;
            tor.Notes__c = pto.Notes__c;
            system.debug('Bazinga' + PartOfDayend + pesHourDecimal + pesHour);
            
            
        }
        if(days == 'Multiple Days'){
            
            Date fromDate = pto.Multi_Day_From__c;
            Date toDate = pto.Multi_Day_To__c;
            
            day1Hours = 0;
            day2Hours = 0;
            day3Hours = 0;
            day4Hours = 0;
            day5Hours = 0;
            
            Datetime dt1 = datetime.newInstance(fromDate.year(), fromDate.month(), fromDate.day(), 01, 0, 0);
            Datetime dt2 = datetime.newInstance(toDate.year(), toDate.month(), toDate.day(), 01, 0, 0);
                    
            date startDate = pto.Multi_Day_From__c;
            date endDate = pto.Multi_Day_To__c;
            startOfWeekDate = startDate.toStartofWeek();
            daysBetween = startDate.daysBetween(endDate);
            totaldays = startDate.daysBetween(endDate) + 1;
            //tor.RecordTypeId = '012S00000008sJt';  //sandbox
            tor.RecordTypeId = '01270000000Q9sG';  //prod
            tor.Type__c = pto.Type__c;
            tor.Approval_Status__c = pto.Approval_Status__c;
            tor.Notes__c = pto.Notes__c;
            
            if(pto.Multi_Day_From__c != null && pto.Multi_Day_To__c != null){
                
                if(daysBetween == 1){
                    
                    if(pto.Partial_Day_1__c == false){
                        
                        day1hours = 8;
                        tor.Day_1_Times__c = 8;
                        tor.Partial_Day_1__c = false;
                        multiDayPartialDay1StartTime = null;
                        multiDayPartialDay1EndTime = null;
                    }
                    else if(pto.Partial_Day_1__c == true){
                        
                        if(lunch1 == 'NO'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start;
                            tor.Day_1_Times__c = day1End - day1Start;
                            tor.Day_1_Lunch__c = 'NO';
                            
                        }
                        else if(lunch1 == 'YES'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start - 1;
                            tor.Day_1_Times__c = day1End - day1Start - 1;
                            tor.Day_1_Lunch__c = 'YES';
                            
                        }
                        tor.Day_1_Start_Time__c = day1StartTime;
                        tor.Day_1_End_Time__c = day1EndTime;
                        tor.StartTime1PH__c = multiDayPartialDay1StartTime;
                        tor.EndTime1PH__c = multiDayPartialDay1EndTime;
                        
                    }
                    if(pto.Partial_Day_2__c == false){
                        
                            day2hours = 8;
                            tor.Day_2_Times__c = 8;
                    }
                     else if(pto.Partial_Day_2__c == true){
                        
                        if(lunch2 == 'NO'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start;
                            tor.Day_2_Times__c = day2End - day2Start;
                            tor.Day_2_Lunch__c = 'NO';
                            
                        }
                        else if(lunch2 == 'YES'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start - 1;
                            tor.Day_2_Times__c = day2End - day2Start - 1;
                            tor.Day_2_Lunch__c = 'YES'; 
                        }
                        
                        tor.Day_2_Start_Time__c = day2StartTime;
                        tor.Day_2_End_Time__c = day2EndTime;
                        tor.StartTime2PH__c = multiDayPartialDay2StartTime;
                        tor.EndTime2PH__c = multiDayPartialDay2EndTime;
                        //tor.Hours_to_be_Used__c = day1Hours + day2Hours;
                    }
                }
                if(daysBetween == 2){
                    
                    if(pto.Partial_Day_1__c == false){
                        
                        day1hours = 8;
                        tor.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_1__c == true){
                        
                        if(lunch1 == 'NO'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start;
                            tor.Day_1_Times__c = day1End - day1Start;
                            tor.Day_1_Lunch__c = 'NO';
                            
                            
                        }
                        else if(lunch1 == 'YES'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start - 1;
                            tor.Day_1_Times__c = day1End - day1Start - 1;
                            tor.Day_1_Lunch__c = 'YES';
                            
                        }
                        
                        tor.Day_1_Start_Time__c = day1StartTime;
                        tor.Day_1_End_Time__c = day1EndTime;
                        tor.StartTime1PH__c = multiDayPartialDay1StartTime;
                        tor.EndTime1PH__c = multiDayPartialDay1EndTime;
                        
                    }
                    if(pto.Partial_Day_2__c == false){
                        
                            day2hours = 8;
                            tor.Day_2_Times__c = 8;
                    }
                    else if(pto.Partial_Day_2__c == true){
                        
                        if(lunch2 == 'NO'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start;
                            tor.Day_2_Times__c = day2End - day2Start;
                            tor.Day_2_Lunch__c = 'NO';
                            
                        }
                        else if(lunch2 == 'YES'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start - 1;
                            tor.Day_2_Times__c = day2End - day2Start - 1;
                            tor.Day_2_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_2_Start_Time__c = day2StartTime;
                        tor.Day_2_End_Time__c = day2EndTime;
                        tor.StartTime2PH__c = multiDayPartialDay2StartTime;
                        tor.EndTime2PH__c = multiDayPartialDay2EndTime;
                        
                    }
                    if(pto.Partial_Day_3__c == false){
                        
                            day3hours = 8;
                            tor.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_3__c == true){
                        
                        if(lunch3 == 'NO'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start;
                            tor.Day_3_Times__c = day3End - day3Start;
                            tor.Day_3_Lunch__c = 'NO';
                            
                        }
                        else if(lunch3 == 'YES'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start - 1;
                            tor.Day_3_Times__c = day3End - day3Start - 1;
                            tor.Day_3_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_3_Start_Time__c = day3StartTime;
                        tor.Day_3_End_Time__c = day3EndTime;
                        tor.StartTime3PH__c = multiDayPartialDay3StartTime;
                        tor.EndTime3PH__c = multiDayPartialDay3EndTime;
                    }
                    
                }
                
                if(daysBetween == 3){
                    
                    if(pto.Partial_Day_1__c == false){
                        
                        day1hours = 8;
                        tor.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_1__c == true){
                        
                        if(lunch1 == 'NO'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start;
                            tor.Day_1_Times__c = day1End - day1Start;
                            tor.Day_1_Lunch__c = 'NO';
                            
                        }
                        else if(lunch1 == 'YES'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start - 1;
                            tor.Day_1_Times__c = day1End - day1Start - 1;
                            tor.Day_1_Lunch__c = 'YES';
                            
                        }
                        
                        tor.Day_1_Start_Time__c = day1StartTime;
                        tor.Day_1_End_Time__c = day1EndTime;
                        tor.StartTime1PH__c = multiDayPartialDay1StartTime;
                        tor.EndTime1PH__c = multiDayPartialDay1EndTime;
                        
                    }
                    if(pto.Partial_Day_2__c == false){
                        
                            day2hours = 8;
                            tor.Day_2_Times__c = 8;
                    }
                    else if(pto.Partial_Day_2__c == true){
                        
                        if(lunch2 == 'NO'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start;
                            tor.Day_2_Times__c = day2End - day2Start;
                            tor.Day_2_Lunch__c = 'NO';
                            
                        }
                        else if(lunch2 == 'YES'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start - 1;
                            tor.Day_2_Times__c = day2End - day2Start - 1;
                            tor.Day_2_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_2_Start_Time__c = day2StartTime;
                        tor.Day_2_End_Time__c = day2EndTime;
                        tor.StartTime2PH__c = multiDayPartialDay2StartTime;
                        tor.EndTime2PH__c = multiDayPartialDay2EndTime;
                        
                    }
                    if(pto.Partial_Day_3__c == false){
                        
                            day3hours = 8;
                            tor.Day_3_Times__c = 8;
                    }
                    else if(pto.Partial_Day_3__c == true){
                        
                        if(lunch3 == 'NO'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start;
                            tor.Day_3_Times__c = day3End - day3Start;
                            tor.Day_3_Lunch__c = 'NO';
                            
                        }
                        else if(lunch3 == 'YES'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start - 1;
                            tor.Day_3_Times__c = day3End - day3Start - 1;
                            tor.Day_3_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_3_Start_Time__c = day3StartTime;
                        tor.Day_3_End_Time__c = day3EndTime;
                        tor.StartTime3PH__c = multiDayPartialDay3StartTime;
                        tor.EndTime3PH__c = multiDayPartialDay3EndTime;
                        
                    }
                    if(pto.Partial_Day_4__c == false){
                        
                            day4hours = 8;
                            tor.Day_4_Times__c = 8;
                    }
                    else if(pto.Partial_Day_4__c == true){
                        
                        if(lunch4 == 'NO'){
                            
                            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
                            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
                            day4hours = day4End - day4Start;
                            tor.Day_4_Times__c = day4End - day4Start;
                            tor.Day_4_Lunch__c = 'NO';
                            
                        }
                        else if(lunch4 == 'YES'){
                            
                            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
                            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
                            day4hours = day4End - day4Start - 1;
                            tor.Day_4_Times__c = day4End - day4Start - 1;
                            tor.Day_4_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_4_Start_Time__c = day4StartTime;
                        tor.Day_4_End_Time__c = day4EndTime;
                        tor.StartTime4PH__c = multiDayPartialDay4StartTime;
                        tor.EndTime4PH__c = multiDayPartialDay4EndTime;
                    }
                    
                }
                
                if(daysBetween == 4){
                    
                    if(pto.Partial_Day_1__c == false){
                        
                        day1hours = 8;
                        tor.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_1__c == true){
                        
                        if(lunch1 == 'NO'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start;
                            tor.Day_1_Times__c = day1End - day1Start;
                            tor.Day_1_Lunch__c = 'NO';
                            
                        }
                        else if(lunch1 == 'YES'){
                            
                            decimal day1Start = decimal.valueOf(multiDayPartialDay1StartTime);
                            decimal day1End = decimal.valueOf(multiDayPartialDay1EndTime);
                            day1hours = day1End - day1Start - 1;
                            tor.Day_1_Times__c = day1End - day1Start -1;
                            tor.Day_1_Lunch__c = 'YES';
                            
                        }
                        
                        tor.Day_1_Start_Time__c = day1StartTime;
                        tor.Day_1_End_Time__c = day1EndTime;
                        tor.StartTime1PH__c = multiDayPartialDay1StartTime;
                        tor.EndTime1PH__c = multiDayPartialDay1EndTime;
                        
                    }
                    if(pto.Partial_Day_2__c == false){
                        
                            day2hours = 8;
                            tor.Day_2_Times__c = 8;
                    }
                    else if(pto.Partial_Day_2__c == true){
                        
                        if(lunch2 == 'NO'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start;
                            tor.Day_2_Times__c = day2End - day2Start;
                            tor.Day_2_Lunch__c = 'NO';
                            
                        }
                        else if(lunch2 == 'YES'){
                            
                            decimal day2Start = decimal.valueOf(multiDayPartialDay2StartTime);
                            decimal day2End = decimal.valueOf(multiDayPartialDay2EndTime);
                            day2hours = day2End - day2Start - 1;
                            tor.Day_2_Times__c = day2End - day2Start - 1;
                            tor.Day_2_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_2_Start_Time__c = day2StartTime;
                        tor.Day_2_End_Time__c = day2EndTime;
                        tor.StartTime2PH__c = multiDayPartialDay2StartTime;
                        tor.EndTime2PH__c = multiDayPartialDay2EndTime;
                        
                    }
                    if(pto.Partial_Day_3__c == false){
                        
                            day3hours = 8;
                            tor.Day_1_Times__c = 8;
                    }
                    else if(pto.Partial_Day_3__c == true){
                        
                        if(lunch3 == 'NO'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start;
                            tor.Day_3_Times__c = day3End - day3Start;
                            tor.Day_3_Lunch__c = 'NO';
                            
                        }
                        else if(lunch3 == 'YES'){
                            
                            decimal day3Start = decimal.valueOf(multiDayPartialDay3StartTime);
                            decimal day3End = decimal.valueOf(multiDayPartialDay3EndTime);
                            day3hours = day3End - day3Start - 1;
                            tor.Day_3_Times__c = day3End - day3Start - 1;
                            tor.Day_3_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_3_Start_Time__c = day3StartTime;
                        tor.Day_3_End_Time__c = day3EndTime;
                        tor.StartTime3PH__c = multiDayPartialDay3StartTime;
                        tor.EndTime3PH__c = multiDayPartialDay3EndTime;
                        
                    }
                    if(pto.Partial_Day_4__c == false){
                        
                            day4hours = 8;
                            tor.Day_4_Times__c = 8;
                    }
                    else if(pto.Partial_Day_4__c == true){
                        
                        if(lunch4 == 'NO'){
                            
                            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
                            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
                            day4hours = day4End - day4Start;
                            tor.Day_4_Times__c = day4End - day4Start;
                            tor.Day_4_Lunch__c = 'NO';
                            
                        }
                        else if(lunch4 == 'YES'){
                            
                            decimal day4Start = decimal.valueOf(multiDayPartialDay4StartTime);
                            decimal day4End = decimal.valueOf(multiDayPartialDay4EndTime);
                            day4hours = day4End - day4Start - 1;
                            tor.Day_4_Times__c = day4End - day4Start - 1;
                            tor.Day_4_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_4_Start_Time__c = day4StartTime;
                        tor.Day_4_End_Time__c = day4EndTime;
                        tor.StartTime4PH__c = multiDayPartialDay4StartTime;
                        tor.EndTime4PH__c = multiDayPartialDay4EndTime;
                    }
                    if(pto.Partial_Day_5__c == false){
                        
                            day5hours = 8;
                            tor.Day_5_Times__c = 8;
                    }
                    else if(pto.Partial_Day_5__c == true){
                        
                        if(lunch5 == 'NO'){
                            
                            decimal day5Start = decimal.valueOf(multiDayPartialDay5StartTime);
                            decimal day5End = decimal.valueOf(multiDayPartialDay5EndTime);
                            day5hours = day5End - day5Start;
                            tor.Day_5_Times__c = day5End - day5Start;
                            tor.Day_5_Lunch__c = 'NO';
                            
                        }
                        else if(lunch5 == 'YES'){
                            
                            decimal day5Start = decimal.valueOf(multiDayPartialDay5StartTime);
                            decimal day5End = decimal.valueOf(multiDayPartialDay5EndTime);
                            day5hours = day5End - day5Start - 1;
                            tor.Day_5_Times__c = day5End - day5Start - 1;
                            tor.Day_5_Lunch__c = 'YES';
                                
                        }
                        
                        tor.Day_5_Start_Time__c = day5StartTime;
                        tor.Day_5_End_Time__c = day5EndTime;
                        tor.StartTime5PH__c = multiDayPartialDay5StartTime;
                        tor.EndTime5PH__c = multiDayPartialDay5EndTime;
                        
                    }
                    
                }
                tor.Hours_to_be_Used__c = day1Hours + day2Hours + day3Hours + day4Hours + day5Hours;
                tor.Multi_Day_From__c = pto.Multi_Day_From__c;
                tor.Multi_Day_To__c = pto.Multi_day_To__c;
                tor.Type__c = pto.Type__c;
                //tor.Day_1_Date__c = pto.Multi_Day_From__c;
            }//end of multiple days if
            
            //tor.Hours_to_be_Used__c = day1Hours + day2Hours;
        }
        
            update tor;
        
    }
    
    public PageReference cancelReturn(){
        
        PageReference pr = new PageReference('/' + balId);
         
         return pr;
        
    }
    
    public PageReference cancelUpdate(){
        
        PageReference pr = new PageReference('/' + recordId);
        
        return pr;
        
    }
}