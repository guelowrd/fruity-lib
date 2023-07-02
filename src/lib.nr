use dep::std;

global MAX_ARRAY_SIZE_FOR_PSI: Field = 20;


/////////////////////////
// 1. PROOFS FUNCTIONS //
/////////////////////////

///////////////////////////////////
// 1.1. Private Set Intersection //
///////////////////////////////////

fn get_max_array_size_for_psi() -> Field {
    MAX_ARRAY_SIZE_FOR_PSI
}

fn check_commitment_of_private_set(commitment: Field, set: [Field; MAX_ARRAY_SIZE_FOR_PSI]) {
    let computed_commitment = std::hash::pedersen(set);
    assert(commitment == computed_commitment[0]);
}

fn get_intersection_cardinality(private_set_a : [Field; MAX_ARRAY_SIZE_FOR_PSI], private_set_b : [Field; MAX_ARRAY_SIZE_FOR_PSI]) -> Field {
    let mut cardinality: Field = 0;
    for i in 0..MAX_ARRAY_SIZE_FOR_PSI {
        for j in 0..MAX_ARRAY_SIZE_FOR_PSI {
            // We only need to check that private_set_a[i] != 0, as if this condition holds then private_set_a[i] == private_set_b[j] implies that private_set_b[j] != 0.
            if (private_set_a[i] != 0) & (private_set_a[i] as u64 == private_set_b[j] as u64) {
                cardinality += 1;
            }
        }
    }
    cardinality
}

// @dev Checks that the intersection of two private sets is non-empty.
// @param commitment_a A Pedersen hash of the first set of hashed elements serving as a public commitment to the first set.
// @param commitment_b A Pedersen hash of the second set of hashed elements serving as a public commitment to the second set.
// @param private_set_a First set of hashed elements (can be any hash function).
// @param private_set_b Second set of hashed elements (can be any hash function).
// @param intersection_is_empty A boolean indicating whether we want to check the intersection is empty or non-empty.
// @dev The function first checks that the commitments, then compute the cardinality of the intersection of the two sets, and finally asserts that this cardinality is empty or not (depending on intersection_is_empty input).
// @notice If you use the function in your project, make sure the commitments `pub_commitment_a` & `pub_commitment_b` and the emptyness to check `intersection_is_empty` are public inputs.
fn check_private_set_intersection(
    commitment_a: Field, 
    commitment_b: Field, 
    private_set_a: [Field; MAX_ARRAY_SIZE_FOR_PSI], 
    private_set_b: [Field; MAX_ARRAY_SIZE_FOR_PSI],
    intersection_is_empty: bool
) {
    check_commitment_of_private_set(commitment_a, private_set_a);
    check_commitment_of_private_set(commitment_b, private_set_b);
    let cardinality = get_intersection_cardinality(private_set_a, private_set_b);
    if intersection_is_empty {
        assert(cardinality == 0);
    } else {
        assert(cardinality != 0);
    }
}

/////////////////////////////
// 1.2. Euclidean Distance //
/////////////////////////////

struct Point {
    x: Field,
    y: Field,
    z: Field
}

fn translate_point(point: Point, translation_vector: Point) -> Point {
    let translated_point = Point {
        x: point.x + translation_vector.x,
        y: point.y + translation_vector.y,
        z: point.z + translation_vector.z,
    };
    translated_point
}

fn coordinates_to_point(x: Field, y: Field, z: Field) -> Point {
    let point = Point {
        x: x,
        y: y,
        z: z,
    };
    point
}

fn get_euclidean_distance_squared(point_a: Point, point_b: Point) -> Field {
    let x_squared = (point_a.x - point_b.x) * (point_a.x - point_b.x);
    let y_squared = (point_a.y - point_b.y) * (point_a.y - point_b.y);
    let z_squared = (point_a.z - point_b.z) * (point_a.z - point_b.z);
    let distance_squared = x_squared + y_squared + z_squared;
    distance_squared
}

