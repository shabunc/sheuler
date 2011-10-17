
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
        System.out.print(val);
        System.out.println(step);
    }

    public String getSequence(int len) {
        String s = "";
        for (int i = 0; i < len; i++) {
           nextStep();
           s += step;
        }
        System.out.println(s);
        return s;
    }

    public static void main(String[] args) {
        runTests();
    }

    public static void runTests() {
        assert (new Problem277(231)).getSequence(10).equals("DdDddUUdDD");
    }

}
