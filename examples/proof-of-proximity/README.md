# Proof-of-proximity

## Check Euclidean Distance example

This mini-project illustrates how to import and use `check_points_proximity(commitment_a, commitment_b, private_point_a, private_point_b, distance_threshold)` from `fruity_lib` public Noir library.

## Run the proof generation & verification

```bash
cd examples/proof-of-proximity/
nargo prove close_enough
nargo verify close_enough
```

## Notes

If you use the function in your project, make sure the commitments and the distance threshold to check are public inputs (`commitment_a`, `commitment_b` and `distance_threshold`).