fn get_commitment_of_point(point: Point) -> Field {
    let computed_commitment = std::hash::pedersen([point.x, point.y, point.z]);
    computed_commitment[0]
}

fn check_commitment_of_point(commitment: Field, point: Point) {
    let computed_commitment = get_commitment_of_point(point);
    assert(commitment == computed_commitment);
}

// @dev Checks that the distance between two points is below a given threshold.
// @param commitment_a A Pedersen hash of the first point serving as a public commitment to the first point.
// @param commitment_b A Pedersen hash of the second point serving as a public commitment to the second point.
// @param private_point_a First point (should have been translated by a private translation vector before calling this function if privacy is required).
// @param private_set_b Second point (should have been translated by a private translation vector before calling this function if privacy is required).
// @param distance_threshold Distance between the two points will be compared to this threshold value -- function returns true if distance < threshold, else returns false.
// @dev The function first checks the commitments, then compute the square of the distance between the two points, and finally asserts that the square of the distance is below the square of the threshold.
// @notice If you use the function in your project, make sure the commitments `commitment_a` & `commitment_b` are public inputs.
fn check_points_proximity(
    commitment_a: Field, 
    commitment_b: Field, 
    private_point_a: Point, 
    private_point_b: Point,
    distance_threshold: Field
) {
    assert(distance_threshold as u64 > 0);
    check_commitment_of_point(commitment_a, private_point_a);
    check_commitment_of_point(commitment_b, private_point_b);
    let distance_squared: u64 = get_euclidean_distance_squared(private_point_a, private_point_b) as u64;
    let distance_threshold_squared: u64 = (distance_threshold * distance_threshold) as u64;
    assert(distance_squared < distance_threshold_squared);
}

//////////////
// 2. TESTS //
//////////////

////////////////////
// 2.1. PSI Tests //
////////////////////

#[test]
fn test_private_set_intersection_is_empty() {
    let private_set_a: [Field; MAX_ARRAY_SIZE_FOR_PSI] = [0xb74e2884bd845cc06bc0e2fc2841fc5015865ef7b84688dbcb700b84ac216c22,0x0000000000000000000000000000000000000000000000000000000000000000,0xf3d1edb7c28457ca230e195689fe4f735229f3c4e465e08467815e8bc56584a8,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000];
    let private_set_b: [Field; MAX_ARRAY_SIZE_FOR_PSI] = [0x0000000000000000000000000000000000000000000000000000000000000000,0xd1a76970243ed6fa98d5609955ebb75d21fa1e834afc6e72197392014a4f0fbc,0x1a5203a4da0667310353cb45e76f30f733bb2789487f8fdf11f68edd057b5e19,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000];   
    let pub_commitment_a: Field = 0x16ad1d69b4502e3285c21a34da7c3b3cade1307aa22b62218eb01b38b51eebce;
    let pub_commitment_b: Field = 0x18398d61bdfc65f29b57346e3ef7c78b7637ee5a50e62cd5506b0df42c9ef8e7;
    let intersection_is_empty: bool = true;
    check_private_set_intersection(pub_commitment_a, pub_commitment_b, private_set_a, private_set_b, intersection_is_empty);
}

