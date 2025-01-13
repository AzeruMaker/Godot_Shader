shader_type canvas_item;

uniform float progress = 0.8;

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, dot(position, position) * 4.0);
}

void fragment() {	
	vec2 uv = UV;
	// Color wanted for foreground
	vec4 input_color = texture(TEXTURE, UV);
	float color_average = (input_color.r + input_color.g + input_color.b) / 3.0;
	
	// "Output the shader with UV"
	vec2 translate = uv * 2.0 - 1.0;

	float actual_progress = progress / 1200.0;
	float feather = actual_progress / 2.0;
	
	float c = circle(translate, actual_progress, feather) * color_average;

	COLOR = input_color - vec4(c);	
}