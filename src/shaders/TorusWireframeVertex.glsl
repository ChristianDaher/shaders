varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;

uniform float time;

#define PI 3.1415926535897932384626433832795
#define MOD3 vec3(0.1031, 0.11369, 0.13787)

vec3 hash33(vec3 p3) {
    p3 = fract(p3 * MOD3);
    p3 += dot(p3, p3.yzx + 19.19);
    return -1.0 + 2.0 * fract(vec3((p3.x + p3.y) * p3.z, (p3.x + p3.z) * p3.y, (p3.y + p3.z) * p3.x));
}

// float pnoise(vec3 p) {
//     vec3 pi = floor(p);
//     vec3 pf = p - pi;
//     vec3 w = pf * pf * (3.0 - 2.0 * pf);
//     return mix(mix(dot(hash33(pi + vec3(0.0, 0.0, 0.0)), pf), dot(hash33(pi + vec3(1.0, 0.0, 0.0)), pf), w.x), mix(dot(hash33(pi + vec3(0.0, 1.0, 0.0)), pf), dot(hash33(pi + vec3(1.0, 1.0, 0.0)), pf), w.x), w.y) + mix(mix(dot(hash33(pi + vec3(0.0, 0.0, 1.0)), pf), dot(hash33(pi + vec3(1.0, 0.0, 1.0)), pf), w.x), mix(dot(hash33(pi + vec3(0.0, 1.0, 1.0)), pf), dot(hash33(pi + vec3(1.0, 1.0, 1.0)), pf), w.x), w.y) * w.z;
// }

void main() {
    vUv = uv;
    vPosition = position;
    vNormal = normal;

    vec3 displacement = vec3(0.0);
    vec3 newPosition = vPosition + vNormal * displacement;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}