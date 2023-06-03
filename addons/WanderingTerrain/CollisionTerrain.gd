extends CollisionShape3D
class_name CollisionHeightmap

@export var terrain : MeshInstance3D

@onready var material : ShaderMaterial = terrain.get_surface_override_material(0) 
@onready var _Noise : NoiseTexture2D = material.get_shader_parameter("_Noise")

var _noiseImage : Image
var Height 

var collisoin_decimation := 2

var offsetUVs : Vector2 

#Debugging tools
@export var reverse : bool = false
@export var generate : bool : 
	set(value):
		create_collision()


func _ready():
	rotation_degrees.y = 180
	await _Noise.changed 
	
	create_collision()
	#get_parent().start_generating_collision = true
	
func create_collision():
	
	var float_array : PackedFloat32Array = []
	
	Height = material.get_shader_parameter("Height")
	
	_noiseImage = _Noise.get_image()
	
	scale.x = terrain.scale.x * 2243/_Noise.get_height() * collisoin_decimation
	scale.z = terrain.scale.z * 2243/_Noise.get_width() * collisoin_decimation
	
	_noiseImage.resize(_noiseImage.get_width()/ collisoin_decimation + 1,  _noiseImage.get_height()/ collisoin_decimation + 1)
	
	shape = HeightMapShape3D.new()
	shape.map_depth = _noiseImage.get_height()
	shape.map_width = _noiseImage.get_width()
	
	for y in _noiseImage.get_height():
		for x in _noiseImage.get_width():
			float_array.push_back(CalculateHeight(Vector2(x, y)))
	
	if(reverse):
		float_array.reverse()
		
	shape.map_data = float_array

#However you calculate your height in the shader.
func CalculateHeight(uv : Vector2) -> float:
	
	var MyNoise = _noiseImage.get_pixelv(uv).r;
	return MyNoise * Height
	


