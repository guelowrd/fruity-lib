use dep::std;
use dep::fruity_lib;

global MAX_ARRAY_SIZE_IN_FRUITY_LIB = 20;

fn main(
    // A pedersen hash of the first set of hashed elements serving as a public commitment to the first set.
    commitmentA: pub Field, 
    // A pedersen hash of the second set of hashed elements serving as a public commitment to the second set.
    commitmentB: pub Field, 
    // First set of hashed elements (can be any hash function).
    setA: [Field; MAX_ARRAY_SIZE_IN_FRUITY_LIB], 
    // Second set of hashed elements (can be any hash function).
    setB: [Field; MAX_ARRAY_SIZE_IN_FRUITY_LIB],
    // Specify if we're checking for the intersection to be empty or non-empty.
    isNotEmpty: pub bool
){
    // ...
    fruity_lib::check_private_set_intersection(commitmentA, commitmentB, setA, setB, !isNotEmpty);
    std::println("It's a match!");
    // ...
}