#[test]
fn test_private_set_intersection_is_not_empty() {
    let pub_commitment_a: Field = 0x26ed5e1af87ec150f8f69345f4b4db8ae49fea36516f72403ed590fa1bfe3570;
    let pub_commitment_b: Field = 0x0f3fc7cbde26e9f4972e074591a3aa2e3e125e71285aad8174bd73aeb0876d5f;
    let private_set_a: [Field; MAX_ARRAY_SIZE_FOR_PSI] = [0xb74e2884bd845cc06bc0e2fc2841fc5015865ef7b84688dbcb700b84ac216c22,0xd5bc4f28142b87c37b07862dd864ca3923a16ce9a72597297bed636d7e127851,0xf3d1edb7c28457ca230e195689fe4f735229f3c4e465e08467815e8bc56584a8,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000];
    let private_set_b: [Field; MAX_ARRAY_SIZE_FOR_PSI] = [0xd5bc4f28142b87c37b07862dd864ca3923a16ce9a72597297bed636d7e127851,0xd1a76970243ed6fa98d5609955ebb75d21fa1e834afc6e72197392014a4f0fbc,0x1a5203a4da0667310353cb45e76f30f733bb2789487f8fdf11f68edd057b5e19,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000000000000000000000000000];   
    let intersection_is_empty: bool = false;
    check_private_set_intersection(pub_commitment_a, pub_commitment_b, private_set_a, private_set_b, intersection_is_empty);
}

#[test]
fn test_get_max_array_size_for_psi() {
    let expected_max_array_size_for_psi: Field = 20;
    let actual_max_array_size_for_psi: Field = get_max_array_size_for_psi();
    assert(expected_max_array_size_for_psi == actual_max_array_size_for_psi);
}

/////////////////////////
// 2.2. Distance Tests //
/////////////////////////

#[test]
fn test_get_euclidean_distance_squared() {
    let p0 = coordinates_to_point(0, 0, 0);
    let px7 = coordinates_to_point(7, 0, 0);
    let py7 = coordinates_to_point(0, 7, 0);
    let pz7 = coordinates_to_point(0, 0, 7);
    let pxBig = coordinates_to_point(147946755000000000000000000000000000000, 0, 0);
    let pyBig = coordinates_to_point(0, 147946755000000000000000000000000000000, 0);
    assert(get_euclidean_distance_squared(p0, p0) == 0);
    assert(get_euclidean_distance_squared(px7, p0) == 49);
    assert(get_euclidean_distance_squared(p0, py7) == 49);
    assert(get_euclidean_distance_squared(px7, pz7) == 98);
    assert(get_euclidean_distance_squared(pz7, px7) == 98);
    assert(get_euclidean_distance_squared(pxBig, pyBig) == 43776484630060050000000000000000000000000000000000000000000000000000000000000);
}

#[test]
fn test_check_porto_to_lisbon_distance_is_below_300km() {
    // In this test we work with latitudes/longitudes of two points on Earth, and check their distance is below a given threshold.
    // Our first point is Ponte da Arrábida in Porto: latitude = 41.147360, longitude = -8.640357
    // Our second point is Ponte 25 de Abril in Lisbon: latitude = 38.689598, longitude = -9.177078
    // Note 1: Each degree (latitude or longitude) the radius line of the Earth sweeps out corresponds to 111,139 meters.
    // Note 2: Technically Earth is (almost) a sphere so using Pythagore's theorem <=> Euclidean distance isn't completely accurate, but impact is less than about 1% for distance below 500km or so.
    // Note 3: We are shifting the longitudes to avoid negative numbers -- in a real use case, best is to use a private translation vector to translate the points.
    // Note 4: We'll work in micrometers since Noir doesn't do floating point arithmetic.
    // To sum up, what is done here in this test is:
    // - Convert the latitudes/longitudes of our 2 points to cartesians coordinates (in micrometers) on a 2D plan by multiplying them by 111,139,000,000 (see note 1 & 4 above, with 111,139 meters = 111,139,000,000 µm).
    // - Shift the latitude/longitude by 84,556,994,972,073,632µm/40,515,308,731,945,865µm to avoid negative numbers (see note 3 -- note it can be any number, as long as the two points are shifted by the same vector).
    // - Check that the distance between Porto and Lisbon is below 300km (cognizant of note 2).
    let porto_lat = 84561568048516672; // 41.147360° * 111,139,000,000µm + 84,556,994,972,073,632µm shift = 84,561,568,048,516,672µm
    std::println(porto_lat);
    let porto_long = 40514348451309242; // -8.640357° * 111,139,000,000µm + 40,515,308,731,945,865µm shift = 40,514,348,451,309,242µm
    std::println(porto_long);
    let lisbon_lat = 84561294895305754; // 38.689598° * 111,139,000,000µm + 84,556,994,972,073,632µm shift = 84,561,294,895,305,754µm
    std::println(lisbon_lat);
    let lisbon_long = 40514288800674023; // -9.177078° * 111,139,000,000µm + 40,515,308,731,945,865µm shift = 40,514,288,800,674,023µm
    std::println(lisbon_long);
    let point_a = coordinates_to_point(porto_lat, porto_long, 0);
    let point_b = coordinates_to_point(lisbon_lat, lisbon_long, 0);
    let distance_threshold = 300000000000; // 300km
    std::println(distance_threshold);
    let commitment_a = get_commitment_of_point(point_a);
    std::println(commitment_a);
    let commitment_b = get_commitment_of_point(point_b);
    std::println(commitment_b);
    check_points_proximity(commitment_a, commitment_b, point_a, point_b, distance_threshold);
}

