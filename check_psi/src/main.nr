use dep::std;
use dep::fruity_lib;

fn main(
    // A pedersen hash of the first set of hashed elements
    // serving as a public commitment to the first set
    commitmentA: pub Field, 
    // A pedersen hash of the second set of hashed elements
    // serving as a public commitment to the second set
    commitmentB: pub Field, 
    // First set of hashed elements (can be any hash function)
    setA: [Field; 20], 
    // Second set of hashed elements (can be any hash function)
    setB: [Field; 20]    
){
    // ...
    fruity_lib::private_set_intersection_is_not_empty(commitmentA, commitmentB, setA, setB);
    std::println("It's a match!");
    // ...
}