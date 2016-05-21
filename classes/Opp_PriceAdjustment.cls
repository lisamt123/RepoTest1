public with sharing class Opp_PriceAdjustment {

	private final Opportunity opp;
	public Opportunity oppInfo{get; set;}
	//info being passed in the page load query string//
	public String oppName {get; set;}
	public String oppId {get; set;}
	public String mrr {get; set;}
	public String pbUsed {get; set;}
	////////////////////////////////////////////////////
	public String typeOfAdjustment {get; set;}
	public String typeOfRate {get; set;}
	public decimal percentAmount {get; set;}
	//variable for percentage and flat discounts////////
	public decimal mrrPercent {get; set;}
	public decimal mrrPercentPH {get; set;}
	public decimal mrrFlat {get; set;}
	public decimal mrrFlatPH {get; set;}
	public decimal oneTimePercent {get; set;}
	public decimal oneTimePercentPh {get; set;}
	public decimal oneTimeFlat {get; set;}
	public decimal oneTimeFlatPH {get; set;}
	public decimal setUpPercent {get; set;}
	public decimal setUpPercentPH {get; set;}
	public decimal setUpFlat {get; set;}
	public decimal setUpFlatPH {get; set;}
	public decimal trainPercent {get; set;}
	public decimal trainPercentPH {get; set;}
	public decimal trainFlat {get; set;}
	public decimal trainFlatPH {get; set;}
	//variables to show the calculations w/o changes////
	public decimal newMRR {get; set;}
	public decimal newOT {get; set;}
	public decimal newSU {get; set;}
	public decimal newTR {get; set;}
	//variables to show the percentage of the flat rate/
	public decimal mrrFlatPercentage {get; set;}
	public decimal otFlatPercentage {get; set;}
	public decimal suFlatPercentage {get; set;}
	public decimal trFlatPercentage {get; set;}
	///////////////////////////////////////////////////
	//the 4 Lists that hold all the seperate products//
	public List<OpportunityLineItem> relatedOLIsMonthly {get; set;}
	public List<OpportunityLineItem> relatedOLIsOneTime {get; set;}
	public List<OpportunityLineItem> relatedOLIsSetUp {get; set;}
	public List<OpportunityLineItem> relatedOLIsTraining {get; set;}
	public List<OpportunityLineItem> relatedOLIsMonthlyDPC {get; set;}
	public List<OpportunityLineItem> relatedOLIsOneTimeDPC {get; set;}
	public List<OpportunityLineItem> relatedOLIsSetUpDPC {get; set;}
	public List<OpportunityLineItem> relatedOLIsTrainingDPC {get; set;}
	//////////////////////////////////////////////////
	//Booleans for page errors////////////////////////
	public boolean perOverMax {get; set;}
	public boolean flatOverMax {get; set;}
	public boolean perNeg {get; set;}
	public boolean flatNeg {get; set;}
	//////////////////////////////////////////////////
	//variables for total Percentages/////////////////
	public decimal mrrPerDecTotal {get; set;}
	public decimal otPerDecTotal {get; set;}
	public decimal suPerDecTotal {get; set;}
	public decimal trPerDecTotal {get; set;}
	public decimal mrrPerDecPH {get; set;}
	public decimal otPerDecPH {get; set;}
	public decimal suPerDecPH {get; set;}
	public decimal trPerDecPH {get; set;}
	public decimal mrrFlatDecTotal {get; set;}
	public decimal otFlatDecTotal {get; set;}
	public decimal suFlatDecTotal {get; set;}
	public decimal trFlatDecTotal {get; set;}
	public decimal mrrFlatDecPH {get; set;}
	public decimal otFlatDecPH {get; set;}
	public decimal suFlatDecPH {get; set;}
	public decimal trFlatDecPH {get; set;}
	public decimal mrrPerIncTotal {get; set;}
	public decimal otPerIncTotal {get; set;}
	public decimal suPerIncTotal {get; set;}
	public decimal trPerIncTotal {get; set;}
	public decimal mrrPerIncPH {get; set;}
	public decimal otPerIncPH {get; set;}
	public decimal suPerIncPH {get; set;}
	public decimal trPerIncPH {get; set;}
	public decimal mrrFlatIncTotal {get; set;}
	public decimal otFlatIncTotal {get; set;}
	public decimal suFlatIncTotal {get; set;}
	public decimal trFlatIncTotal {get; set;}
	public decimal mrrFlatIncPH {get; set;}
	public decimal otFlatIncPH {get; set;}
	public decimal suFlatIncPH {get; set;}
	public decimal trFlatIncPH {get; set;}
	////////////////////////////////////////////////
	public decimal mrrPH {get; set;}
	public decimal mrrPhAfter {get; set;}
	public decimal otPH {get; set;}
	public decimal otPhAfter {get; set;}
	public decimal suPH {get; set;}
	public decimal suPhAfter {get; set;}
	public decimal trPH {get; set;}
	public decimal trPhAfter {get; set;}
	public decimal mrrPH1 {get; set;}
	public decimal otPH1 {get; set;}
	public decimal suPH1 {get; set;}
	public decimal trPH1 {get; set;}
	public decimal mrrPH2 {get; set;}
	public decimal otPH2 {get; set;}
	public decimal suPH2 {get; set;}
	public decimal trPH2 {get; set;}
	public boolean submitTrue {get; set;}
	public decimal mrrDPCPH {get; set;}
	public decimal otDPCPH {get; set;}
	public decimal suDPCPH {get; set;}
	public decimal trDPCPH {get; set;}
	public integer mrrListSize {get; set;}
	///////TEMPORARY///////////////////////////////
	public decimal bazinga1 {get; set;}
	public decimal bazinga2 {get; set;}
	public decimal bazinga3 {get; set;}
	public decimal bazinga4 {get; set;}
	public decimal bazinga5 {get; set;}
	public decimal bazinga6 {get; set;}
	public decimal bazinga7 {get; set;}
	public decimal bazinga8 {get; set;}
	public decimal bazinga9 {get; set;}
	public decimal bazinga10 {get; set;}
	///////////////////////////////////////////////
	public decimal mrrPlus {get; set;}
	public decimal otPlus {get; set;}
	public decimal suPlus {get; set;}
	public decimal trPlus {get; set;}
	public Boolean mrrZero {get; set;}
	public Boolean otZero {get; set;}
	public Boolean suZero {get; set;}
	public Boolean trZero {get; set;}
	public Boolean mrrZeroError {get; set;}
	public Boolean otZeroError {get; set;}
	public Boolean suZeroError {get; set;}
	public Boolean trZeroError {get; set;}
	public Boolean reset {get; set;}
	
	
	public Opp_PriceAdjustment(ApexPages.StandardController stdCon){
		
		this.opp = (Opportunity)stdCon.getRecord();
		
		oppName = ApexPages.currentPage().getParameters().get('oppName');
		oppId = ApexPages.currentPage().getParameters().get('oppId');
		mrr = ApexPages.currentPage().getParameters().get('mrr');
		pbUsed = ApexPages.currentPage().getParameters().get('pbUsed');
		
		oppInfoUpdate();
		
	}
	
	public void oppInfoUpdate(){
		
		oppInfo = [SELECT Name, Monthly_Recurring_Fees__c, Total_One_time__c, Setup_Fees__c, Total_Training__c, One_Time_Fees__c, One_Time_Fees2__c, Price_Book_Used__c
				   FROM Opportunity
				   WHERE Id =: oppId];
				   
		relatedOLIsMonthly = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
												 FROM OpportunityLineItem
												 WHERE OpportunityId = :oppId AND One_Time_Fee__c = false AND Setup_Fee__c = false AND PricebookEntry.Product2.Disable_Price_Change__c = false];
		
		//mrrListSize = relatedOLIsMonthly.size();
											 
		relatedOLIsMonthlyDPC = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
												 FROM OpportunityLineItem
												 WHERE OpportunityId = :oppId AND One_Time_Fee__c = false AND Setup_Fee__c = false AND PricebookEntry.Product2.Disable_Price_Change__c = true];	
												 
		relatedOLIsOneTime = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
							  FROM OpportunityLineItem
							  WHERE OpportunityId = :oppId AND One_Time_Fee__c = true AND IsTraining__c = 'False' AND PricebookEntry.Product2.Disable_Price_Change__c = false];
							  
		relatedOLIsOneTimeDPC = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
							  FROM OpportunityLineItem
							  WHERE OpportunityId = :oppId AND One_Time_Fee__c = true AND IsTraining__c = 'False' AND PricebookEntry.Product2.Disable_Price_Change__c = true];
							  
		relatedOLIsSetUp =   [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
							  FROM OpportunityLineItem
							  WHERE OpportunityId = :oppId AND Setup_Fee__c = true AND PricebookEntry.Product2.Disable_Price_Change__c = false]; 
							  
		relatedOLIsSetUpDPC = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
							  FROM OpportunityLineItem
							  WHERE OpportunityId = :oppId AND Setup_Fee__c = true AND PricebookEntry.Product2.Disable_Price_Change__c = true];
							  
		relatedOLIsTraining = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
							  FROM OpportunityLineItem
							  WHERE OpportunityId = :oppId AND One_Time_Fee__c = true AND IsTraining__c = 'True' AND PricebookEntry.Product2.Disable_Price_Change__c = false];
							  
		relatedOLIsTrainingDPC = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
							  FROM OpportunityLineItem
							  WHERE OpportunityId = :oppId AND One_Time_Fee__c = true AND IsTraining__c = 'True' AND PricebookEntry.Product2.Disable_Price_Change__c = true];
							  
		submitTrue = true;
		
		noZeroes();
		totalListPriceNoDiscount();
		totalsDisablePriceChange();
		
		if(oppInfo.Monthly_Recurring_Fees__c <= 0){
			mrrZero = true;
		}
		if(oppInfo.One_Time_Fees2__c <=0){
			otZero = true;
		}
		if(oppInfo.Setup_Fees__c <=0){
			suZero = true;
		}
		if(oppInfo.Total_Training__c <=0){
			trZero = true;
		}
		/*else if(oppInfo.Total_Training__c > 0){
			trZero = false;
		}*/
		
		
	}
	
	public void noZeroes(){
		
		mrrPlus = oppInfo.Monthly_Recurring_Fees__c + .001;
	}
	/************FOR THE REAL TOTAL DISCOUNT CALCULATIONS***************************************************************************************/
	public void totalListPriceNoDiscount(){
		decimal ph1 = 0;
		decimal ph11 = 0;
		decimal ph111 = 0;	
		for(OpportunityLineItem olimrr : relatedOLIsMonthly){
			
			
			ph1 += olimrr.List_Price_Formula__c;
			ph111 += olimrr.UnitPrice;
		}
		for(OpportunityLineItem olimrr1 : relatedOLIsMonthlyDPC){
			ph11 += olimrr1.List_Price_Formula__c;
		}
		
		mrrph = ph1;
		mrrph1 = ph11;
		mrrph2 = mrrph + mrrph1;
		mrrPhAfter = ph111;
		
		decimal ph2 = 0;
		decimal ph22 = 0;
		decimal ph222 = 0;
		for(OpportunityLineItem oliot : relatedOLIsOneTime){
			ph2 += oliot.List_Price_Formula__c;
			ph222 += oliot.UnitPrice;
		}
		for(OpportunityLineItem oliot1 : relatedOLIsOneTimeDPC){
			ph22 += oliot1.List_Price_Formula__c;
		}
		otph = ph2;
		otph1 = ph22;
		otph2 = otph + otph1;
		otPhAfter = ph222;
		
		decimal ph3 = 0;
		decimal ph33 = 0;
		decimal ph333 = 0;
		for(OpportunityLineItem olisu : relatedOLIsSetUp){
			ph3 += olisu.List_Price_Formula__c;
			ph333 += olisu.UnitPrice;
		}
		for(OpportunityLineItem olisu1 : relatedOLIsSetUpDPC){
			ph33 += olisu1.List_Price_Formula__c;
		}
		suph = ph3;
		suph1 = ph33;
		suph2 = suph + suph1;
		suPhAfter = ph333;
		
		decimal ph4 = 0;
		decimal ph44 = 0;
		decimal ph444 = 0;
		for(OpportunityLineItem olitr : relatedOLIsTraining){
			ph4 += olitr.List_Price_Formula__c;
			ph444 += olitr.UnitPrice;
		} 
		for(OpportunityLineItem olitr1 : relatedOLIsTrainingDPC){
			ph44 += olitr1.List_Price_Formula__c;
		}
		trph = ph4;
		trph1 = ph44;
		trph2 = trph + trph1;
		trPhAfter = ph444;
		
		//totalPercentageDiscount();

	}
	public void totalsDisablePriceChange(){
		decimal phMRRDPC = 0;
		for(OpportunityLineItem oliMRRDPC : relatedOLIsMonthlyDPC){
			phMRRDPC += oliMRRDPC.List_Price_Formula__c;
		}
		mrrDPCPH = phMRRDPC;
		
		decimal phOTDPC = 0;
		for(OpportunityLineItem oliOTDPC : relatedOLIsOneTimeDPC){
			phOTDPC += oliOTDPC.List_Price_Formula__c;
		}
		otDPCPH = phOTDPC;
		
		decimal phSUDPC = 0;
		for(OpportunityLineItem oliSUDPC : relatedOLIsSetUpDPC){
			phSUDPC += oliSUDPC.List_Price_Formula__c;
		}
		suDPCPH = phSUDPC;
		
		decimal phTRDPC = 0;
		for(OpportunityLineItem oliTRDPC : relatedOLIsTrainingDPC){
			phTRDPC += oliTRDPC.List_Price_Formula__c;
		}
		trDPCPH = phTRDPC;
	}
	
	public void totalPercentageDiscount(){
		
		if(oppInfo.Monthly_Recurring_Fees__c == mrrph2){
			mrrPerDecTotal = 0;
		}
		if(oppInfo.Monthly_Recurring_Fees__c != mrrph2){
			
			decimal num1 = mrrph2 - oppInfo.Monthly_Recurring_Fees__c;
			decimal num2 = num1 / mrrph2;
			mrrPerDecTotal = num2 * 100;
		}
		
		if(oppInfo.One_Time_Fees2__c == otph2){
			otPerDecTotal = 0.00;
		}
		if(oppInfo.One_Time_Fees2__c != otph2){
			//decimal num11 = otph - oppInfo.One_Time_Fees2__c;
			//decimal num21 = num11 / otph;
			//otPerDecTotal = num21 * 100;
			bazinga1 = otph2 - oppInfo.One_Time_Fees2__c;
			bazinga2 = bazinga1/otph2;
			otPerDecTotal = bazinga2 * 100;
		}
		
		if(oppInfo.Setup_Fees__c == suph2){
			suPerDecTotal = 0.00;
		}
		if(oppInfo.Setup_Fees__c != suph2){
			decimal num12 = suph2 - oppInfo.Setup_Fees__c;
			decimal num22 = num12 / suph2;
			suPerDecTotal = num22 * 100;

		}
		
		if(oppInfo.Total_Training__c == trph2){
			trPerDecTotal = 0.00;
		}
		if(oppInfo.Total_Training__c != trph2){
			decimal num13 = trph2 - oppInfo.Total_Training__c;
			decimal num23 = num13 / trph2;
			trPerDecTotal = num23 * 100;
		}
	}
	
	public void realTimeTotalDiscountPercentage(){
		if(mrrPerDecPH != null){
			if(oppInfo.Monthly_Recurring_Fees__c != mrrph2){
				
				decimal num1 = mrrph2 - mrrPerDecPH;
				decimal num2 = num1 / mrrph2;
				mrrPerDecTotal = num2 * 100;
			}
		}
		if(otPerDecPH != null){
			if(oppInfo.One_Time_Fees2__c != otph2){
				decimal num11 = otph2 - otPerDecPH;
				decimal num21 = num11 / otph2;
				otPerDecTotal = num21 * 100;
			}
		}
		if(suPerDecPH != null){
			if(oppInfo.Setup_Fees__c != suph2){
				decimal num12 = suph2 - suPerDecPH;
				decimal num22 = num12 / suph2;
				suPerDecTotal = num22 * 100;
			}
		}
		if(trPerDecPH != null){
			if(oppInfo.Total_Training__c != trph2){
				decimal num13 = trph2 - trPerDecPH;
				decimal num23 = num13 / trph2;
				trPerDecTotal = num23 * 100;
			}
		}
		
	}
	public void totalFlatDiscount(){
		
		if(oppInfo.Monthly_Recurring_Fees__c == mrrph2){
			mrrFlatDecTotal = 0;
		}
		if(oppInfo.Monthly_Recurring_Fees__c != mrrph2){
			decimal num1 = mrrph2 - oppInfo.Monthly_Recurring_Fees__c;
			decimal num2 = num1 / mrrph2;
			mrrFlatDecTotal = num2 * 100;
		}
		if(oppInfo.One_Time_Fees2__c == otph2){
			otFlatDecTotal = 0.00;
		}
		if(oppInfo.One_Time_Fees2__c != otph2 && otph2 != 0){
			decimal num11 = otph2 - oppInfo.One_Time_Fees2__c;
			decimal num21 = num11 / otph2;
			otFlatDecTotal = num21 * 100;
		}
		
		if(oppInfo.Setup_Fees__c == suph2){
			suPerDecTotal = 0.00;
		}
		if(oppInfo.Setup_Fees__c != suph2){
			decimal num12 = suph2 - oppInfo.Setup_Fees__c;
			decimal num22 = num12 / suph2;
			suFlatDecTotal = num22 * 100;

		}
		
		if(oppInfo.Total_Training__c == trph2){
			trPerDecTotal = 0.00;
		}
		if(oppInfo.Total_Training__c != trph2){
			decimal num13 = trph2 - oppInfo.Total_Training__c;
			decimal num23 = num13 / trph2;
			trFlatDecTotal = num23 * 100;
		}
	}
	public void realTimeTotalFlatDiscount(){
		
		if(oppInfo.Monthly_Recurring_Fees__c != mrrph2){
			decimal num1 = oppInfo.Monthly_Recurring_Fees__c - mrrFlat;
			decimal num2 = num1 / mrrph2;
			mrrFlatDecTotal = 100 - num2 * 100;
		}
		if(oppInfo.One_Time_Fees2__c != otph2 && otph2 !=0){
			decimal num11 = oppInfo.One_Time_Fees2__c - oneTimeFLat;
			decimal num21 = num11 / otph2;
			otFlatDecTotal = 100 - num21 * 100;
		}
		if(oppInfo.Setup_Fees__c != suph2){
			decimal num12 = oppInfo.Setup_Fees__c - setUpFlat;
			decimal num22 = num12 / suph2;
			suFLatDecTotal = 100 - num22 * 100;
		}
		if(oppInfo.Total_Training__c != trph2){
			decimal num13 = oppInfo.Total_Training__c - trainFlat;
			decimal num23 = num13 / trph2;
			trFlatDecTotal = 100 - num23 * 100;
		}
		
	}
	
	public void totalPercentageIncrease(){
		if(oppInfo.Monthly_Recurring_Fees__c == mrrph2){
			mrrPerIncTotal = 0;
		}
		if(oppInfo.Monthly_Recurring_Fees__c != mrrph2){
			decimal num1 = oppInfo.Monthly_Recurring_Fees__c / mrrph2;
			mrrPerIncTotal = num1 * 100 - 100;
		}
		
		if(oppInfo.One_Time_Fees2__c == otph2){
			otPerIncTotal = 0;
		}
		if(oppInfo.One_Time_Fees2__c != otph2){
			decimal num2 = oppInfo.One_Time_Fees2__c / otph2;
			otPerIncTotal = num2 * 100 - 100;
		}
		
		if(oppInfo.Setup_Fees__c == suph2){
			suPerIncTotal = 0;
		}
		if(oppInfo.Setup_Fees__c != suph2){
			decimal num3 = oppInfo.Setup_Fees__c / suph2;
			suPerIncTotal = num3 * 100 - 100;
		}
		
		if(oppInfo.Total_Training__c == trph2){
			trPerIncTotal = 0;
		}
		if(oppInfo.Total_Training__c != trph2){
			decimal num4 = oppInfo.Total_Training__c / trph2;
			trPerIncTotal = num4 * 100 - 100;
		}
		
	}
	public void realTimeTotalPercentageIncrease(){
		if(oppInfo.Monthly_Recurring_Fees__c != mrrph2){
			decimal num1 = mrrPerIncPH / mrrph2;
			mrrPerIncTotal = num1 * 100 - 100;
		}
		if(oppInfo.One_Time_Fees2__c != otph2){
			decimal num2 = otPerIncPH / otph2;
			otPerIncTotal = num2 * 100 - 100;
		}
		if(oppInfo.Setup_Fees__c != suph2){
			decimal num3 = suPerIncPH / suph2;
			suPerIncTotal = num3 * 100 - 100;
		}
		if(oppInfo.Total_Training__c != trph2){
			decimal num4 = trPerIncPH / trph2;
			trPerIncTotal = num4 * 100 - 100;
		}
		
	}
	
	public void totalFlatIncrease(){
		decimal num2;
		if(oppInfo.Monthly_Recurring_Fees__c == mrrph2){
			mrrFlatIncTotal = 0;
		}
		if(oppInfo.Monthly_Recurring_Fees__c != mrrph2){
			decimal num1 = oppInfo.Monthly_Recurring_Fees__c - mrrph2;
			if(mrrph2 == 0){
				num2 = num1 / .001;
			}
			else if(mrrph2 != 0){
				num2 = num1 / mrrph2;
			}
			mrrFlatIncTotal = num2 * 100;
		}
		
		if(oppInfo.One_Time_Fees2__c == otph2){
			otFlatIncTotal = 0;
		}
		if(oppInfo.One_Time_Fees2__c != otph2){
			decimal num12 = oppInfo.One_Time_Fees2__c - otph2;
			decimal num22 = num12 / otph2;
			otFlatIncTotal = num22 * 100;
		}
		
		if(oppInfo.Setup_Fees__c == suph2){
			suFlatIncTotal = 0;
		}
		if(oppInfo.Setup_Fees__c != suph2){
				decimal num13 = oppInfo.Setup_Fees__c - suph2;
				decimal num23 = num13 / suph2;
				suFlatIncTotal = num23 * 100;
			
		}
		
		if(oppInfo.Total_Training__c == trph2){
			trFlatIncTotal = 0;
		}
		if(oppInfo.Total_Training__c != trph2){
			decimal num14 = oppInfo.Total_Training__c - trph2;
			decimal num24 = num14 / trph2;
			trFlatIncTotal = num24 * 100;
		}
		
	}
	public void realTimeTotalFlatIncrease(){
		if(oppInfo.Monthly_Recurring_Fees__c > 0){
			if(oppInfo.Monthly_Recurring_Fees__c != mrrph2){
				decimal num1 = oppInfo.Monthly_Recurring_Fees__c + mrrFlat;
				decimal num2 = mrrph2 / num1;
				mrrFlatIncTotal = 100 - num2 * 100;
			}
		}
		if(oppInfo.One_Time_Fees2__c > 0){
			if(oppInfo.One_Time_Fees2__c != otph2){
				decimal num12 = oppInfo.One_Time_Fees2__c + oneTimeFlat;
				decimal num22 = otph2 / num12;
				otFlatIncTotal = 100 - num22 * 100;
			}
		}
		if(oppInfo.Setup_Fees__c > 0 ){
			if(oppInfo.Setup_Fees__c != suph2){
				decimal num13 = oppInfo.Setup_Fees__c + setUpFlat;
				decimal num23 = suph2 / num13;
				suFlatIncTotal = 100 - num23 * 100;
			}
		}
		if(oppInfo.Total_Training__c > 0){
			if(oppInfo.Total_Training__c != trph2){
				decimal num14 = oppInfo.Total_Training__c + trainFlat;
				decimal num24 = trph2 / num14;
				trFlatIncTotal = 100 - num24 * 100;
			}
		}
		
	}
