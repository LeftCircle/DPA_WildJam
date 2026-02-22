shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float softness : hint_range(0.0, 0.2) = 0.03;
uniform vec4 wipe_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    float edge = progress;

    float cover = smoothstep(edge - softness, edge + softness, UV.x);

    COLOR = vec4(wipe_color.rgb, wipe_color.a * cover);
}