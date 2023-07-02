use dep::std;
use dep::fruity_lib;

global MAX_ARRAY_SIZE_IN_FRUITY_LIB = 20;

// In this example we work with latitudes/longitudes of two points on Earth, and check their distance is below a given threshold.
// Note 1: Each degree (latitude or longitude) the radius line of the Earth sweeps out corresponds to 111,139 meters.
// Note 2: Technically Earth is (almost) a sphere so using Pythagore's theorem <=> Euclidean distance isn't completely accurate, but impact is less than about 1% for distance below 500km or so.
// Note 3: We are shifting the latitudes and longitudes to avoid negative numbers -- in a real use case, best is to use a private translation vector to translate the points.
// Note 4: We'll work in micrometers since Noir doesn't do floating point arithmetic.
// To sum up, the inputs to this function assume that:
// - The latitudes/longitudes of our 2 points were converted to cartesians coordinates (in micrometers) on a 2D plan by multiplying them by 111,139,000,000 (see note 1 & 4 above, with 111,139 meters = 111,139,000,000 µm).
// - The latitude/longitude were shifted by a random [x, y] vector (with 1e15 < shift_x, shift_y < 1e17) to avoid negative numbers (see note 3 -- note it can be any number, as long as the two points are shifted by the same vector).
// The call to `check_points_are_below_threshold` finally checks that the distance between the two points is below 300km (300,000,000,000µm).
fn main(
    // A pedersen hash of the (x, y, z) coordinates of the first point serving as a public commitment to the first point.
    commitmentA: pub Field, 
    // A pedersen hash of the (x, y, z) coordinates of the second point serving as a public commitment to the second point.
    commitmentB: pub Field, 
    // Latitude of the first point, multiplied by 111,139 meters and shifted as indicated above. 
    latitudeA: Field, 
    // Longitude of the first point, multiplied by 111,139 meters and shifted as indicated above. 
    longitudeA: Field,
    // Latitude of the second point, multiplied by 111,139 meters and shifted as indicated above. 
    latitudeB: Field, 
    // Longitude of the second point, multiplied by 111,139 meters and shifted as indicated above. 
    longitudeB: Field,
    // Specify the distance threshold we're checking for.
    threshold: pub Field
){
    // ...
    let pointA = fruity_lib::coordinates_to_point(latitudeA, longitudeA, 0);
    let pointB = fruity_lib::coordinates_to_point(latitudeB, longitudeB, 0);
    fruity_lib::check_points_proximity(commitmentA, commitmentB, pointA, pointB, threshold);
    std::println("They're close enough!");
    // ...
}