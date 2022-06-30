module merkletree

// public api

pub type HashFunction = fn (data []u8) []u8

pub fn get_root(blocks [][]u8, branching_factor int, hash_function HashFunction) []u8 {
	mut leaves := []Node{}

	// create leaf nodes
	for block in blocks {
		leaves << Node{
			children: [Block{
				value: block
			}]
		}
	}

	return build_tree(leaves, branching_factor).get_hash(hash_function)
}

// internal

fn build_tree(nodes []Node, branching_factor int) Node {
	if 1 == nodes.len {
		// root found
		return nodes[0]
	}

	mut parents := []Node{}

	// only create parent node from every branching_factor-th node and its siblings
	for i := 0; i <= nodes.len - 1; i += branching_factor {
		mut siblings := []Child{}

		// group nodes dependent on branching factor
		for j := i; j < i + branching_factor; j++ {
			// are there enough nodes to fill this group of siblings?
			if j < nodes.len {
				siblings << Child(nodes[j])
			}
		}

		parents << Node{
			children: siblings
		}
	}

	return build_tree(parents, branching_factor)
}

type Child = Block | Node

struct Node {
	children []Child [required]
}

struct Block {
	value []u8 [required]
}

fn (n Node) get_hash(hash_function HashFunction) []u8 {
	mut payload := []u8{}

	if 1 == n.children.len {
		// is this a leaf node?
		if n.children[0] is Node {
			// lonely node -> avoid re-hashing
			return (n.children[0] as Node).get_hash(hash_function)
		}

		// prevent second preimage attacks
		payload << 0
		payload << (n.children[0] as Block).value
	} else {
		// prevent second preimage attacks
		payload << 1

		// create sum of child nodes
		for child in n.children {
			payload << (child as Node).get_hash(hash_function)
		}
	}

	return hash_function(payload)
}
