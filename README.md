<h1 align="center">
    <img src=".github/project-logo.svg" width="512px">
</h1>

# v-merkletree

Lightweight library that lets you create merkle trees with custom branching factors.

The library supports all hashing algorithms native to V out of the box.

## :bulb: Interface

```v
pub struct MerkleTree {
	blocks            []string         [required]
	branching_factor  int = 2
	hashing_algorithm HashingAlgorithm
}
```

View [this file](./algorithms.v) for a list of hashing algorithms supported out of the box.

```v
pub fn (m MerkleTree) get_root() []u8
```

In case you want to implement a custom hashing algorithm, please do so according to this interface.

```v
pub interface HashingAlgorithm {
	sum(data []u8) []u8
}
```

## :rocket: Full example

```v
import merkletree { MerkleTree, Sha256 }

fn main() {
	tree := &MerkleTree{
		blocks: ['1'.bytes(), '2'.bytes(), '3'.bytes(), '4'.bytes()]
		hashing_algorithm: &Sha256{}
		branching_factor: 2
	}

	root := tree.get_root()
	print(root.hex())
}
```

## Feel like contributing?

Create an [issue](https://github.com/bpesch/v-merkle-tree/issues/new/choose) or a [pull request](https://github.com/bpesch/v-merkle-tree/compare).

## License

This project is licensed under the [MIT](LICENSE) license.
Feel free to do whatever you want with the code!
