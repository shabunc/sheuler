
class Problem277 {

    enum Step {
        U, D, d
    }

    private Step step;
    private long val;

    public Problem277(long val) {
        this.val = val;
    }

    public void nextStep() {
        long rem = val % 3;
        if (rem == 0) {
            val = val / 3;
            step = step.D;
        } else
        if (rem == 1) {
            val = (4 * val + 2) / 3;
            step = step.U;
        } else {
            val = (2 * val - 1) / 3;
            step = step.d;
        }
    }

    public String getSequence(int len) {
        String s = "";
        for (int i = 0; i < len; i++) {
           nextStep();
           s += step;
        }
        return s;
    }

    public static void main(String[] args) {
        runAsserts();
        findFirst("UDDDUdddDDUDDddDdDddDDUDDdUUDd");
    }

    public static void runAsserts() {
        assert (new Problem277(231)).getSequence(10).equals("DdDddUUdDD");
    }

    public static void findFirst(String checkSequence) {
        long i = 1057347015759427L;
        int step = 0;
        do {
            Problem277 p = new Problem277(i);
            System.out.printf("%d %s \n", i, p.getSequence(30));
            if (step > 100) {
                break;
            }
            /*
            if (p.getSequence(checkSequence.length()).equals(checkSequence)) {
                break;
            }
            */
            i = i + 68630377364883L;
            step++;
        } while (true);
    }

}
