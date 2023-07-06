use dep::std;

///////////////////////////////////////
// 1. Proper Secret String Functions //
///////////////////////////////////////

global SECRET_INPUT_LENGTH = 20;
global DIGIT_CHARS_ASCII_CODES_HASHED = [ // 0 to 9
    0x1e526c4a192f3f6a79f85b4da6a98ba8ecc091bb486d1b45a3ff24ce3426c9b9,
    0x0b6b02147b74321d00aca053627f131e5be0dc4b13163f6d335a8071a0f95261,
    0x01388b9a8a054cc2d19939ea0c8bca387d9089244d78fb5da96a8a961945ac08,
    0x034fc2eff5ea29664523402aec82d39bae64c8120c1f30dac99ff24a73eb8ab6,
    0x21141ff50ffa184999b70873c6d2e55573ca58d60245ac846fa96154989e5254,
    0x161f58fa6bc3d4d844c272c4feab38804265785e63a6e2f3db48a240d460c2ca,
    0x2c8fcca887aadbdd7f9c858c5cdab7764d3e8defaa2dbdd7b39401f25e8c64e9,
    0x1e92895d716584f84ae344a3154f62113c6a369607f3efe91443618aaae67b9a,
    0x2e3a3b844eb35871138aca89a1462913730a050531ad23baa66410f25e51765d,
    0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e
];
global LOWERCASE_CHARS_ASCII_CODES_HASHED = [ // a to z
    0x2bc4bb39989fedfe614e3ecb1459abf29c1a7c0d5f1a6198ca666a7681127a2e,
    0x194c151fb80ae36f8738a1f1480eef6d2edd6a8d3b4ec50c7247cad56f911894,
    0x2d4829f45093c93d319654f920e83f28ea332ef2dbbda4bf4fe1a957f83cef0c,
    0x14ec7c744f563a9b337121af1d454700c52b9008b4c522fe7c10bbb4229a2eaa,
    0x2ced7a1e5259f39113165179820c949a6c1dddbd5ab404e4f876e1b94e0c686a,
    0x12e24f5fb500abf3c28a03ed9fb1b67f76cf8083b667cc30dbe6f5f7e72ef3f8,
    0x26f66747c6956c29dfc148242d798aadf479493159518df4b418480f84cea098,
    0x2968e5a12a58ade28b323d4f27bc1c1ac32843c18780fcfc2206875744daf842,
    0x1331051e6aeedf737c007b0f5341ee9b1ad3db59b5e585289c99b1f3ad65fc23,
    0x08ce0afc676a95ad5bae834b7e87bae9db763dcf09d675513bfe77d3dbd597fe,
    0x01d04f011534ee3bd11724f77bc6bc439785493c3ba30294ccb920185da2a9c9,
    0x058f3680b7e4899e5167e9b5bd22e94e820e0eb93decf64f8a11683c130a2284,
    0x0fcb6a656820bac4724f84cb1dd6c77a86c0a67e66540d2d3d0c66327a81728a,
    0x02729cbddd4ec32f79556df47ee2f6ef5fb341fb98823872450fda675a06d81c,
    0x0c961db6c8d4454cef7c0f1ba8d07169eb512a9806066132325e701ff8f6fe22,
    0x201a8ea4e78ecc2e6f5c55b1a3e9e430db82c8fc6cbf46af4674d3c956437ef8,
    0x2cd078c0879ecda31e2267bd9ae5ff086c10ae1cc1a75120a5519685f4dfaddf,
    0x072e3e9c8cc55501d578de583573bf146f8bc54938c7a811ea053001a2210523,
    0x2ac4e33de9876873c93bc790c1b3ed01800ea98459dc786d921df830755eee1e,
    0x1be43ae9ae5f0b01a507385db6f27e33e1cf5134ec652254362a5d34e56c09a5,
    0x2610f7adaf1126426670b6849d593889024ce9749f7edf747b8c44af0022a545,
    0x063841d8f34cac19fd660c9e470744b301c3dd193dec844672a67cd6a861bb94,
    0x27b92c81069a4b05563667e882ad508c99b5c6e1ae1701afe207df4ef65f5fb9,
    0x2ae5fa247a03778d66f20d927c12f565ec886a809aacfc5ebc75ac7e7c899380,
    0x29bb1950faffed939e244e9eb11f20cfeeef657f2a62aaebccccb9369edb53b7,
    0x2a902a1f449d7349ee0ea36e260d19a1a63fbe9ae3e5d7524540189de9eaf9cd
];
global UPPERCASE_CHARS_ASCII_CODES_HASHED = [ // A to Z
    0x03cf9f0c8f51a1fd00f1a95b56620013eaa81a772152d5c44367037a902b96fe,
    0x0b569b3ad90b372b5975ed9dfadd657df487df7bcf3927457c743d8d016580f1,
    0x0294130836e25f4fa29e92d5681128f03d7b618619c5c3b65c6352520158aa02,
    0x2dc05a51251bb7788e5341fa86bc8651a48d6825025efc4077b154aad9250a2b,
    0x259bee2922e2fb130b6f330f3ebad5942c48ec7f7b1ad1f9ed6e8237ffed6e11,
    0x07b63faa42d0459307d7ad443cb771dab0cf05465ecd78b0a0d45116dd6d4ab2,
    0x2837a56430f12cf92151a20b0eeceb76ac6f1e26957ff74ca332c1bfc4275346,
    0x0ffb5b1c4c8839581df648f1d2cd0ebd87558a1e87a456451947a3b7da3c6682,
    0x0e23ab9f4d077373f5dd1e06e65a42ae23c0d9856126bc131a091fa2e0bd0e1c,
    0x1b0c7375409814419ae60c38429d19f9c93c8fbe6c593fa0e198f60cc9036de8,
    0x08adc0b02cc7b9ab92d629c4dda5d8ba30c376cc2a87233c62274e823f2acc3b,
    0x2704b66967d654eb68c7117614ea88aaad85d17f568b09ba61246a9b9037472a,
    0x17454755bdb5d792b85d50f439bacea14f72154a2708c3193131397bc35b6f9f,
    0x279db9a32e26805bbb3311f6eaef91ee480a9979c018e813b13619d06e58f083,
    0x2eefaed7c719fc9bc9883ca01d6594e115b393888f34eeb899dc5c093c97a719,
    0x1f9b45a92bee2dd761aa1484cbc3304ebcb147549200a0666273220a4acecfa1,
    0x077b1605f30c4a8537077aaae6769f06f6c422416383533dbd551d79024dd466,
    0x21a736176abf6f07f1f42834c3871b2d669ed4fa0f698d04c7c2d9861986985c,
    0x2ba8e6d088d6e33d925299c2c302fa5d302ed02ca71937a0d74bac8c40950b62,
    0x1e7705c06afd8c1572e5e92a642210c123c3f5985d7c72cdb1205bd074827783,
    0x12f3599cd2c7382c011484b8c3a20e2b6c37f348e8cfdeae6cdbd1885e34ad93,
    0x22ee9132c55d09fc7242206a405786885626aeda5f71380d08baae5621421b6e,
    0x2961ba09ac4f854022ed58507589f4367b35871df2a2765d1bee5aded5e32b59,
    0x1dfa6b4beb4197e649d47781456011225947205c931a1ff1a3f7560b302f542e,
    0x2589dd87071b0706f33ccd80362dec65b042c4e347c733e73090334b9379a5e8,
    0x1a3b00bd79bad5789ae13e4f11ca04709c685e94788f2c258e6411c8201d0186
];
global SPECIAL_CHARS_ASCII_CODES_HASHED = [
    0x2e7dcbacf2426508fc4c4b1b500f2676ad62786e60efda3f7625a59942d63462, // ! exclamation point
    0x253dc95d528415ea2b5fa563891bf3af151bc2576d1bda92f57047575fb86874, // " double quotation
    0x0c2736e13943f63f7beb807d74c91a1222dec5ffb838ecc7af0ddac3caa457e9, // # number sign
    0x0fdd54583bf8da2f749377596e9eed2cf568fa531d92f551ad89eb260dc487fc, // $ dollar sign
    0x0760b10d73744f16f0a6d75a3f0fdc66cbeb61a246a0bc57ae1d707a51886b55, // % percent sign
    0x2b017aa7336dbf5baf8c89dbc97d0b2e3aa6f8dfb3060bb43fc43fad76e3724f, // & ampersand
    0x06fe743a9ae60c0c03580290454c3430053593dade85079fcaaba849b665f23c, // ' apostrophe
    0x0f19511e08bdc67e836ea5f97bb62e8ef211e6863146186fcad60c15c381746b, // ( left parenthesis
    0x18d6b36e94703934c18717f4790f41942145428a534a6daf20d388035bb23783, // ) right parenthesis
    0x2ea04e8a0a7c98b9d3b3dbacc996e1fa8b4fdf586c47c520398884ab40abfd06, // * asterisk
    0x1ce890aa699febc9ba3ef141a9e21bde2deb3a64b718d4004c0b14fbb0371ac4, // + plus sign
    0x0c4e2594686c04a1001271333281216ecc47ac2cd9eaf961f7df27405d56f862, // , comma
    0x1c2f9414c1b92350e991386120ef878337e3d8ef0017ad13674aba6e54d6f7b6, // - hyphen
    0x26f625bda3011f6567bd609205d83e5799c9e6fec9dcdc851672fba25a74c3da, // . period
    0x2d2a4e91cd6c25e271f79c757bcd8625198117465fb74c55d4f89b19dceb70ce, // / slash
    0x16d5a5f3079e061ae70adb659252fc7b7966703e5815765c6b1b89ea36092ef7, // : colon
    0x23e9c0686bb475ed3da655407ecf1bae3d30bfe62884d7daaf6db4442cbb3fdb, // ; semicolon
    0x03331a6c6a82d7d4d9ed03bae70d39991dacc3cd93742c6750db416d31d49bb9, // < less-than sign
    0x0e1bf9b4b0246929f34ec1d9e56b51d81428265242c07694db854e0d0563bb, // = equals sign
    0x1d6c2e9e7876edebc7bc3bf5e747dae2cac944d13161828e9f65318b0bf90bb6, // > greater-than sign
    0x233ed04f3e71393a8b6fb3376887594247629fb429b82edea3b7a021a4fd752c, // ? question mark
    0x19783b19011ac44704cc3b89d48689989d6a8dc7981ff95b52b26885a0bbec61, // @ at sign
    0x0d09f418d703713cdbdb76f728bb05c804c355da9ea97437de2a08fbb4614c95, // [ left square bracket
    0x0f01937baf69cee1bfc6d0fda869ddc154b8ab0fbf5c449fcd4f5b2f563234c5, // \ backslash
    0x01e348e3ce89157685899df34a7b5e6ec8893e73d6b3d015fd0ab1a653b446bd, // ] right square bracket
    0x02fbbdfdd67fd053da748f69235e00cb779b56cec4abc46eef1aeaa5047bc6c3, // ^ caret
    0x06259a629d9eda880218afbdff67600e907144901aab7e6735b80bd8969cecad, // _ underscore
    0x15209746cea10e1113f1de0b8c66f1d573f68eaf4365dc674e5fbb58692e836f, // ` grave accent
    0x11fef81a0260cd6e7df99bc73b229ef3721b00d13896312a7d9fe3eebc7a96a5, // { left curly brace
    0x09bfbd4baddb71f67d791a652163f5692659e4f588f12f48030799b9b5090b57, // | vertical bar
    0x23caca35a8635bda4f9c5d595650cde82a667ac26832dfeb86154a45041dc6ce, // } right curly brace
    0x2c4c41588a752611fcdafa8762309149af9cb49fd71a7eec360f5332a7c0df2f  // ~ tilde
];
global ACCEPTED_CHARS_ASCII_CODES_HASHED = [
    0x2e7dcbacf2426508fc4c4b1b500f2676ad62786e60efda3f7625a59942d63462, // ! exclamation point
    0x253dc95d528415ea2b5fa563891bf3af151bc2576d1bda92f57047575fb86874, // " double quotation
    0x0c2736e13943f63f7beb807d74c91a1222dec5ffb838ecc7af0ddac3caa457e9, // # number sign
    0x0fdd54583bf8da2f749377596e9eed2cf568fa531d92f551ad89eb260dc487fc, // $ dollar sign
    0x0760b10d73744f16f0a6d75a3f0fdc66cbeb61a246a0bc57ae1d707a51886b55, // % percent sign
    0x2b017aa7336dbf5baf8c89dbc97d0b2e3aa6f8dfb3060bb43fc43fad76e3724f, // & ampersand
    0x06fe743a9ae60c0c03580290454c3430053593dade85079fcaaba849b665f23c, // ' apostrophe
    0x0f19511e08bdc67e836ea5f97bb62e8ef211e6863146186fcad60c15c381746b, // ( left parenthesis
    0x18d6b36e94703934c18717f4790f41942145428a534a6daf20d388035bb23783, // ) right parenthesis
    0x2ea04e8a0a7c98b9d3b3dbacc996e1fa8b4fdf586c47c520398884ab40abfd06, // * asterisk
    0x1ce890aa699febc9ba3ef141a9e21bde2deb3a64b718d4004c0b14fbb0371ac4, // + plus sign
    0x0c4e2594686c04a1001271333281216ecc47ac2cd9eaf961f7df27405d56f862, // , comma
    0x1c2f9414c1b92350e991386120ef878337e3d8ef0017ad13674aba6e54d6f7b6, // - hyphen
    0x26f625bda3011f6567bd609205d83e5799c9e6fec9dcdc851672fba25a74c3da, // . period
    0x2d2a4e91cd6c25e271f79c757bcd8625198117465fb74c55d4f89b19dceb70ce, // / slash
    0x1e526c4a192f3f6a79f85b4da6a98ba8ecc091bb486d1b45a3ff24ce3426c9b9, // 0
    0x0b6b02147b74321d00aca053627f131e5be0dc4b13163f6d335a8071a0f95261, // 1
    0x01388b9a8a054cc2d19939ea0c8bca387d9089244d78fb5da96a8a961945ac08, // 2
    0x034fc2eff5ea29664523402aec82d39bae64c8120c1f30dac99ff24a73eb8ab6, // 3
    0x21141ff50ffa184999b70873c6d2e55573ca58d60245ac846fa96154989e5254, // 4
    0x161f58fa6bc3d4d844c272c4feab38804265785e63a6e2f3db48a240d460c2ca, // 5
    0x2c8fcca887aadbdd7f9c858c5cdab7764d3e8defaa2dbdd7b39401f25e8c64e9, // 6
    0x1e92895d716584f84ae344a3154f62113c6a369607f3efe91443618aaae67b9a, // 7
    0x2e3a3b844eb35871138aca89a1462913730a050531ad23baa66410f25e51765d, // 8
    0x0b6d6f69b140cf67a585978ac44100fd7ee62bbacfd2c32c02661858af059c8e, // 9
    0x16d5a5f3079e061ae70adb659252fc7b7966703e5815765c6b1b89ea36092ef7, // : colon
    0x23e9c0686bb475ed3da655407ecf1bae3d30bfe62884d7daaf6db4442cbb3fdb, // ; semicolon
    0x03331a6c6a82d7d4d9ed03bae70d39991dacc3cd93742c6750db416d31d49bb9, // < less-than sign
    0x0e1bf9b4b0246929f34ec1d9e56b51d81428265242c07694db854e0d0563bb, // = equals sign
    0x1d6c2e9e7876edebc7bc3bf5e747dae2cac944d13161828e9f65318b0bf90bb6, // > greater-than sign
    0x233ed04f3e71393a8b6fb3376887594247629fb429b82edea3b7a021a4fd752c, // ? question mark
    0x19783b19011ac44704cc3b89d48689989d6a8dc7981ff95b52b26885a0bbec61, // @ at sign
    0x03cf9f0c8f51a1fd00f1a95b56620013eaa81a772152d5c44367037a902b96fe, // A uppercase a
    0x0b569b3ad90b372b5975ed9dfadd657df487df7bcf3927457c743d8d016580f1, // B uppercase b
    0x0294130836e25f4fa29e92d5681128f03d7b618619c5c3b65c6352520158aa02, // C uppercase c
    0x2dc05a51251bb7788e5341fa86bc8651a48d6825025efc4077b154aad9250a2b, // D uppercase d
    0x259bee2922e2fb130b6f330f3ebad5942c48ec7f7b1ad1f9ed6e8237ffed6e11, // E uppercase e
    0x07b63faa42d0459307d7ad443cb771dab0cf05465ecd78b0a0d45116dd6d4ab2, // F uppercase f
    0x2837a56430f12cf92151a20b0eeceb76ac6f1e26957ff74ca332c1bfc4275346, // G uppercase g
    0x0ffb5b1c4c8839581df648f1d2cd0ebd87558a1e87a456451947a3b7da3c6682, // H uppercase h
    0x0e23ab9f4d077373f5dd1e06e65a42ae23c0d9856126bc131a091fa2e0bd0e1c, // I uppercase i
    0x1b0c7375409814419ae60c38429d19f9c93c8fbe6c593fa0e198f60cc9036de8, // J uppercase j
    0x08adc0b02cc7b9ab92d629c4dda5d8ba30c376cc2a87233c62274e823f2acc3b, // K uppercase k
    0x2704b66967d654eb68c7117614ea88aaad85d17f568b09ba61246a9b9037472a, // L uppercase l
    0x17454755bdb5d792b85d50f439bacea14f72154a2708c3193131397bc35b6f9f, // M uppercase m
    0x279db9a32e26805bbb3311f6eaef91ee480a9979c018e813b13619d06e58f083, // N uppercase n
    0x2eefaed7c719fc9bc9883ca01d6594e115b393888f34eeb899dc5c093c97a719, // O uppercase o
    0x1f9b45a92bee2dd761aa1484cbc3304ebcb147549200a0666273220a4acecfa1, // P uppercase p
    0x077b1605f30c4a8537077aaae6769f06f6c422416383533dbd551d79024dd466, // Q uppercase q
    0x21a736176abf6f07f1f42834c3871b2d669ed4fa0f698d04c7c2d9861986985c, // R uppercase r
    0x2ba8e6d088d6e33d925299c2c302fa5d302ed02ca71937a0d74bac8c40950b62, // S uppercase s
    0x1e7705c06afd8c1572e5e92a642210c123c3f5985d7c72cdb1205bd074827783, // T uppercase t
    0x12f3599cd2c7382c011484b8c3a20e2b6c37f348e8cfdeae6cdbd1885e34ad93, // U uppercase u
    0x22ee9132c55d09fc7242206a405786885626aeda5f71380d08baae5621421b6e, // V uppercase v
    0x2961ba09ac4f854022ed58507589f4367b35871df2a2765d1bee5aded5e32b59, // W uppercase w
    0x1dfa6b4beb4197e649d47781456011225947205c931a1ff1a3f7560b302f542e, // X uppercase x
    0x2589dd87071b0706f33ccd80362dec65b042c4e347c733e73090334b9379a5e8, // Y uppercase y
    0x1a3b00bd79bad5789ae13e4f11ca04709c685e94788f2c258e6411c8201d0186, // Z uppercase z
    0x0d09f418d703713cdbdb76f728bb05c804c355da9ea97437de2a08fbb4614c95, // [ left square bracket
    0x0f01937baf69cee1bfc6d0fda869ddc154b8ab0fbf5c449fcd4f5b2f563234c5, // \ backslash
    0x01e348e3ce89157685899df34a7b5e6ec8893e73d6b3d015fd0ab1a653b446bd, // ] right square bracket
    0x02fbbdfdd67fd053da748f69235e00cb779b56cec4abc46eef1aeaa5047bc6c3, // ^ caret
    0x06259a629d9eda880218afbdff67600e907144901aab7e6735b80bd8969cecad, // _ underscore
    0x15209746cea10e1113f1de0b8c66f1d573f68eaf4365dc674e5fbb58692e836f, // ` grave accent
    0x2bc4bb39989fedfe614e3ecb1459abf29c1a7c0d5f1a6198ca666a7681127a2e, // a lowercase a
    0x194c151fb80ae36f8738a1f1480eef6d2edd6a8d3b4ec50c7247cad56f911894, // b lowercase b
    0x2d4829f45093c93d319654f920e83f28ea332ef2dbbda4bf4fe1a957f83cef0c, // c lowercase c
    0x14ec7c744f563a9b337121af1d454700c52b9008b4c522fe7c10bbb4229a2eaa, // d lowercase d
    0x2ced7a1e5259f39113165179820c949a6c1dddbd5ab404e4f876e1b94e0c686a, // e lowercase e
    0x12e24f5fb500abf3c28a03ed9fb1b67f76cf8083b667cc30dbe6f5f7e72ef3f8, // f lowercase f
    0x26f66747c6956c29dfc148242d798aadf479493159518df4b418480f84cea098, // g lowercase g
    0x2968e5a12a58ade28b323d4f27bc1c1ac32843c18780fcfc2206875744daf842, // h lowercase h
    0x1331051e6aeedf737c007b0f5341ee9b1ad3db59b5e585289c99b1f3ad65fc23, // i lowercase i
    0x08ce0afc676a95ad5bae834b7e87bae9db763dcf09d675513bfe77d3dbd597fe, // j lowercase j
    0x01d04f011534ee3bd11724f77bc6bc439785493c3ba30294ccb920185da2a9c9, // k lowercase k
    0x058f3680b7e4899e5167e9b5bd22e94e820e0eb93decf64f8a11683c130a2284, // l lowercase l
    0x0fcb6a656820bac4724f84cb1dd6c77a86c0a67e66540d2d3d0c66327a81728a, // m lowercase m
    0x02729cbddd4ec32f79556df47ee2f6ef5fb341fb98823872450fda675a06d81c, // n lowercase n
    0x0c961db6c8d4454cef7c0f1ba8d07169eb512a9806066132325e701ff8f6fe22, // o lowercase o
    0x201a8ea4e78ecc2e6f5c55b1a3e9e430db82c8fc6cbf46af4674d3c956437ef8, // p lowercase p
    0x2cd078c0879ecda31e2267bd9ae5ff086c10ae1cc1a75120a5519685f4dfaddf, // q lowercase q
    0x072e3e9c8cc55501d578de583573bf146f8bc54938c7a811ea053001a2210523, // r lowercase r
    0x2ac4e33de9876873c93bc790c1b3ed01800ea98459dc786d921df830755eee1e, // s lowercase s
    0x1be43ae9ae5f0b01a507385db6f27e33e1cf5134ec652254362a5d34e56c09a5, // t lowercase t
    0x2610f7adaf1126426670b6849d593889024ce9749f7edf747b8c44af0022a545, // u lowercase u
    0x063841d8f34cac19fd660c9e470744b301c3dd193dec844672a67cd6a861bb94, // v lowercase v
    0x27b92c81069a4b05563667e882ad508c99b5c6e1ae1701afe207df4ef65f5fb9, // w lowercase w
    0x2ae5fa247a03778d66f20d927c12f565ec886a809aacfc5ebc75ac7e7c899380, // x lowercase x
    0x29bb1950faffed939e244e9eb11f20cfeeef657f2a62aaebccccb9369edb53b7, // y lowercase y
    0x2a902a1f449d7349ee0ea36e260d19a1a63fbe9ae3e5d7524540189de9eaf9cd, // z lowercase z
    0x11fef81a0260cd6e7df99bc73b229ef3721b00d13896312a7d9fe3eebc7a96a5, // { left curly brace
    0x09bfbd4baddb71f67d791a652163f5692659e4f588f12f48030799b9b5090b57, // | vertical bar
    0x23caca35a8635bda4f9c5d595650cde82a667ac26832dfeb86154a45041dc6ce, // } right curly brace
    0x2c4c41588a752611fcdafa8762309149af9cb49fd71a7eec360f5332a7c0df2f  // ~ tilde
];

