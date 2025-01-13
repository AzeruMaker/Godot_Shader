shader_type canvas_item;

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}

void fragment() {
	vec3 color = vec3(circle(UV,0.2));
	
	if (UV.x > 0.5 && UV.y > 0.5) {
		COLOR = vec4( color, 1.0 ) + vec4(0.4,0.6,0.7,0.0);
	
		if (cos (UV.y) * cos (UV.y) +sin(UV.x) * sin (UV.x) <= 1.) {
				COLOR = COLOR * .25;
		}
	}
	
	if (UV.x < 0.5 && UV.y < 0.5) {
		COLOR = vec4( color, 1.0 ) + vec4(1.5,0.6,0.7,0.0);
	
		if (cos (UV.y) * cos (UV.y) +sin(UV.x) * sin (UV.x) >= 1.) {
				COLOR = COLOR * .5;
		}
		
		
	}
	
	if (UV.x < 0.5 && UV.y > 0.5) {
		COLOR = vec4( color, 1.0 ) + vec4(.5,0.9,0.7,0.0);
		
		if (cos (UV.y - 0.5) * cos (UV.y - 0.5) +sin(UV.x - 0.5) * sin (UV.x - 0.5) >= 1.) {
				COLOR = COLOR * .5;
		}
	}

	if (UV.x > 0.5 && UV.y < .5) {
		COLOR = vec4( color, 1.0 ) + vec4(.5,0.5,0.7,0.0);	
		
		if (cos (UV.y - 0.5) * cos (UV.y - 0.5) +sin(UV.x - 0.5) * sin (UV.x - 0.5) >= 1.) {
				COLOR = COLOR * .5;
		}
	}
}	