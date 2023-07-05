use dep::std;
use dep::fruity_lib;

global MAX_PASSWORD_SIZE_IN_FRUITY_LIB = 20;

fn main(
    // @param password_as_hashed_chars_array Input password represented as an array of hashed char (using Pedersen hash).
    password_as_hashed_chars_array: [Field; MAX_PASSWORD_SIZE_IN_FRUITY_LIB], 
    // @param nb_of_criteria is the number of criteria that needs to be verified.
    // Proof-of-proper-secret verifies these criteria:
    // 1. at least one digit char,
    // 2. at least one lowercase char,
    // 3. at least one uppercase char,
    // 4. at least one special char.
    isNotEmpty: pub Field
){
    // ...
    fruity_lib::proof_of_intersection::check_private_set_intersection(commitmentA, commitmentB, setA, setB, !isNotEmpty);
    std::println("It's a match!");
    // ...
}