// @dev Checks that a given secret input (password) respects enough criteria (amongst: at least one digit, at least one lowercase, at least one uppercase, at least one special char).
// @param private_secret_input The private secret input to inspect, as an array of Pedersen hashes of the chars.
// @param nb_of_char_types_required Number between 1 and 4 specifying how many char types are required amongst digit, lowercase, uppercase and special char.
// @notice If you use the function in your project, make sure the input `private_secret_input` is a private input.
fn check_secret_is_proper(private_secret_input: [Field; SECRET_INPUT_LENGTH], nb_of_char_types_required: Field) {
    let mut has_digit: bool = false;
    let mut has_lowercase: bool = false;
    let mut has_uppercase: bool = false;
    let mut has_specialchar: bool = false;
    let mut all_chars_are_valid: bool = true;
    let mut current_char: Field = 0;
    for i in 0..SECRET_INPUT_LENGTH {
        current_char = private_secret_input[i];
        all_chars_are_valid &= is_char_valid(current_char);
        has_digit |= is_char_a_digit(current_char);
        has_lowercase |= is_char_a_lowercase(current_char);
        has_uppercase |= is_char_a_uppercase(current_char);
        has_specialchar |= is_char_a_specialchar(current_char);
    }
    let nb_of_char_types: u5 = has_digit as u5 + has_lowercase as u5 + has_uppercase as u5 + has_specialchar as u5;
    assert(all_chars_are_valid & (nb_of_char_types >= nb_of_char_types_required as u5));
}

