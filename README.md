<h1 align="center">
    <img src=".github/project-logo.svg" width="512px">
</h1>

# v-merkletree

Lightweight library (under 100 lines) that lets you create sha256-based merkle trees with custom branching factors.

## :bulb: Interface

```v
pub struct MerkleTree {
	blocks []string [required]
	branching_factor int = 2
}
```

```v
pub fn (m MerkleTree) get_root() []u8
```

## :rocket: Full example

```v
import merkletree { MerkleTree }

fn main() {
	tree := &MerkleTree{
		blocks: ['1', '2', '3', '4']
	}

	root := tree.get_root().hex()
}
```

## Feel like contributing?

Create an [issue](https://github.com/bpesch/v-merkle-tree/issues/new/choose) or a [pull request](https://github.com/bpesch/v-merkle-tree/compare).

## License

This project is licensed under the [MIT](LICENSE) license.
Feel free to do whatever you want with the code!