#[test]
fn test_check_lisbon_to_porto_distance_is_below_300km() {
    // Just inverting the position of the two points in the previous test, making sure there's no sign error.
    let porto_lat = 84561568048516672; // 41.147360° * 111,139,000,000µm + 84,556,994,972,073,632µm shift = 84,561,568,048,516,672µm
    let porto_long = 40514348451309242; // -8.640357° * 111,139,000,000µm + 40,515,308,731,945,865µm shift = 40,514,348,451,309,242µm
    let lisbon_lat = 84561294895305754; // 38.689598° * 111,139,000,000µm + 84,556,994,972,073,632µm shift = 84,561,294,895,305,754µm
    let lisbon_long = 40514288800674023; // -9.177078° * 111,139,000,000µm + 40,515,308,731,945,865µm shift = 40,514,288,800,674,023µm
    let point_a = coordinates_to_point(porto_lat, porto_long, 0);
    let point_b = coordinates_to_point(lisbon_lat, lisbon_long, 0);
    let distance_threshold = 300000000000; // 300km
    let commitment_a = get_commitment_of_point(point_a);
    let commitment_b = get_commitment_of_point(point_b);
    check_points_proximity(commitment_b, commitment_a, point_b, point_a, distance_threshold);
}

#[test]
fn test_squares_overflow() {
    // PROBLEM: Both numbers A and B are somewhere between 2^253 and 2^254, they don't really look special -- not sure why A is not overflowing while B is...
    // A = 21888242315030025000000000000000000000000000000000000000000000000000000000000 does not overflow
    // B = 21888243794497600000000000000000000000000000000000000000000000000000000000000 does overflow
    // (B is equivalent to:
    // C = 922658324777753594254742724911451635599583965656301795813424191504383, not sure which modulo...)
    // Hexadecimal representation of A: 0x30644e5e39f9511070fb9ee950449cf1b75749b3ac43f4819000000000000000
    // Hexadecimal representation of B: 0x30644E951A5BC54BF73F1DEEB6EB8AE2F2E47053DC7693440000000000000000
    // Hexadecimal representation of C: 0x22392a25223eeed838356a3285cab0880b62bd22b2bc1e0a6c0fffffff
    // so B == C mod N but I'm not sure which N...
    // what's happening here???

    let w: Field = 147946755000000000000000000000000000000;
    std::println(w);
    let w_squared: Field = w * w;
    std::println(w_squared);
    assert(w_squared == 21888242315030025000000000000000000000000000000000000000000000000000000000000);

    let x: Field = 147946760000000000000000000000000000000;
    std::println(x);
    let x_squared: Field = x * x;
    std::println(x_squared);
    assert(x_squared == 21888243794497600000000000000000000000000000000000000000000000000000000000000);
    assert(x_squared == 922658324777753594254742724911451635599583965656301795813424191504383);
}
