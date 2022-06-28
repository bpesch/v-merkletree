import merkletree

fn main() {
	tree := &merkletree.MerkleTree{
		blocks: ['1', '2', '3', '4']
	}

	assert tree.get_root().hex() == '4c4b77fe3fc6cfb92e4d3c90b5ade42f059a1f112a49827f07edbb7bd4540e7b'
}
