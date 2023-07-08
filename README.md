# Noir library by Wagmi Labs*

This is only a hub redirecting to the repos where we've implemented useful Noir functions that we're using in our apps:
1. Proof of Intersection
2. Proof of Proximity
3. Proof of Proper Secret

## Using the library

1. Add the library to your Noir project dependencies in the `Nargo.toml` file, e.g. for `proof_of_intersection`

```toml
[dependencies]
proof_of_intersection = {tag = "v1.0.0", git = "https://github.com/fruity-labs/proof-of-intersection"}
```

2. Import the library and function into your Noir code.

Example (taken from proof-of-intersection):
```rust
use dep::std;
use dep::proof_of_intersection;

fn main(){
    // ...
    let it_s_a_match = proof_of_intersection::private_set_intersection_is_not_empty(commitment_a, commitment_b, priv_set_a, priv_set_b, intersection_is_empty);
    std::println(it_s_a_match);
    // ...
}
```
## Thanks

Credit to [@critesjosh](https://github.com/critesjosh) for [the public Noir library demo](https://github.com/critesjosh/noir-lib-demo).
And cheers to [@signorecello](https://github.com/signorecello) for his guidance and review.

--

**(Wagmi Labs == [@madztheo](https://github.com/madztheo) & [@guelowrd](https://github.com/guelowrd), creators of [Fruity Friends](https://github.com/madztheo/zk-fruits-front-end))*