import java.util.*;

class Compute100 {
    public static void main(String[] args) {
        long max = 1000000000000L;
        TreeMap<Long, Long> found = new TreeMap<Long, Long>();
        long j = 1;
        while (true) {
            long sq = j * j;
            long a  = (j + 1) / 2;
            if ((sq - 1) % 4 == 0) {
                long k = (sq - 1) / 4;
                found.put(k, a);
                if (found.containsKey(k / 2)) {
                    while (true) {
                        Map.Entry<Long, Long> firstEntry = found.firstEntry();
                        if (firstEntry.getKey() == (k / 2)) {
                            break;
                        } else {
                            found.pollFirstEntry();
                        }
                    }
                    System.out.println(a);
                    if (a > max) {
                        break;
                    }
                }
            }
            j++;
        }
    }
}
