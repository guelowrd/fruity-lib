use dep::std;
use dep::fruity_lib;

global MAX_PASSWORD_SIZE_IN_FRUITY_LIB = 10;

fn main(
    // @param hashed_chars Input password represented as an array of hashed char (using Pedersen hash).
    hashed_chars: [Field; MAX_PASSWORD_SIZE_IN_FRUITY_LIB],
    // @param nb_char_types is the number of criteria that needs to be verified.
    // Proof-of-proper-secret verifies these criteria:
    // 1. at least one digit char,
    // 2. at least one letter char,
    // 3. at least one special char.
    nb_char_types: pub Field
){
    // ...
    fruity_lib::proof_of_proper_secret::check_secret_is_proper(hashed_chars, nb_char_types);
    std::println("Proper!");
    // ...
}
