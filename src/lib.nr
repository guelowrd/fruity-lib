use dep::std;

unconstrained
fn coordinates_to_u64_array(
    array_x: [u8; 32],
    array_y: [u8; 32],
) -> [u64; 16] {
    let mut combined_u64: [u64; 16] = [0; 16];
    
    for i in 0..4 {
        let mut value: u64 = 0;
        for j in 0..8 {
            value |= (array_x[i*8+j] as u64) << ((56 - j*8) as u64);
        }
         combined_u64[i] = value;
    }
    for i in 4..8 {
        let mut value: u64 = 0;
        for j in 0..8 {
            value |= (array_y[(i-4)*8+j] as u64) << ((56 - j*8) as u64);
        }
         combined_u64[i] = value;
    }

    combined_u64
}

#[test]
fn test_coordinates_to_u64_array() {
    let pub_key_x: [u8; 32] = [
        131,24,83,91,84,16,93,74,122,174,96,192,143,196,95,150,135,24,27,79,223,198,37,189,26,117,63,167,57,127,237,117
    ];
    let pub_key_y: [u8; 32] = [
        53,71,241,28,168,105,102,70,242,243,172,176,142,49,1,106,250,194,62,99,12,93,17,245,159,97,254,245,123,13,42,165
    ];
    let pub_key = coordinates_to_u64_array(pub_key_x, pub_key_y);

    assert(pub_key[0] == 9446391870127103306);
    assert(pub_key[1] == 8840109498736861078);
    assert(pub_key[2] == 9734560624431998397);
    assert(pub_key[3] == 1906500004718046581);
    assert(pub_key[4] == 3839302312743495238);
    assert(pub_key[5] == 17506526050819047786);
    assert(pub_key[6] == 18069073250093961717);
    assert(pub_key[7] == 11484740855056378533);
    assert(pub_key[8] == 0);
    assert(pub_key[9] == 0);
    assert(pub_key[10] == 0);
    assert(pub_key[11] == 0);
    assert(pub_key[12] == 0);
    assert(pub_key[13] == 0);
    assert(pub_key[14] == 0);
    assert(pub_key[15] == 0);
    // the above output is the hex "0x8318535b54105d4a7aae60c08fc45f9687181b4fdfc625bd1a753fa7397fed753547f11ca8696646f2f3acb08e31016afac23e630c5d11f59f61fef57b0d2aa5"
    // which is the correct public key for the x + y coordinate
}