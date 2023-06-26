use dep::std;

global MAX_ARRAY_SIZE: Field = 20;

fn check_commitment(commitment: Field, set: [Field; MAX_ARRAY_SIZE]) {
    let computed_commitment = std::hash::pedersen(set);
    assert(commitment == computed_commitment[0]);
}

fn get_intersection_cardinality(private_set_a : [Field; MAX_ARRAY_SIZE], private_set_b : [Field; MAX_ARRAY_SIZE]) -> Field {
    let mut cardinality: Field = 0;
    for i in 0..MAX_ARRAY_SIZE {
        for j in 0..MAX_ARRAY_SIZE {
            // We only need to check that private_set_a[i] != 0, as if this condition holds
            // then private_set_a[i] == private_set_b[j] implies that private_set_b[j] != 0.
            if (private_set_a[i] != 0) & (private_set_a[i] as u64 == private_set_b[j] as u64) {
                cardinality += 1;
            }
        }
    }
    cardinality
}

fn private_set_intersection_is_not_empty(
    // A pedersen hash of the first set of hashed elements
    // serving as a public commitment to the first set
    commitment_a: pub Field, 
    // A pedersen hash of the second set of hashed elements
    // serving as a public commitment to the second set
    commitment_b: pub Field, 
    // First set of hashed elements (can be any hash function)
    private_set_a : [Field; MAX_ARRAY_SIZE], 
    // Second set of hashed elements (can be any hash function)
    private_set_b : [Field; MAX_ARRAY_SIZE]
) {
    // Check that the commitments are valid
    check_commitment(commitment_a, private_set_a);
    check_commitment(commitment_b, private_set_b);
    // Retrieve the cardinality of the intersection, if there is any
    let cardinality = get_intersection_cardinality(private_set_a, private_set_b);
    // Make sure the proof will only succeed if the intersection is non-empty
    assert(cardinality != 0);
}