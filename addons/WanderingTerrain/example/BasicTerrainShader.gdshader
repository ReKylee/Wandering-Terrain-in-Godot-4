shader_type spatial;

const vec2 TEXEL_SIZE = 1.0 / vec2(512.0) ;

uniform float Height = 100;
uniform vec2 uv_offset = vec2(0.0);
uniform sampler2D _Noise;

float overlay(float a, float b) {
	if(a < 0.5) {
		return 2.0 * a * b;
	} else {
		return 1.0 - 2.0 * (1.0 - a) * (1.0 - b);
	}
}

float CalculateHeight(vec2 uv) {

	float Noise = textureLod(_Noise, uv, 0).r * Height;
	
	return Noise;
		
		
}

vec3 calc_normal(vec2 uv) { 
    const vec3 off = vec3(-1,0,1);

    float left = CalculateHeight(uv + TEXEL_SIZE * off.xy);
    float right = CalculateHeight(uv + TEXEL_SIZE * off.zy);
    float top = CalculateHeight(uv + TEXEL_SIZE * off.yx);
    float down = CalculateHeight(uv + TEXEL_SIZE * off.yz);

    return normalize(vec3(left-right, 2.0, down-top));
}

//Free Normal Lerp function for you :D
vec3 nlerp(vec3 n1, vec3 n2, float t)
{
    return normalize(mix(n1, n2, t));
}

void vertex() {
	
	vec2 offsetUVs = UV + uv_offset;
	
	VERTEX.y += CalculateHeight(offsetUVs);
	
	vec3 N = calc_normal(offsetUVs);
	NORMAL = N;

}