/*******************************************************************************************************************************************/	
	
	public void updateUserPriceChange(){
		
		for(OpportunityLineItem olimrr : relatedOLIsMonthly){
			olimrr.UserPriceChange__c = true;
		}
		update relatedOLIsMonthly;
		
		for(OpportunityLineItem  oliot : relatedOLIsOneTime){
			oliot.UserPriceChange__c = true;
		}
		update relatedOLIsOneTime;
		for(OpportunityLineItem olisu : relatedOLIsSetUp){
			olisu.UserPriceChange__c = true;
		}
		update relatedOLIsSetUp;
		for(OpportunityLineItem olitr : relatedOLIsTraining){
			olitr.UserPriceChange__c = true;
		}
		update relatedOLIsTraining;
	}

	public List<SelectOption> incDec = new List<SelectOption>();
	public List<SelectOption> getIncDec(){
		
		List<SelectOption> incDecType = new List<SelectOption>();
		incDecType.add(new SelectOption('Select...', 'Select...'));
		incDecType.add(new SelectOption('Decrease', 'Decrease'));
		incDecType.add(new SelectOption('Increase', 'Increase'));
		
		return incDecType;
	}
	
	public List<SelectOption> perFlat = new List<SelectOption>();
	public List<SelectOption> getPerFlat(){
		
		List<SelectOption> perFlatType = new List<SelectOption>();
		perFlatType.add(new SelectOption('Select...', 'Select...'));
		perFlatType.add(new SelectOption('Percentage', 'Percentage'));
		perFlatType.add(new SelectOption('Flat', 'Flat'));
		
		return perFlatType;
	}
	
	public PageReference typeChange(){
		
		submitTrue = true;
		
		mrrPercent = null;
		mrrFlat = null;
		oneTimePercent = null;
		oneTimeFlat = null;
		setUpPercent = null;
		setUpFlat = null;
		trainPercent = null;
		trainFlat = null;
		
		reset = false;
		
		return null;
	}
	
	public PageReference rateType(){
		
		newMRR = 0;
		newOT = 0;
		newSU = 0;
		newTR = 0;
		
		submitTrue = true;
		
		mrrPercent = null;
		mrrFlat = null;
		oneTimePercent = null;
		oneTimeFlat = null;
		setUpPercent = null;
		setUpFlat = null;
		trainPercent = null;
		trainFlat = null;
		

		if(typeOfAdjustment == 'Decrease' && typeOfRate == 'Percentage'){
			totalPercentageDiscount();
		}
		if(typeOfAdjustment == 'Decrease' && typeOfRate == 'Flat'){
			totalFlatDiscount();
		}
		if(typeOfAdjustment == 'Increase' && typeOfRate == 'Percentage'){
			totalPercentageIncrease();
		}
		if(typeOfAdjustment == 'Increase' && typeOfRate == 'Flat'){
			totalFlatIncrease();
		}
		
		return null;
	}
	public PageReference returnToOpp(){
		PageReference pr = new PageReference('/' + oppId);
		
		return pr;
		
	}
	public PageReference returnToOppSubDecPer(){
		submitDecPer();
		PageReference pr = new PageReference('/' + oppId);
		
		return pr;
	}
	public PageReference returnToOppSubDecFlat(){
		submitDecFlat();
		PageReference pr = new PageReference('/' + oppId);
		
		return pr;
	}
	public PageReference returnToOppSubIncPer(){
		submitIncPer();
		PageReference pr = new PageReference('/' + oppId);
		
		return pr;
	}
	public PageReference returnToOppSubIncFlat(){
		submitIncFlat();
		PageReference pr = new PageReference('/' + oppId);
		
		return pr;
	}
	
	public void resetDecPer(){
		
		mrrPercent = 0;
		oneTimePercent = 0;
		setUpPercent = 0;
		trainPercent = 0;
		
		mrrZeroError = false;
		otZeroError = false;
		suZeroError = false;
		trZeroError = false;
		
		reset = false;
		
		submitTrue = true;
		
	}
	
	public void calculateDecPer(){
		
		newMrr = 0;
		newOT = 0;
		newSU = 0;
		newTR = 0;
		
		if(mrrZero == true && mrrPercent >0){
			mrrZeroError = true;
			reset = true;
		}
		if(otZero == true && oneTimePercent > 0){
			otZeroError = true; 
			reset = true;
		}
		if(suZero == true && setUpPercent > 0){
			suZeroError = true;
			reset = true;
		}
		if(trZero == true && trainPercent > 0){
			trZeroError = true;
			reset = true;
		}
		updateUserPriceChange();
		
		if(mrrPercent <= 100 && oneTimePercent <= 100 && setUpPercent <= 100 && trainPercent <= 100){
			if(mrrPercent != null && mrrPercent <= 100){
				decimal percent = mrrPercent * .01;
				
				decimal visualSubtract = percent * oppInfo.Monthly_Recurring_Fees__c;
				newMrr = oppInfo.Monthly_Recurring_Fees__c - visualSubtract;
				mrrPerDecPH = oppInfo.Monthly_Recurring_Fees__c - visualSubtract;
				mrrPercentPH = mrrPercent;
				perOverMax = false;
				
			}

			if(oneTimePercent != null && oneTimePercent <= 100){
				
				decimal percentOT = oneTimePercent * .01;
				
				decimal visualSubtractOT = percentOT * oppInfo.One_Time_Fees2__c;
				newOT = oppInfo.One_Time_Fees2__c - visualSubtractOT;
				otPerDecPH = oppInfo.One_Time_Fees2__c - visualSubtractOT;
				oneTimePercentPH = oneTimePercent;
				perOverMax = false;
			}
	
			if(setUpPercent != null && setUpPercent <= 100){
				
				decimal percentSU = setUpPercent * .01;
				
				decimal visualSubtractSU = percentSU * oppInfo.Setup_Fees__c;
				newSU = oppInfo.Setup_Fees__c - visualSubtractSU;
				suPerDecPH = oppInfo.Setup_Fees__c - visualSubtractSU;
				setUpPercentPH = setUpPercent;
				perOverMax = false;
				
			}
	
			if(trainPercent != null && trainPercent <= 100){
			
				decimal percentTrain = trainPercent * .01;
				
				decimal visualSubtractTR = percentTrain * oppInfo.Total_Training__c;
				newTR = oppInfo.Total_Training__c - visualSubtractTR;
				trPerDecPH = oppInfo.Total_Training__c - visualSubtractTR;
				trainPercentPH = trainPercent;
				perOverMax = false;
			}
			
			submitTrue = false;
		}
		//totalPercentageDiscount();
		realTimeTotalDiscountPercentage();
	}
	
	public void submitDecPer(){
		
		if(mrrPercent <= 100 && oneTimePercent <= 100 && setUpPercent <= 100 && trainPercent <= 100){
			if(mrrPercent != null && mrrPercent <= 100){
				decimal percent = mrrPercentPH * .01;
				if(mrrDPCPH == 0.0){
					for(OpportunityLineItem oli : relatedOLIsMonthly){
						
						decimal subtract = percent * oli.UnitPrice;
						oli.UnitPrice = (oli.UnitPrice - subtract).setScale(2);
		
					}
				}
				if(mrrDPCPH != 0.0){
					if(mrrph2 == oppInfo.Monthly_Recurring_Fees__c){
						decimal percent1 = mrrPercentPH * .01;
						decimal num1 = oppInfo.Monthly_Recurring_Fees__c * percent1;
						decimal num2 = mrrph - num1;
						decimal num3 = num2 / mrrph;
						decimal num4 = 1 - num3;
						//decimal num101 = mrrph * num100;
						//decimal num102 = num1 / mrrListSize;
						for(OpportunityLineItem oli1 : relatedOLIsMonthly){
							decimal subtract1 = num4 * oli1.UnitPrice;
							oli1.UnitPrice = (oli1.UnitPrice - subtract1).setScale(2);
							//oli1.UnitPrice = oli1.UnitPrice * num3;
						}
					}
					if(mrrph2 != oppInfo.Monthly_Recurring_Fees__c){
						decimal total = mrrPhAfter + mrrph1;
						decimal num111 = total * percent;
						decimal num222 = mrrPhAfter - num111;
						decimal num333 = num222 / mrrPhAfter;
						for(OpportunityLineItem oli2 : relatedOLIsMonthly){
							oli2.UnitPrice = (oli2.UnitPrice * num333).setScale(2);
						}
					}
				}
				update relatedOLIsMonthly;
				
			}
			
			if(oneTimePercent != null && oneTimePercent <= 100){
				
				if(otDPCPH == 0.0){
					decimal percentOT = oneTimePercentPH * .01;
				
					for(OpportunityLineItem oliOT : relatedOLIsOneTime){
						
						decimal subtractOT = percentOT * oliOT.UnitPrice;
						oliOT.UnitPrice = (oliOT.UnitPrice - subtractOT).setScale(2);
						
					}
				}
				if(otDPCPH != 0.0 && otph != 0){
					if(otph2 == oppInfo.One_Time_Fees2__c){
						decimal percentOT1 = oneTimePercentPH * .01;
						decimal num11 = oppInfo.One_Time_Fees2__c * percentOT1;
						decimal num21 = otph - num11;
						decimal num31 = num21 / otph;
						decimal num41 = 1 - num31;
						for(OpportunityLineItem oliOT1 : relatedOLIsOneTime){
							decimal subtractOT1 = num41 * oliOT1.UnitPrice;
							oliOT1.UnitPrice = (oliOT1.UnitPrice - subtractOT1).setScale(2);
						}
					}
					if(otph2 != oppInfo.One_Time_Fees2__c){
						decimal percentOT2 = oneTimePercentPH * .01;
						decimal total1 = otPhAfter + otph1;
						decimal num1111 = total1 * percentOT2;
						decimal num211 = otPhAfter - num1111;
						decimal num311 = num211 / otPhAfter;
						for(OpportunityLineItem oliOT2 : relatedOLIsOneTime){
							oliOT2.UnitPrice = (oliOT2.UnitPrice * num311).setScale(2);
						}
					}
				}
				update relatedOLIsOneTime;
			}
			
			if(setUpPercent != null && setUpPercent <= 100){
				
				if(suDPCPH == 0.0){
					decimal percentSU = setUpPercentPH * .01;
				
					for(OpportunityLineItem oliSU : relatedOLIsSetUp){
						
						decimal subtractSU = percentSU * oliSU.UnitPrice;
						oliSU.UnitPrice = (oliSU.UnitPrice - subtractSU).setScale(2);
					}
				}
				if(suDPCPH != 0.0 && suph != 0){
					if(suph2 == oppInfo.Setup_Fees__c){
						decimal percentSU1 = setUpPercentPH * .01;
						decimal num12 = oppInfo.Setup_Fees__c * percentSU1;
						decimal num22 = suph - num12;
						decimal num32 = num22 / suph;
						decimal num42 = 1 - num32;
						for(OpportunityLineItem oliSU1 : relatedOLIsSetUp){
							decimal subtractSU1 = num42 * oliSU1.UnitPrice;
							oliSU1.UnitPrice = (oliSU1.UnitPrice - subtractSU1).setScale(2);
						}	
					}
					if(suph2 != oppInfo.Setup_Fees__c){
						decimal percentSU2 = setUpPercentPH * .01;
						decimal total3 = suPhAfter + suph1;
						decimal num122 = total3 * percentSU2;
						decimal num222 = suPhAfter - num122;
						decimal num322 = num222 / suPhAfter;
						for(OpportunityLineItem oliSU2 : relatedOLIsSetUp){
							oliSU2.UnitPrice = (oliSU2.UnitPrice * num322).setScale(2);
						}
					}
				}
				
				update relatedOLIsSetUp;
			}
			
			if(trainPercent != null && trainPercent <= 100){
				
				decimal percentTrain = trainPercentPH * .01;
				if( trDPCPH == 0.0){
					for(OpportunityLineItem oliT : relatedOLIsTraining){
						
						decimal subtractTraining = percentTrain * oliT.UnitPrice;
						oliT.UnitPrice = (oliT.UnitPrice - subtractTraining).setScale(2);
					}
				}
				if(trDPCPH != 0.0){
					if(trph2 == oppInfo.Total_Training__c){
						decimal num13 = oppInfo.Total_Training__c * percentTrain;
						decimal num23 = trph - num13;
						decimal num33 = num23 / suph;
						decimal num43 = 1- num33;
						for(OpportunityLineItem oliT1 : relatedOLIsTraining){
							decimal subtractTraining1 = num43 * oliT1.UnitPrice;
							oliT1.UnitPrice = (oliT1.UnitPrice - subtractTraining1).setScale(2);
						}
					}
					if(trph2 != oppInfo.Total_Training__c){
						decimal total4 = trPhAfter + trph1;
						decimal num133 = total4 * percentTrain;
						decimal num233 = trPhAfter - num133;
						decimal num3333 = num233 / trPhAfter;
						for(OpportunityLineItem oliT2 : relatedOLIsTraining){
							oliT2.UnitPrice = (oliT2.UnitPrice * num3333).setScale(2);
						}
					}
				}
				update relatedOLIsTraining;
				
			}
		}
	}
	
	public void resetDecFlat(){
		
		mrrFlat = 0;
		oneTimeFlat = 0;
		setUpFlat = 0;
		trainFlat = 0;
		
		mrrZeroError = false;
		otZeroError = false;
		suZeroError = false;
		trZeroError = false;
		
		reset = false;
		
		submitTrue = true;
		
	}
	
	public void calculateDecFlat(){
		
		newMrr = 0;
		newOT = 0;
		newSU = 0;
		newTR = 0;
		
		if(mrrZero == true && mrrFlat >0){
			mrrZeroError = true;
			reset = true;
		}
		if(otZero == true && oneTimeFlat > 0){
			otZeroError = true; 
			reset = true;
		}
		if(suZero == true && setUpFlat > 0){
			suZeroError = true;
			reset = true;
		}
		if(trZero == true && trainFlat > 0){
			trZeroError = true;
			reset = true;
		}
		
		updateUserPriceChange();
		
		if(mrrFlat <= oppInfo.Monthly_Recurring_Fees__c && oneTimeFlat <= oppInfo.One_Time_Fees2__c && setUpFlat <= oppInfo.Setup_Fees__c && trainFlat <= oppInfo.Total_Training__c){
			if(mrrFlat > 0){
				
				decimal numToSubtractMRR = oppInfo.Monthly_Recurring_Fees__c - mrrFlat;
				decimal percentToUseMRR = numToSubtractMRR / oppInfo.Monthly_Recurring_Fees__c;
				newMrr = numToSubtractMRR;
				mrrFlatDecPH = numToSubtractMRR;
				decimal getPercentage = percentToUseMRR * 100;
				mrrFlatPercentage = 100 - getPercentage;
				mrrFlatPH = mrrFlat;
			}
			
			if(oneTimeFlat > 0){
				
				decimal numToSubtractOT = oppInfo.One_Time_Fees2__c - oneTimeFlat;
				decimal percentToUseOT =  numToSubtractOT / oppInfo.One_Time_Fees2__c;
				newOT = numTOSubtractOT;
				otFlatDecPH = numToSubtractOT;
				decimal getPercentageOT = percentToUseOT * 100;
				otFlatPercentage = 100 - getPercentageOT;
				oneTimeFlatPH = oneTimeFlat;
			}
			
			if(setUpFlat > 0){
				
				decimal numToSubtractSU = oppInfo.Setup_Fees__c - setUpFlat;
				decimal percentToUseSU = numToSubtractSU / oppInfo.Setup_Fees__c;
				newSU = numToSubtractSU;
				suFlatDecPH = numToSubtractSU;
				decimal getPercentageSU = percentToUseSU * 100;
				suFlatPercentage = 100 - getPercentageSU;
				setUpFlatPH = setUpFlat;
				
			}
			
			if(trainFlat > 0){
				
				decimal numToSubtractTR = oppInfo.Total_Training__c - trainFlat;
				decimal percentToUseTR = numToSubtractTR / oppInfo.Total_Training__c;
				newTR = numToSubtractTR;
				trFlatDecPH = numToSubtractTR;
				decimal getPercentageTR = percentToUseTR * 100;
				trFlatPercentage = 100 - getPercentageTR;
			}
			submitTrue = false;
		}
		realTimeTotalFlatDiscount();
	}
	
	public void submitDecFlat(){
		
		if(mrrFlat <= oppInfo.Monthly_Recurring_Fees__c && oneTimeFlat <= oppInfo.One_Time_Fees2__c && setUpFlat <= oppInfo.Setup_Fees__c && trainFlat <= oppInfo.Total_Training__c){
			if(mrrFlat > 0){
				
				decimal numToSubtractMRR = oppInfo.Monthly_Recurring_Fees__c - mrrFlat;
				decimal percentToUseMRR = numToSubtractMRR / oppInfo.Monthly_Recurring_Fees__c;
				if(mrrDPCPH == 0.0){
					for(OpportunityLineItem oli : relatedOLIsMonthly){
						
						oli.UnitPrice = (oli.UnitPrice * percentToUseMRR).setScale(2);
					}
				}
				if(mrrDPCPH != 0.0){
					if(mrrph2 == oppInfo.Monthly_Recurring_Fees__c){
						decimal num11 = numToSubtractMRR - mrrDPCPH;
						decimal num12 = num11 / mrrph;
						for(OpportunityLineItem oli1 : relatedOLIsMonthly){
							oli1.UnitPrice = (oli1.UnitPrice * num12).setScale(2);
						}
					}
					if(mrrph2 != oppInfo.Monthly_Recurring_Fees__c){
						decimal total = mrrPhAfter + mrrph1;
						decimal subtract = total - mrrFlat;
						decimal num111 = subtract - mrrDPCPH;
						decimal num122 = num111 / mrrPhAfter;
						for(OpportunityLineItem oli2 : relatedOLIsMonthly){
							oli2.UnitPrice = (oli2.UnitPrice * num122).setScale(2);
						}
					}
					
					
				}
				update relatedOLIsMonthly;
			}
			
			if(oneTimeFlat > 0){
				
				decimal numToSubtractOT = oppInfo.One_Time_Fees2__c - oneTimeFlat;
				decimal percentToUseOT =  numToSubtractOT / oppInfo.One_Time_Fees2__c;
				if(otDPCPH == 0.0){
					for(OpportunityLineItem oliOT : relatedOLIsOneTime){
						
						oliOT.UnitPrice = (oliOT.UnitPrice * percentToUseOT).setScale(2);
					}
				}
				if(otDPCPH != 0.0){
					if(otph2 == oppInfo.One_Time_Fees2__c){
						decimal num12 = numToSubtractOT - otDPCPH;
						decimal num22 = num12 / otph;
						for(OpportunityLineItem  oliOT1 : relatedOLIsOneTime){
							oliOT1.UnitPrice = (oliOT1.UnitPrice * num22).setScale(2);
						}
					}
					if(otph2 != oppInfo.One_Time_Fees__c){
						decimal total1 = otPhAfter + otph1;
						decimal subtract1 = total1 - oneTimeFlat;
						decimal num122 = subtract1 - otDPCPH;
						decimal num222 = num122 / otPhAfter;
						for(OpportunityLineItem oliOT2 : relatedOLIsOneTime){
							oliOT2.UnitPrice = (oliOT2.UnitPrice * num222).setScale(2);
						}
					}
				}
				update relatedOLIsOneTime;
			}
			
			if(setUpFlat > 0){
				
				decimal numToSubtractSU = oppInfo.Setup_Fees__c - setUpFlat;
				decimal percentToUseSU = numToSubtractSU / oppInfo.Setup_Fees__c;
				if(suDPCPH == 0.0){
					for(OpportunityLineItem oliSU : relatedOLIsSetUp){
						
						oliSU.UnitPrice = (oliSU.UnitPrice * percentToUseSU).setScale(2);
					}
				}
				if(suDPCPH != 0.0){
					if(suph2 == oppInfo.Setup_Fees__c){
						decimal num13 = numToSubtractSU - suDPCPH;
						decimal num23 = num13 / suph;
						for(OpportunityLineItem oliSU1 : relatedOLIsSetUp){
							oliSU1.UnitPrice = (oliSU1.UnitPrice * num23).setScale(2); 
						}
					}
					if(suph2 != oppInfo.Setup_Fees__c){
						decimal total2 = suPhAfter + suph1;
						decimal subtract2 = total2 - setUpFlat;
						decimal num133 = subtract2 - suDPCPH;
						decimal num233 = num133 / suPhAfter;
						for(OpportunityLineItem oliSU2 : relatedOLIsSetUp){
							oliSU2.UnitPrice = (oliSU2.UnitPrice * num233).setScale(2);
						}
					}
				}
				update relatedOLIsSetUp;
			}
			
			if(trainFlat > 0){
				
				decimal numToSubtractTR = oppInfo.Total_Training__c - trainFlat;
				decimal percentToUseTR = numToSubtractTR / oppInfo.Total_Training__c;
				if(trDPCPH == 0.0){
					for(OpportunityLineItem oliTR : relatedOLIsTraining){
						
						oliTR.UnitPrice = (oliTR.UnitPrice * percentToUseTR).setScale(2);
					}
				}
				if(trDPCPH != 0.0){
					if(trph2 == oppInfo.Total_Training__c){
						decimal num14 = numToSubtractTR - trDPCPH;
						decimal num24 = num14 / trph;
						for(OpportunityLineItem oliTR1 : relatedOLIsTraining){
							oliTR1.UnitPrice = (oliTR1.UnitPrice * num24).setScale(2);
						}
					}
					if(trph2 != oppInfo.Total_Training__c){
						decimal total3 = trPhAfter + trph1;
						decimal subtract3 = total3 - trainFlat;
						decimal num144 = subtract3 - trDPCPH;
						decimal num244 = num144 / trPhAfter;
						for(OpportunityLineItem oliT2 : relatedOLIsTraining){
							oliT2.UnitPrice = (oliT2.UnitPrice * num244).setScale(2);
						}
					}
				}
				update relatedOLIsTraining;
			}
		}
		
	}
	
	public void resetIncPer(){
		
		mrrPercent = 0;
		oneTimePercent = 0;
		setUpPercent = 0;
		trainPercent = 0;
		
		mrrZeroError = false;
		otZeroError = false;
		suZeroError = false;
		trZeroError = false;
		
		reset = false;
		
		submitTrue = true;
	}
	
	public void calculateIncPer(){
		
		newMrr = 0;
		newOT = 0;
		newSU = 0;
		newTR = 0;
		
		if(mrrZero == true && mrrPercent >0){
			mrrZeroError = true;
			reset = true;
		}
		if(otZero == true && oneTimePercent > 0){
			otZeroError = true; 
			reset = true;
		}
		if(suZero == true && setUpPercent > 0){
			suZeroError = true;
			reset = true;
		}
		if(trZero == true && trainPercent > 0){
			trZeroError = true;
			reset = true;
		}
		
		updateUserPriceChange();
		
		if(mrrPercent <= 100 && oneTimePercent <= 100 && setUpPercent <= 100 && trainPercent <= 100){
			if(mrrPercent != null && mrrPercent <= 100){
				decimal percent = mrrPercent * .01;
				
				decimal visualAdd = percent * oppInfo.Monthly_Recurring_Fees__c;
				newMrr = oppInfo.Monthly_Recurring_Fees__c + visualAdd;
				mrrPerIncPH = oppInfo.Monthly_Recurring_Fees__c + visualAdd;
				mrrPercentPH = mrrPercent;
			}
			
			if(oneTimePercent != null && oneTimePercent <= 100){
				
				decimal percentOT = oneTimePercent * .01;
				
				decimal visualAddOT = percentOT * oppInfo.One_Time_Fees2__c;
				newOT = oppInfo.One_Time_Fees2__c + visualAddOT;
				otPerIncPH = oppInfo.One_Time_Fees2__c + visualAddOT;
				oneTimePercentPH = oneTimePercent;
			}
			
			if(setUpPercent != null && setUpPercent <= 100){
				
				decimal percentSU = setUpPercent * .01;
				
				decimal visualAddSU = percentSU * oppInfo.Setup_Fees__c;
				newSU = oppInfo.Setup_Fees__c + visualAddSU;
				suPerIncPH = oppInfo.Setup_Fees__c + visualAddSU;
				setUpPercentPH = setUpPercent;
				
			}
			if(trainPercent != null && trainPercent <= 100){
			
				decimal percentTrain = trainPercent * .01;
				
				decimal visualAddTR = percentTrain * oppInfo.Total_Training__c;
				newTR = oppInfo.Total_Training__c + visualAddTR;
				trPerIncPH = oppInfo.Total_Training__c + visualAddTR;
				trainPercentPH = trainPercent;
			}
			submitTrue = false;
			realTimeTotalPercentageIncrease();
		}
	}
	
	public void submitIncPer(){
		
		if(mrrPercent <= 100 && oneTimePercent <= 100 && setUpPercent <= 100 && trainPercent <= 100){
			if(mrrPercent != null && mrrPercent <= 100){
				decimal percent = mrrPercentPH * .01;
				if(mrrDPCPH == 0.0){
					for(OpportunityLineItem oli : relatedOLIsMonthly){
						
						decimal add = percent * oli.UnitPrice;
						oli.UnitPrice = (oli.UnitPrice + add).setScale(2);
		
					}
				}
				if(mrrDPCPH != 0.0){
					if(mrrph2 == oppInfo.Monthly_Recurring_Fees__c){
						decimal num11 = percent * oppInfo.Monthly_Recurring_Fees__c;
						decimal num12 = mrrph - num11;
						decimal num13 = num12 / mrrph;
						decimal num14 = 1 - num13;
						for(OpportunityLineItem oli1 : relatedOLIsMonthly){
							decimal add1 = oli1.UnitPrice * num14;
							oli1.UnitPrice = (oli1.UnitPrice + add1).setScale(2);				
						}
					}
					if(mrrph2 != oppInfo.Monthly_Recurring_Fees__c){
						decimal total1 = mrrPhAfter + mrrph1;
						decimal num111 = total1 * percent;
						decimal num122 = mrrPhAfter + num111;
						decimal num133 = num122 / mrrPhAfter;
						for(OpportunityLineItem oli2 : relatedOLIsMonthly){
							oli2.UnitPrice = (oli2.UnitPrice * num133).setScale(2);
						} 
					}
				}
				update relatedOLIsMonthly;
				
			}
			if(oneTimePercent != 0 && oneTimePercent <= 100){
				
				decimal percentOT = oneTimePercentPH * .01;
				if(otDPCPH == 0.0){
					for(OpportunityLineItem oliOT : relatedOLIsOneTime){
						
						decimal addOT = percentOT * oliOT.UnitPrice;
						oliOT.UnitPrice = (oliOT.UnitPrice + addOT).setScale(2);
						
					}
				}
				if(otDPCPH != 0.0){
					if(otph2 == oppInfo.One_Time_Fees2__c){
						decimal num21 = percentOT * oppInfo.One_Time_Fees2__c;
						decimal num22 = otph - num21;
						decimal num23 = num22 / otph;
						decimal num24 = 1 - num23;
						for(OpportunityLineItem oliOT1 : relatedOLIsOneTime){
							decimal add2 = oliOT1.UnitPrice * num24;
							oliOT1.UnitPrice = (oliOT1.UnitPrice + add2).setScale(2);
						}
					}
					if(otph2 != oppInfo.One_Time_Fees2__c){
						decimal total2 = otPhAfter + otph1;
						decimal num211 = total2 * percentOT;
						decimal num222 = otPhAfter + num211;
						decimal num233 = num222 / otPhAfter;
						for(OpportunityLineItem oliOT2 : relatedOLIsOneTime){
							oliOT2.UnitPrice = (oliOT2.UnitPrice * num233).setScale(2);
						}
					}
					
				}
				update relatedOLIsOneTime;
			}
			
			if(setUpPercent != null && setUpPercent <= 100){
				
				decimal percentSU = setUpPercentPH * .01;
				if(suDPCPH == 0.0){
					for(OpportunityLineItem oliSU : relatedOLIsSetUp){
						
						decimal addSU = percentSU * oliSU.UnitPrice;
						oliSU.UnitPrice = (oliSU.UnitPrice + addSU).setScale(2);
					}
				}
				if(suDPCPH != 0.0){
					if(suph2 == oppInfo.Setup_Fees__c){
						decimal num31 = percentSU * oppInfo.Setup_Fees__c;
						decimal num32 = suph - num31;
						decimal num33 = num32 / suph;
						decimal num34 = 1 - num33;
						for(OpportunityLineItem oliSU1 : relatedOLIsSetUp){
							decimal add3 = oliSU1.UnitPrice * num34;
							oliSU1.UnitPrice = (oliSU1.UnitPrice + add3).setScale(2);
						}
					}
					if(suph2 != oppInfo.Setup_Fees__c){
						decimal total3 = suPhAfter + suph1;
						decimal num311 = total3 * percentSU;
						decimal num322 = suPhAfter + num311;
						decimal num333 = num322 / suPhAfter;
						for(OpportunityLineItem oliSU2 : relatedOLIsSetUp){
							oliSU2.UnitPrice = (oliSU2.UnitPrice * num333).setScale(2);
						}
					}
				}
					update relatedOLIsSetUp;
			}
			
			if(trainPercent != 0 && trainPercent <= 100){
				
				decimal percentTrain = trainPercentPH * .01;
				if(trDPCPH == 0.0){
					for(OpportunityLineItem oliT : relatedOLIsTraining){
						
						decimal addTraining = percentTrain * oliT.UnitPrice;
						oliT.UnitPrice = (oliT.UnitPrice + addTraining).setScale(2);
					}
				}
				if(trDPCPH != 0.0){
					if(trph2 == oppInfo.Total_Training__c){
						decimal num41 = percentTrain * oppInfo.Total_Training__c;
						decimal num42 = trph - num41;
						decimal num43 = num42 / trph;
						decimal num44 = 1 - num43;
						for(OpportunityLineItem oliT1 : relatedOLIsTraining){
							decimal add4 = oliT1.UnitPrice * num44;
							oliT1.UnitPrice = (oliT1.UnitPrice + add4).setScale(2);
						}
					}
					if(trph2 != oppInfo.Total_Training__c){
						decimal total4 = trPhAfter + trph1;
						decimal num411 = total4 * percentTrain;
						decimal num422 = trPhAfter + num411;
						decimal num433 = num422 / trPhAfter;
						for(OpportunityLineItem oliT2 : relatedOLIsTraining){
							oliT2.UnitPrice = (oliT2.UnitPrice * num433).setScale(2);
						}
					}
				}
				update relatedOLIsTraining;
				
			}
		}
	}
	
	public void resetIncFlat(){
		
		mrrFlat = 0;
		oneTimeFlat = 0;
		setUpFlat = 0;
		trainFlat = 0;
		
		mrrZeroError = false;
		otZeroError = false;
		suZeroError = false;
		trZeroError = false;
		
		reset = false;
		
		submitTrue = true;
		
		//calculateIncFlat();
	}
	
	
	public void calculateIncFlat(){
		
		newMrr = 0;
		newOT = 0;
		newSU = 0;
		newTR = 0;
		//submitTrue = false;
		if(mrrZero == true && mrrFlat >0){
			mrrZeroError = true;
			reset = true;
		}
		if(otZero == true && oneTimeFlat > 0){
			otZeroError = true; 
			reset = true;
		}
		if(suZero == true && setUpFlat > 0){
			suZeroError = true;
			reset = true;
		}
		if(trZero == true && trainFlat > 0){
			trZeroError = true;
			reset = true;
		}
		
		updateUserPriceChange();
		
		if(mrrFlat <= oppInfo.Monthly_Recurring_Fees__c && oneTimeFlat <= oppInfo.One_Time_Fees2__c && setUpFlat <= oppInfo.Setup_Fees__c && trainFlat <= oppInfo.Total_Training__c){
			
			
			if(mrrFlat > 0){
				//mrrFlat = 100;
				decimal numToAddMRR = oppInfo.Monthly_Recurring_Fees__c + mrrFlat;
				//decimal noZeroes = oppInfo.Monthly_Recurring_Fees__c + .001;
				//decimal percentToUseMRR = numToAddMRR / oppInfo.Monthly_Recurring_Fees__c;
				decimal percentToUseMRR = numToAddMRR / mrrPlus;
				newMrr = numToAddMRR;
				mrrFlatPH = numToAddMRR;
				decimal getPercentage = percentToUseMRR * 100;
				mrrFlatPercentage = getPercentage - 100;
				mrrFlatPH = mrrFlat;
			}
			
			if(oneTimeFlat > 0){
				
				decimal numToAddOT = oppInfo.One_Time_Fees2__c + oneTimeFlat;
				decimal percentToUseOT =  numToAddOT / oppInfo.One_Time_Fees2__c;
				newOT = numTOAddOT;
				otFlatIncPH = numToAddOT;
				decimal getPercentageOT = percentToUseOT * 100;
				otFlatPercentage = getPercentageOT - 100;
				oneTimeFlatPH = oneTimeFlat;
			}
			if(setUpFlat > 0){
				
				decimal numToAddSU = oppInfo.Setup_Fees__c + setUpFlat;
				decimal percentToUseSU = numToAddSU / oppInfo.Setup_Fees__c;
				newSU = numToAddSU;
				suFlatIncPH = numToAddSU;
				decimal getPercentageSU = percentToUseSU * 100;
				suFlatPercentage = getPercentageSU - 100;
				setUpFlatPH = setUpFlat;
				
			}
			
			if(trainFlat > 0){
				
				decimal numToAddTR = oppInfo.Total_Training__c + trainFlat;
				decimal percentToUseTR = numToAddTR / oppInfo.Total_Training__c;
				newTR = numToAddTR;
				trFlatIncPH = numToAddTR;
				decimal getPercentageTR = percentToUseTR * 100;
				trFlatPercentage = getPercentageTR - 100;
			}
			
			submitTrue = false;
				
			realTimeTotalFlatIncrease();
		}
	}
	
	public void submitIncFlat(){
		
		//if(mrrFlat <= oppInfo.Monthly_Recurring_Fees__c && oneTimeFlat <= oppInfo.One_Time_Fees2__c && setUpFlat <= oppInfo.Setup_Fees__c && trainFlat <= oppInfo.Total_Training__c){
			if(mrrFlat > 0){
				
				decimal numToAddMRR = oppInfo.Monthly_Recurring_Fees__c + mrrFlat;
				decimal percentToUseMRR;
				
				
				if(oppInfo.Monthly_Recurring_Fees__c > 0){
					percentToUseMRR = numToAddMRR / oppInfo.Monthly_Recurring_Fees__c;
				}
				else if(oppInfo.Monthly_Recurring_Fees__c <= 0){
					percentToUseMRR = numToAddMRR / 1;
				}
				//percentToUseMRR = numToAddMRR / oppInfo.Monthly_Recurring_Fees__c;
				if(mrrDPCPH == 0.0){
					for(OpportunityLineItem oli : relatedOLIsMonthly){
						
						oli.UnitPrice = (oli.UnitPrice * percentToUseMRR).setScale(2);
						//oli.UnitPrice = mrrFlat + oppInfo.Monthly_Recurring_Fees__c;
					}
				}
				if(mrrDPCPH != 0.0){
					if(mrrph2 == oppInfo.Monthly_Recurring_Fees__c){
						decimal num11 = mrrph + mrrFlat;
						decimal num12 = num11 / mrrph;
						for(OpportunityLineItem oli1 : relatedOLIsMonthly){
							oli1.UnitPrice = (oli1.UnitPrice * num12).setScale(2);
						}
					}
					if(mrrph2 != oppInfo.Monthly_Recurring_Fees__c){
						decimal num111 = mrrPhAfter + mrrFlat;
						decimal num122 = num111 / mrrPhAfter;
						for(OpportunityLineItem oli2 : relatedOLIsMonthly){
							oli2.UnitPrice = (oli2.UnitPrice * num122).setScale(2);
						}
					}
				}
				update relatedOLIsMonthly;
			}
			if(oneTimeFlat > 0){
				
				decimal numToAddOT = oppInfo.One_Time_Fees2__c + oneTimeFlat;
				decimal percentToUseOT =  numToAddOT / oppInfo.One_Time_Fees2__c;
				if(otDPCPH == 0.0){
					for(OpportunityLineItem oliOT : relatedOLIsOneTime){
						
						oliOT.UnitPrice = (oliOT.UnitPrice * percentToUseOT).setScale(2);
					}
				}
				if(otDPCPH != 0.0){
					if(otph2 == oppInfo.One_Time_Fees2__c){
						decimal num21 = otph + oneTimeFlat;
						decimal num22 = num21 / otph;
						for(OpportunityLineItem oliOT1 : relatedOLIsOneTime){
							oliOT1.UnitPrice = (oliOT1.UnitPrice * num22).setScale(2);
						}
					}
					if(otph2 != oppInfo.One_Time_Fees2__c){
						decimal num211 = otPhAfter + oneTimeFlat;
						decimal num222 = num211 / otPhAfter;
						for(OpportunityLineItem oliOT2 : relatedOLIsOneTime){
							oliOT2.UnitPrice = (oliOT2.UnitPrice * num222).setScale(2);
						}
					}	
				}
				update relatedOLIsOneTime;
			}
			
			if(setUpFlat > 0){
				
				decimal numToAddSU = oppInfo.Setup_Fees__c + setUpFlat;
				decimal percentToUseSU = numToAddSU / oppInfo.Setup_Fees__c;
				if(suDPCPH == 0.0){
					for(OpportunityLineItem oliSU : relatedOLIsSetUp){
						
						oliSU.UnitPrice = (oliSU.UnitPrice * percentToUseSU).setScale(2);
					}
				}
				if(suDPCPH != 0.0){
					if(suph2 == oppInfo.Setup_Fees__c){
						decimal num31 = suph + setUpFlat;
						decimal num32 = num31 / suph;
						for(OpportunityLineItem oliSU1 : relatedOLIsSetUp){
							oliSU1.UnitPrice = (oliSU1.UnitPrice * num32).setScale(2);
						}
					}
					if(suph2 != oppInfo.Setup_Fees__c){
						decimal num311 = suPhAfter + setUpFlat;
						decimal num322 = num311 / suPhAfter;
						for(OpportunityLineItem oliSU2 : relatedOLIsSetUp){
							oliSU2.UnitPrice = (oliSU2.UnitPrice * num322).setScale(2);
						}
					}
				}
					update relatedOLIsSetUp;
			}
			
			if(trainFlat > 0){
				
				decimal numToAddTR = oppInfo.Total_Training__c + trainFlat;
				decimal percentToUseTR = numToAddTR / oppInfo.Total_Training__c;
				if(trDPCPH == 0.0){
					for(OpportunityLineItem oliTR : relatedOLIsTraining){
						
						oliTR.UnitPrice = (oliTR.UnitPrice * percentToUseTR).setScale(2);
					}
				}
				if(trDPCPH != 0.0){
					if(trph2 == oppInfo.Total_Training__c){
						decimal num41 = trph + trainFlat;
						decimal num42 = num41 / trph;
						for(OpportunityLineItem oliTR1 : relatedOLIsTraining){
							oliTR1.UnitPrice = (oliTR1.UnitPrice * num42).setScale(2);
						} 
					}
					if(trph2 != oppInfo.Total_Training__c){
						decimal num411 = trPhAfter + trainFlat;
						decimal num422 = num411 / trPhAfter;
						for(OpportunityLineItem oliT2 : relatedOLIsTraining){
							oliT2.UnitPrice = (oliT2.UnitPrice * num422).setScale(2);
						}
					}
				}
				update relatedOLIsTraining;
			}
		//}
		
	}

}