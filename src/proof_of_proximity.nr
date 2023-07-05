use dep::std;

/////////////////////////////////////
// 1. Euclidean Distance Functions //
/////////////////////////////////////

global MAX_VALUE_FOR_DISTANCE_SQUARED: u64 = 21888242871839275222246405745257275088548364400416034343698204186575808495617;

struct Point {
    x: Field,
    y: Field,
    z: Field
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
    assert(distance_squared < MAX_VALUE_FOR_DISTANCE_SQUARED - 1); // Make sure we don't overflow.
    assert(distance_threshold_squared < MAX_VALUE_FOR_DISTANCE_SQUARED - 1); // Make sure we don't overflow.
    assert(distance_squared < distance_threshold_squared);
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


/////////////////////////////////
// 2. Euclidean Distance Tests //
/////////////////////////////////

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
fn test_is_BN254() {
    assert(MAX_VALUE_FOR_DISTANCE_SQUARED == 0);
}
