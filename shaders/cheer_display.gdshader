shader_type canvas_item;

uniform vec4 base_color : hint_color = vec4(1.0);

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = texture_color * base_color;
}