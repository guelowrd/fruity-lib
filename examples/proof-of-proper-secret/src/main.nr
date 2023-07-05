use dep::std;

global SECRET_INPUT_LENGTH = 12;
global ORDERED_HASHED_ASCII_CODES_DIGIT_CHARS = [
    0x01388b9a8a054cc2d19939ea0c8bca387d9089244d78fb5da96a8a961945ac08,
    0x034fc2eff5ea29664523402aec82d39bae64c8120c1f30dac99ff24a73eb8ab6,
    0x0b6b02147b74321d00aca053627f131e5be0dc4b13163f6d335a8071a0f95261,
    0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    0x161f58fa6bc3d4d844c272c4feab38804265785e63a6e2f3db48a240d460c2ca,
    0x1e526c4a192f3f6a79f85b4da6a98ba8ecc091bb486d1b45a3ff24ce3426c9b9,
    0x1e92895d716584f84ae344a3154f62113c6a369607f3efe91443618aaae67b9a,
    0x21141ff50ffa184999b70873c6d2e55573ca58d60245ac846fa96154989e5254,
    0x2c8fcca887aadbdd7f9c858c5cdab7764d3e8defaa2dbdd7b39401f25e8c64e9,
    0x2e3a3b844eb35871138aca89a1462913730a050531ad23baa66410f25e51765d
];

global ORDERED_ARRAY = [
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9
];

fn main(x: Field) {
    let mut has_digit: bool = false;
    for i in 0..9 {
        let compare_value = ORDERED_ARRAY[i];
        std::println(compare_value);
        let x_smaller_than_compare_value = x as u64 < compare_value as u64;
        std::println(x_smaller_than_compare_value);
        has_digit |= x_smaller_than_compare_value;
    }
    assert(has_digit);
}

fn main2(secret_input: [Field; SECRET_INPUT_LENGTH]) {
    let nb_digit_chars = ORDERED_HASHED_ASCII_CODES_DIGIT_CHARS.len();
    let nb_digit_chars_half = nb_digit_chars / 2;
    let mut has_digit: bool = false;
    let mut current_char: u64 = secret_input[0] as u64;
    let midway_char = ORDERED_HASHED_ASCII_CODES_DIGIT_CHARS[nb_digit_chars_half] as u64;
    for i in 0..SECRET_INPUT_LENGTH {
        current_char = secret_input[i] as u64;
        std::println(current_char);
        std::println(midway_char);
        let mut comparison_char: u64 = secret_input[0] as u64;
        if current_char < midway_char {
            assert(current_char < midway_char);
            for j in 0..nb_digit_chars_half {
                comparison_char = ORDERED_HASHED_ASCII_CODES_DIGIT_CHARS[j] as u64;
                if current_char == comparison_char {
                    has_digit = true;
                }
                std::println(j);
            }
        } 
        if current_char >= midway_char {
            assert(current_char >= midway_char);
            // std::println("Second half");
            for j in nb_digit_chars_half..nb_digit_chars {
                // comparison_char = ORDERED_HASHED_ASCII_CODES_DIGIT_CHARS[j] as u64;
                // std::println(comparison_char);
                // if current_char == comparison_char {
                    has_digit = true;
                // }
                std::println(j);
                assert(j > 0);
            }        
        }
    }
    assert(true);
}

#[test]
fn test_main() {
    // let x: [Field; SECRET_INPUT_LENGTH] = [
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e,
    //     0x2e3a3b844eb35871138aca89a1462913730a050531ad23baa66410f25e51765d
    // ];
    let y: Field = 7;
    main(y);
    // Uncomment to make test fail
    // main(1, 1);
}
