module merkletree

import crypto.sha256

fn test_default() {
	mut tree := &MerkleTree{
		hash_function: sha256.sum
	}

	tree.build([
		'1'.bytes(),
		'2'.bytes(),
		'3'.bytes(),
		'4'.bytes(),
	])

	assert tree.get_root().hex() == '4c4b77fe3fc6cfb92e4d3c90b5ade42f059a1f112a49827f07edbb7bd4540e7b'
}

fn test_more_blocks() {
	mut tree := &MerkleTree{
		hash_function: sha256.sum
	}

	tree.build([
		'1'.bytes(),
		'2'.bytes(),
		'3'.bytes(),
		'4'.bytes(),
		'5'.bytes(),
		'6'.bytes(),
		'7'.bytes(),
	])

	assert tree.get_root().hex() == '74fcca69cfd70839f5d164348f9f41a4cf4430d08882dc9dcc72b0a6c97bb266'
}

fn test_asymmetric() {
	mut tree := &MerkleTree{
		hash_function: sha256.sum
		branching_factor: 3
	}

	tree.build([
		'1'.bytes(),
		'2'.bytes(),
		'3'.bytes(),
		'4'.bytes(),
		'5'.bytes(),
		'6'.bytes(),
		'7'.bytes(),
	])

	assert tree.get_root().hex() == '01ceda24bdd3a0a2308511b36c6c122ea63f8fb1d641f980a4fc5480aa878961'
}

fn test_branching_factor_higher_than_block_count() {
	mut tree := &MerkleTree{
		hash_function: sha256.sum
		branching_factor: 9
	}

	tree.build([
		'1'.bytes(),
		'2'.bytes(),
		'3'.bytes(),
		'4'.bytes(),
		'5'.bytes(),
		'6'.bytes(),
		'7'.bytes(),
	])

	assert tree.get_root().hex() == 'efa21273c492efbccc93a8fbf0e0811b46e2099d2d56640914867f458a3f8033'
}
