@isTest
private class UtilityCSVParser_Test {
	
static testMethod void testParseCSV(){
    string contents='Field1,Field2,Field3\n1,,Smith\n2,Fred,O\'Connor\n3,Destiny,"Awaits, DDS"\n\n';
    list<list<string>> parsedCSV=UtilityCSVParser.parse(contents,true);
    //line 1
    system.assertEquals('1',parsedCSV[0][0]);
    system.assertEquals('',parsedCSV[0][1]);
    system.assertEquals('Smith',parsedCSV[0][2]);
    //line 2
    system.assertEquals('2',parsedCSV[1][0]);
    system.assertEquals('Fred',parsedCSV[1][1]);
    system.assertEquals('O\'Connor',parsedCSV[1][2]);
    //line 3
    system.assertEquals('3',parsedCSV[2][0]);
    system.assertEquals('Destiny',parsedCSV[2][1]);
    system.assertEquals('Awaits, DDS',parsedCSV[2][2]);
}//END
}