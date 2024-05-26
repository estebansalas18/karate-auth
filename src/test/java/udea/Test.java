package udea;

import com.intuit.karate.junit5.Karate;

public class Test {

    @Karate.Test
    Karate test() {
        return Karate.run().relativeTo(getClass());
    }
}