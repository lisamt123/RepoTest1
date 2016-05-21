/*Ref:http://stackoverflow.com/questions/10425925/how-to-parse-a-csv-in-salesforce*/
public class UtilityCSVParser {
public static list<list<String>> parse(String contents,Boolean skipHeaders) {
    list<list<String>> allFields = new List<List<String>>();

    // replace instances where a double quote begins a field containing a comma
    // in this case you get a double quote followed by a doubled double quote
    // do this for beginning and end of a field
    contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
    // now replace all remaining double quotes - we do this so that we can reconstruct
    // fields with commas inside assuming they begin and end with a double quote
    contents = contents.replaceAll('""','DBLQT');
    // we are not attempting to handle fields with a newline inside of them
    // so, split on newline to get the spreadsheet rows
    list<String> lines=new list<string>();
    try {
        lines = contents.split('\n');
    } catch (System.ListException e) {
        System.debug('Limits exceeded?  '+e.getMessage());
    }
    integer num=0;
    for(string line :lines) {
        // check for blank CSV lines (only commas)
        if(line.replaceAll(',','').trim().length()==0) 
            break;
        list<String> fields=line.split(',');    
        list<String> cleanFields=new list<String>();
        string compositeField;
        boolean makeCompositeField=false;
        for(string field : fields) {


            if(field.startsWith('"') && field.endsWith('"')) {
                cleanFields.add(field.replaceAll('DBLQT','"').removeStart('"').removeEnd('"'));
            } else if(field.startsWith('"')) {
                makeCompositeField = true;
                compositeField = field;
            } else if(field.endsWith('"')) { 
                compositeField += ',' + field;
                cleanFields.add(compositeField.replaceAll('DBLQT','"').removeStart('"').removeEnd('"'));
                makeCompositeField = false;
            } else if(makeCompositeField) {
                compositeField +=  ',' + field;
            } else{
                cleanFields.add(field.replaceAll('DBLQT','"').removeStart('"').removeEnd('"'));
            }
        }  
        allFields.add(cleanFields);
    }
    if(skipHeaders) 
        allFields.remove(0);
    return allFields;       
}//END Parse


}