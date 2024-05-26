package udea.register;

import com.intuit.karate.junit5.Karate;

public class RegisterTest {

    @Karate.Test
    Karate registerTest() {
        return Karate.run().relativeTo(getClass());
    }
}