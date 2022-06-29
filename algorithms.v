module merkletree

import crypto.md5
import crypto.sha1
import crypto.sha256
import crypto.sha512

// hashing algorithms

pub interface HashingAlgorithm {
	sum(data []u8) []u8
}

pub struct Md5 {}

pub fn (h Md5) sum(data []u8) []u8 {
	return md5.sum(data)
}

pub struct Sha1 {}

pub fn (h Sha1) sum(data []u8) []u8 {
	return sha1.sum(data)
}

pub struct Sha224 {}

pub fn (h Sha224) sum(data []u8) []u8 {
	return sha256.sum224(data)
}

pub struct Sha256 {}

pub fn (h Sha256) sum(data []u8) []u8 {
	return sha256.sum(data)
}

pub struct Sha384 {}

pub fn (h Sha384) sum(data []u8) []u8 {
	return sha512.sum384(data)
}

pub struct Sha512 {}

pub fn (h Sha512) sum(data []u8) []u8 {
	return sha512.sum512(data)
}

pub struct Sha512_224 {}

pub fn (h Sha512_224) sum(data []u8) []u8 {
	return sha512.sum512_224(data)
}

pub struct Sha512_256 {}

pub fn (h Sha512_256) sum(data []u8) []u8 {
	return sha512.sum512_256(data)
}
