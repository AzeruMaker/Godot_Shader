shader_type canvas_item;

uniform float discover_zone : hint_range(.0, 1.0) = 1.0;
uniform float rotation_zone : hint_range(1.0, 2.5) = 1.0;

// Function for UV Rotation
vec2 rotateUVmatrinx(vec2 uv, vec2 pivot, float rotation)
{
	mat2 rotation_matrix=mat2(	vec2(sin(rotation),-cos(rotation)),
								vec2(cos(rotation),sin(rotation))
								);
    uv -= pivot;
    uv= uv*rotation_matrix;
    uv += pivot;
    return uv;
}

void fragment() {
	
	// Rotation of UV
	// 1.0 => Begin at top
	// 1.5 => Begin at right
	// 2.0 => Begin at btton
	// 2.5 => begin at left

	vec4 Progress = vec4(discover_zone);
	vec2 uv = UV;
	uv = rotateUVmatrinx (uv, vec2 (0.5), PI * rotation_zone);
	
	// Color wanted for foreground
	vec4 input_color = texture(TEXTURE, UV);
	float color_average = (input_color.r + input_color.g + input_color.b) / 3.0;
	
	// "Output the shader with UV"
	float c = color_average * smoothstep(Progress.x, Progress.x,  uv.x);
	COLOR =  input_color - vec4(c);	
}