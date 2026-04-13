# Runner Class Template

Use this template when generating `<Domain>Runner.java` files.
Replace `<domain>` (lowercase) and `<Domain>` (PascalCase) with actual values.

---

```java
package examples.<domain>;

import com.intuit.karate.junit5.Karate;

class <Domain>Runner {

    @Karate.Test
    Karate <domain>Tests() {
        return Karate.run("<domain>").relativeTo(getClass());
    }

}
```

---

## Rules

- **Package** must match directory: `examples.<domain>`
- **Class name**: `<Domain>Runner` — PascalCase, suffix `Runner`
- **Method name**: `<domain>Tests` — camelCase, suffix `Tests`
- **No logic** in runner classes — pure wiring only (Single Responsibility)
- **No imports** beyond `com.intuit.karate.junit5.Karate`
- The string passed to `Karate.run("...")` must match the feature file name without extension
- `relativeTo(getClass())` resolves the path relative to the runner's package directory — do not change it
