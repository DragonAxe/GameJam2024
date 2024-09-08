shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

uniform float blur : hint_range(0.0, 1.0, 0.1);
uniform float blur_multiplier = 2;

void fragment() {
  COLOR = textureLod(screen_texture, SCREEN_UV, blur * blur_multiplier) + vec4(vec3((blur*blur_multiplier)/80.0), 0.0);
}
