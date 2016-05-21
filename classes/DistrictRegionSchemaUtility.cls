public without sharing class DistrictRegionSchemaUtility {
	public static Set<String> DistrictFieldSet { get { return getObjFieldSet('District__c'); } }
	public static Set<String> RegionFieldSet { get { return getObjFieldSet('Region__c'); } }
	public static Set<String> ZipCodeFieldSet { get { return getObjFieldSet('Zip_Postal_Code__c'); } }
	public static Set<String> StateProvinceFieldSet { get { return getObjFieldSet('Related_State_Province__c'); } }
	public static Set<String> OpportunityFieldSet { get { return getObjFieldSet('Opportunity'); } }

	private static Map<String, Set<String>> cloneObjMap { get {
		if(cloneObjMap == null) {
			initCloneObjMap();
		}

		return cloneObjMap;
	} private set; }

	private static Map<String, SObjectType> globalDesc { get {
		if(globalDesc == null) {
			globalDesc = Schema.getGlobalDescribe();
		}

		return globalDesc;
	} private set; }

	private static void initCloneObjMap() {
		Set<String> excludeApiNames = new Set<String>();
		excludeApiNames.add('Id');

		cloneObjMap = new Map<String, Set<String>> {
			'District__c' => new Set<String>(),
			'Region__c' => new Set<String>(),
			'Zip_Postal_Code__c' => new Set<String>(),
			'Related_State_Province__c' => new Set<String>(),
			'Opportunity' => new Set<String>()
		};

		for(String obj : cloneObjMap.keySet()) {
			Set<String> objFields = cloneObjMap.get(obj);
			Schema.DescribeSObjectResult descObj = globalDesc.get(obj).getDescribe();

			for(Schema.SObjectField objField : descObj.fields.getMap().values()) {
				Schema.DescribeFieldResult dfr = objField.getDescribe();

				if(!dfr.isCalculated() && !dfr.isUnique() && !excludeApiNames.contains(dfr.getName())) {
					objFields.add(dfr.getName());
				}
			}
		}
	}

	private static Set<String> getObjFieldSet(String objectName) {
		return cloneObjMap.get(objectName);
	}

	public static String generateQuery(String objName, String lookupFieldId, String setName) {
		return String.format('SELECT Id, {0} FROM {1} WHERE {2} IN :{3}', new List<String> { String.join(new List<String>(getObjFieldSet(objName)), ', '), objName, lookupFieldId, setName });
	}

	public static String generateQueryNull(String objName, String nullField) {
		return String.format('SELECT Id, {0} FROM {1} WHERE {2} = null', new List<String> { String.join(new List<String>(getObjFieldSet(objName)), ', '), objName, nullField });
	}

	public static String generateQueryCompare(String objName, String compField, String compValue) {
		return String.format('SELECT Id, {0} FROM {1} WHERE {2} = {3}', new List<String> { String.join(new List<String>(getObjFieldSet(objName)), ', '), objName, compField, compValue });
	}
}