shader_type canvas_item;

// Which color you want to change
uniform vec4 c_1 : hint_color;
uniform vec4 c_2 : hint_color;
uniform vec4 c_3 : hint_color;
// Which color to replace it with
uniform vec4 r_1 : hint_color;
uniform vec4 r_2 : hint_color;
uniform vec4 r_3 : hint_color;
// How much tolerance for the replacement color (between 0 and 1)
uniform float u_tolerance;

void fragment() {
	// Get color from the sprite texture at the current pixel we are rendering
	vec4 original_color = texture(TEXTURE, UV);
	vec3 col = original_color.rgb;
	// Get a rough degree of difference between the texture color and the color key
	vec3 diff3 = col - c_1.rgb;
	float m = max(max(abs(diff3.r), abs(diff3.g)), abs(diff3.b));
	// Change color of pixels below tolerance threshold, while keeping shades if any (a bit naive, there may better ways)
	float brightness = length(col);
	col = mix(col, r_1.rgb * brightness, step(m, u_tolerance));
	// Assign final color for the pixel, and preserve transparency
	COLOR = vec4(col.rgb, original_color.a);
	
	diff3 = col - c_2.rgb;
	m = max(max(abs(diff3.r), abs(diff3.g)), abs(diff3.b));
	// Change color of pixels below tolerance threshold, while keeping shades if any (a bit naive, there may better ways)
	brightness = length(col);
	col = mix(col, r_2.rgb * brightness, step(m, u_tolerance));
	// Assign final color for the pixel, and preserve transparency
	COLOR = vec4(col.rgb, original_color.a);

	diff3 = col - c_3.rgb;
	m = max(max(abs(diff3.r), abs(diff3.g)), abs(diff3.b));
	// Change color of pixels below tolerance threshold, while keeping shades if any (a bit naive, there may better ways)
	brightness = length(col);
	col = mix(col, r_3.rgb * brightness, step(m, u_tolerance));
	// Assign final color for the pixel, and preserve transparency
	COLOR = vec4(col.rgb, original_color.a);
}
