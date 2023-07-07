# Noir library by Wagmi Labs*

A public Noir library repo containing useful Noir functions we've implemented and we're using in our apps:
1. Proof of Intersection
2. Proof of Proximity
3. Proof of Proper Secret

## Examples

1. An example of how to use the Proof of Intersection function `fruity_lib::proof_of_intersection::check_private_set_intersection` is available in `examples/proof-of-intersection/`.
2. An example of how to use the Proof of Proximity function `fruity_lib::proof_of_proximity::check_points_proximity` is available in `examples/proof-of-proximity/`.
3. An example of how to use the Proof of Proper Secret function `fruity_lib::proof_of_proper_secret::check_secret_is_proper` is available in `examples/proof-of-proper_secret/`.

## Using the library

1. Add the library to your Noir project dependencies in the `Nargo.toml` file.

```toml
[dependencies]
fruity_lib = {tag = "v1.2.2", git = "https://github.com/guelowrd/fruity-lib"}
```

2. Import the library and function into your Noir code.

Example (taken from proof-of-intersection):
```rust
use dep::std;
use dep::fruity_lib;

fn main(){
    // ...
    let it_s_a_match = fruity_lib::private_set_intersection_is_not_empty(commitment_a, commitment_b, priv_set_a, priv_set_b, intersection_is_empty);
    std::println(it_s_a_match);
    // ...
}
```
## Thanks

Credit to [@critesjosh](https://github.com/critesjosh) for [the public Noir library demo](https://github.com/critesjosh/noir-lib-demo).
And cheers to [@signorecello](https://github.com/signorecello) for his guidance and review.

--

**(Wagmi Labs == [@madztheo](https://github.com/madztheo) & [@guelowrd](https://github.com/guelowrd), creators of [Fruity Friends](https://github.com/madztheo/zk-fruits-front-end))*