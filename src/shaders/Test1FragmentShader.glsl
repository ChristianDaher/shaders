varying vec2 vUv;

uniform float time;

vec3 palette(float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);

    return a + b * cos(6.28318 * (c * t + d));
}

// vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
//     return a + b * cos(6.28318 * (c * t + d));
// }

void main() {
    vec2 uv0 = vUv;
    vec3 finalColor = vec3(0.0);

    for(float i = 0.0; i < 3.0; i++) {
        vec2 uv = fract((vUv + i) * 2.5) - 0.5;

        vec3 color = palette(length(uv0) + time * 0.4);

        float d = length(uv) * exp(-length(uv0));
        d = sin(d * 8.0 + time) / 8.;
        d = abs(d);
        d = pow(0.01 / d, 1.2);

        finalColor += color * d;
    }

    gl_FragColor = vec4(finalColor, 1.0);
}