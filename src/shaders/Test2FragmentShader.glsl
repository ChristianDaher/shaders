varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;
varying vec3 vPattern;

uniform float time;

void main() {
    float pattern = vUv.x;
    gl_FragColor = vec4(vec3(pattern), 1.0);
}