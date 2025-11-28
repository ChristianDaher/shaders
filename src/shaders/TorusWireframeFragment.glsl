varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;
varying vec3 vPattern;

uniform float time;

void main() {
    float pattern = clamp((abs(vUv.x - 0.5) - 0.3) * 3., 0., 1.);
    gl_FragColor = vec4(vec3(pattern), 1.0);
}