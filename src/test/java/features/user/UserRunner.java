package features.user;

import com.intuit.karate.junit5.Karate;

public class UserRunner {

    @Karate.Test
    Karate userTests() {
        return Karate.run("user").relativeTo(getClass());
    }

}
