# constants.gd
class_name Constants extends Node

# -- Layers -- #
const LAYER_WORLD : int = 1 << 0
const LAYER_PLAYER : int = 1 << 1
const LAYER_ENEMY : int = 1 << 2
const LAYER_PROJECTILE : int = 1 << 3

# -- Collision Masks -- #
const MASK_PLAYER_HITS : int = LAYER_WORLD | LAYER_ENEMY
const MASK_ENEMY_HITS : int = LAYER_WORLD | LAYER_PLAYER

# -- Physics layers -- #
