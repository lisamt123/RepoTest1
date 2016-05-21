public with sharing class Utility {
	  
		/*
	This method uses String.substring to return a new String that begins with the character at the specified zero-based startIndex and extends to the character at endIndex - 1.
	but it will handle cases of null inout and when 
	the input string is not long enough it will return till the end of the string 
	instead of throwing System.StringException: Ending position out of bounds.
	 */
	public static String substring(string inputstr, Integer startIndex, Integer endIndex){
		if(inputstr == null || inputstr.trim() ==''){
			return '';
		}
	

		if(endIndex > inputstr.length()){
			return inputstr.substring(startIndex);
		}
		else{
		 return inputstr.substring(startIndex,endIndex);  
		}	

	} 
	

	public static boolean throwExceptionError() {
		
		boolean exceptionError;
		
		if(Test.isRunningTest()){
			
			exceptionError = true;
			
		}
		
		return exceptionError;
	}
	
	//Project static flag to control recursive updates
	//////public static boolean isProjectUpdate;
	
	
	//isFutureUpdate boolean to prevent recursive loops
	public static boolean isFutureUpdate = false;
}