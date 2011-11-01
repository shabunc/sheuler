import java.util.*;

class Test {
    public static void main(String[] args) {
        TreeMap<Long, Long> tm = new TreeMap<Long, Long>(); 
        tm.put(new Long(5), new Long(1));
        tm.put(new Long(2), new Long(1));
        tm.put(new Long(3), new Long(1));
        tm.put(new Long(7), new Long(1));
        tm.put(new Long(4), new Long(1));
        System.out.println(tm);
        while (true) {
            if (tm.firstEntry().getKey() <= 4) {
                tm.pollFirstEntry();
            } else {
                break;
            }
        }
        System.out.println(tm);
    }
}
