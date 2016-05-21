global class FOD_NewUserAggregationSchedule implements Schedulable{ 
  /*
   *  execute the Schedule batch 
   */
  global void execute(SchedulableContext sc) {
     FOD_NewUserAggregation tb = new FOD_NewUserAggregation() ;
     Database.executeBatch(tb);
  }
}