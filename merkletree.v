import crypto.sha256

struct MerkleTree {
	blocks []string [required]
	branching_factor int = 2
}

fn (m MerkleTree) get_root() Node {
	mut leaves := []Node{}

	// create leaf nodes
	for block in m.blocks {
		leaves << Node{
			children: [Block{
				value: block
			}],
		}
	}

	return m.build_tree(leaves)
}

fn (m MerkleTree) build_tree(nodes []Node) Node {
	if 1 == nodes.len {
		// root found
		return nodes[0]
	}

	mut parents := []Node{}

	// only create parent node from every m.branching_factor-th node and its siblings
	for i := 0; i <= nodes.len - m.branching_factor; i += m.branching_factor {
		mut siblings := []Child{}

		// group nodes dependent on branching factor
		for j := i; j < i + m.branching_factor; j++ {
			// there are enough nodes to fill this group of siblings
			if j <= nodes.len - 1 {
				siblings << Child(nodes[j])
			}
		}

		parents << Node{
			children: siblings
		}
	}

	return m.build_tree(parents)
}

type Child = Node | Block

struct Node {
	children []Child [required]
}

struct Block {
	value string
}

fn (n Node) get_hash() []u8 {
	mut payload := []u8{}

	if 1 == n.children.len {
		// is this a leaf node ?
		if n.children[0] is Node {
			// lonely node -> avoid re-hashing
			node := n.children[0] as Node
			return node.get_hash()
		}

		// prevent second preimage attacks
		payload << [u8(0x00)]
		block := n.children[0] as Block
		payload << block.value.bytes()
	} else {
		// prevent second preimage attacks
		payload << [u8(0x01)]

		// create sum of child nodes
		for child in n.children {
			node := child as Node
			payload << node.get_hash()
		}
	}

	return sha256.sum(payload)
}
