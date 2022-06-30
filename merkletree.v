module merkletree

// public api

pub struct MerkleTree {
	blocks            []string         [required]
	branching_factor  int = 2
	hashing_algorithm HashingAlgorithm
}

pub fn (m MerkleTree) get_root() []u8 {
	mut leaves := []Node{}

	// create leaf nodes
	for block in m.blocks {
		leaves << Node{
			children: [Block{
				value: block
			}]
		}
	}

	return m.build_tree(leaves).get_hash(m.hashing_algorithm)
}

// internal

fn (m MerkleTree) build_tree(nodes []Node) Node {
	if 1 == nodes.len {
		// root found
		return nodes[0]
	}

	mut parents := []Node{}

	// only create parent node from every m.branching_factor-th node and its siblings
	for i := 0; i <= nodes.len - 1; i += m.branching_factor {
		mut siblings := []Child{}

		// group nodes dependent on branching factor
		for j := i; j < i + m.branching_factor; j++ {
			// are there enough nodes to fill this group of siblings?
			if j < nodes.len {
				siblings << Child(nodes[j])
			}
		}

		parents << Node{
			children: siblings
		}
	}

	return m.build_tree(parents)
}

type Child = Block | Node

struct Node {
	children []Child [required]
}

struct Block {
	value string [required]
}

fn (n Node) get_hash(hashing_algorithm HashingAlgorithm) []u8 {
	mut payload := []u8{}

	if 1 == n.children.len {
		// is this a leaf node ?
		if n.children[0] is Node {
			// lonely node -> avoid re-hashing
			return (n.children[0] as Node).get_hash(hashing_algorithm)
		}

		// prevent second preimage attacks
		payload << [u8(0x00)]
		payload << (n.children[0] as Block).value.bytes()
	} else {
		// prevent second preimage attacks
		payload << [u8(0x01)]

		// create sum of child nodes
		for child in n.children {
			payload << (child as Node).get_hash(hashing_algorithm)
		}
	}

	return hashing_algorithm.sum(payload)
}
