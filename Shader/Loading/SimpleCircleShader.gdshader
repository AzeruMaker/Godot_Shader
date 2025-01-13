shader_type canvas_item;

uniform float min_radius : hint_range(0., 1.) = 1.0;
uniform float discover_zone : hint_range(0., 1.) = 0.125;

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

	// Formula for the circle
	float actual_progress = min_radius / discover_zone;	
	float c = circle(translate, actual_progress, 0.0) * color_average;

	// Output the circle
	COLOR = input_color - vec4(c);	
}