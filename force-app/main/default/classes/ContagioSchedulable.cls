global class ContagioSchedulable implements Schedulable{

    global void execute(SchedulableContext SC){
        System.Database.executeBatch(new ContagiarBatchable(), 100);
    }
    
}