fn is_char_valid(char_to_check: Field) -> bool {
    is_field_in_array(char_to_check, ACCEPTED_CHARS_ASCII_CODES_HASHED)
}

fn is_char_a_digit(char_to_check: Field) -> bool {
    is_field_in_array(char_to_check, DIGIT_CHARS_ASCII_CODES_HASHED)
}

fn is_char_a_lowercase(char_to_check: Field) -> bool {
    is_field_in_array(char_to_check, LOWERCASE_CHARS_ASCII_CODES_HASHED)
}

fn is_char_a_uppercase(char_to_check: Field) -> bool {
    is_field_in_array(char_to_check, UPPERCASE_CHARS_ASCII_CODES_HASHED)
}

fn is_char_a_specialchar(char_to_check: Field) -> bool {
    is_field_in_array(char_to_check, SPECIAL_CHARS_ASCII_CODES_HASHED)
}

fn is_field_in_array<N>(field: Field, array: [Field; N]) -> bool {
    let mut is_field_in_array: bool = false;
    for i in 0..N {
        if field == array[i] {
            is_field_in_array = true;
        }
    }
    is_field_in_array
}

////////////////////////////
// 2. Proper Secret Tests //
////////////////////////////

#[test]
fn test_check_secret_is_proper() {
    let x: [Field; SECRET_INPUT_LENGTH] = [
        0x0e23ab9f4d077373f5dd1e06e65a42ae23c0d9856126bc131a091fa2e0bd0e1c, // 'I' char
        0x06259a629d9eda880218afbdff67600e907144901aab7e6735b80bd8969cecad, // '_' char
        0x03331a6c6a82d7d4d9ed03bae70d39991dacc3cd93742c6750db416d31d49bb9, // '<' char
        0x034fc2eff5ea29664523402aec82d39bae64c8120c1f30dac99ff24a73eb8ab6, // '3' char
        0x06259a629d9eda880218afbdff67600e907144901aab7e6735b80bd8969cecad, // '_' char
        0x201a8ea4e78ecc2e6f5c55b1a3e9e430db82c8fc6cbf46af4674d3c956437ef8, // 'p' char
        0x2bc4bb39989fedfe614e3ecb1459abf29c1a7c0d5f1a6198ca666a7681127a2e, // 'a' char
        0x2ac4e33de9876873c93bc790c1b3ed01800ea98459dc786d921df830755eee1e, // 's' char
        0x1be43ae9ae5f0b01a507385db6f27e33e1cf5134ec652254362a5d34e56c09a5, // 't' char
        0x2ced7a1e5259f39113165179820c949a6c1dddbd5ab404e4f876e1b94e0c686a, // 'e' char
        0x1331051e6aeedf737c007b0f5341ee9b1ad3db59b5e585289c99b1f3ad65fc23, // 'i' char
        0x2ac4e33de9876873c93bc790c1b3ed01800ea98459dc786d921df830755eee1e, // 's' char
        0x06259a629d9eda880218afbdff67600e907144901aab7e6735b80bd8969cecad, // '_' char
        0x14ec7c744f563a9b337121af1d454700c52b9008b4c522fe7c10bbb4229a2eaa, // 'd' char
        0x2ced7a1e5259f39113165179820c949a6c1dddbd5ab404e4f876e1b94e0c686a, // 'e' char
        0x06259a629d9eda880218afbdff67600e907144901aab7e6735b80bd8969cecad, // '_' char
        0x02729cbddd4ec32f79556df47ee2f6ef5fb341fb98823872450fda675a06d81c, // 'n' char
        0x2bc4bb39989fedfe614e3ecb1459abf29c1a7c0d5f1a6198ca666a7681127a2e, // 'a' char
        0x1be43ae9ae5f0b01a507385db6f27e33e1cf5134ec652254362a5d34e56c09a5, // 't' char
        0x2bc4bb39989fedfe614e3ecb1459abf29c1a7c0d5f1a6198ca666a7681127a2e  // 'a' char
    ];
    check_secret_is_proper(x, 4);
    check_secret_is_proper(x, 3);
    check_secret_is_proper(x, 2);
    check_secret_is_proper(x, 1);
}
