<h1 align="center">
    <img src=".github/project-logo.svg" width="512px">
</h1>

# v-merkletree

Lightweight library that lets you create merkle trees with custom branching factors.

The library supports all hashing algorithms native to V out of the box.

## :bulb: Interface

```v
pub fn get_root(blocks [][]u8, branching_factor int, hash_function HashFunction) []u8
```

In case you want to implement a custom hashing algorithm, please do so according to this blueprint.

```v
pub type HashFunction = fn (data []u8) []u8
```

## :rocket: Full example

```v
import merkletree { get_root }
import crypto.sha256

fn main() {
	root := get_root([
		'1'.bytes(),
		'2'.bytes(),
		'3'.bytes(),
		'4'.bytes(),
	], 2, sha256.sum)

	print(root.hex())
}
```

## Feel like contributing?

Create an [issue](https://github.com/bpesch/v-merkle-tree/issues/new/choose) or a [pull request](https://github.com/bpesch/v-merkle-tree/compare).

## License

This project is licensed under the [MIT](LICENSE) license.
Feel free to do whatever you want with the code!
