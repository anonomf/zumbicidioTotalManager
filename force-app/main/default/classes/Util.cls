public with sharing class Util {
    
    public Util() {}

    public static sObject GetRamdomItem(List<SObject> lst){
        return lst.get(Math.mod(Integer.valueOf(Math.random()*1000000000),lst.size()));
    }

}
