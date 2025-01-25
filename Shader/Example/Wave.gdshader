shader_type canvas_item;

uniform vec3 wave_color: source_color = vec3(0.3, 0.2, 0.8); // Color of the wave
uniform vec3 edge_color: source_color = vec3(1.0, 1.0, 1.0); // Color of the edge
uniform sampler2D wave_texture : hint_default_black;         // Texture for the wave
uniform float wave_opacity: hint_range(0.0, 1.0) = 0.5;      // Opacity of the wave
uniform float texture_blend: hint_range(0.0, 1.0) = 0.5;     // Blend factor for the texture
uniform float speed: hint_range(0.1, 10) = 2;             // Speed of wave motion

void fragment() {
    // Transparent background
    vec4 col = vec4(0.0, 0.0, 0.0, 0.0);

    // Smooth wave animation
    float sine = cos(UV.y * 0.5 + (TIME *  speed)) * 0.01 + 0.8;
    float sine_2 =  cos(UV.x * 1.0 + (TIME *  speed)) * 0.005;
    float sine_3 =  sin(UV.x * 8.0 + (TIME *  speed)) * 0.02;
    float wave_height = sine + sine_2 + sine_3;

    // Determine the wave and edge areas
    float wave_mask = smoothstep(wave_height, wave_height, UV.y);

    // Apply wave color
    col.rgb = mix(col.rgb, wave_color, wave_mask);

    // Add alpha for non-background areas
    col.a = wave_mask * wave_opacity;

    // Apply static texture to the wave mask
    vec2 texture_coords = vec2(UV.x, UV.y); // Static texture without TIME offset
    vec4 texture_color = texture(wave_texture, texture_coords);

    // Blend texture with the wave
    col.rgb = mix(col.rgb, texture_color.rgb, texture_blend * wave_mask);

    COLOR = col * (col * vec4(2)) ;
}
