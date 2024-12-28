shader_type canvas_item;

uniform vec4 rec = vec4(0.3);

void fragment() {
	vec2 uv = UV;
	vec4 input_color = texture(TEXTURE, UV);
	float color_average = (input_color.r + input_color.g + input_color.b) / 3.0;
	float c = color_average * smoothstep(rec.x, rec.x,  uv.x);
	COLOR =  input_color - vec4(c);
}
