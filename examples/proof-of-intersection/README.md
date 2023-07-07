# Proof-of-intersection

## Check Private Set Intersection (PSI) example

This mini-project illustrates how to import and use `check_private_set_intersection(commitment_a, commitment_b, private_set_a, private_set_b, intersection_is_empty)` from `fruity_lib` public Noir library (`fruity_lib::proof_of_intersection` module).

## Run the proof generation & verification

```bash
cd examples/proof-of-intersection/
nargo prove it_s_a_match
nargo verify it_s_a_match
```

## Notes

If you use the function in your project, make sure the commitments and the emptyness to check are public inputs (`commitment_a`, `commitment_b` and `intersection_is_empty`).