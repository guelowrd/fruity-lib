# Noir library by @madztheo & @guelowrd (aka Fruity Friends, aka Wagmi Labs)

A public Noir library repo containing useful Noir functions we've implemented and we're using in our apps:
1. Proof of Intersection
2. Proof of Proximity (TBD)
3. Proof of Proper Secret (TBD)

## Using the library

1. Add the library to your Noir project dependencies in the `Nargo.toml` file.

```toml
[dependencies]
fruity_lib = {tag = "v0.1", git = "https://github.com/guelowrd/fruity-lib"}
```

2. Import the library and function into your Noir code.

```rust
use dep::std;
use dep::fruity_lib;

fn main(){
    // ...
    let it_s_a_match = fruity_lib::private_set_intersection_is_not_empty(commitment_a, commitment_b, priv_set_a, priv_set_b);
    std::println(it_s_a_match);
    // ...
}
```

Credit to @critesjosh for the public Noir library demo (https://github.com/critesjosh/noir-lib-demo).
