# Noir library Demo

A demo repo for showing how to publish a Noir library.

Notice in `/.github/workflows/test.yml` that it is really easy to incorporate automated testing to your library so you never release broken code. 🙂 🚀

## Create your own library

1. Create a file called `lib.nr` in `./src` containing the code for the Noir library. The functions in this file will be available to anyone that imports the library into their project.
2. Create a release on Github. See [these](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository) instructions.
3. That's it! Anyone can now use your library in their Noir project.

## Using the library

1. Add the library to your Noir project dependencies in the `Nargo.toml` file.

```toml
[dependencies]
demo_lib = {tag = "v0.1", git = "https://github.com/critesjosh/noir-lib-demo"}
```

2. Import the library into your Noir code.

```rust
use dep::std;
use dep::demo_lib;

fn main(){
    // ...
    let new_array = demo_lib::coordinates_to_u64_array(pub_key_x, pub_key_y);
    std::println(new_array[0]);
    // ...
}
```

Credit to @colinnielsen for the example function.
