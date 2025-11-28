varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;
varying float vElevation;

uniform float time;

void main() {
    vUv = uv;
    vPosition = position;
    vNormal = normal;
    
    float angle = atan(position.y, position.x);
    float radius = length(position.xy);
    
    float wave1 = sin(angle * 3.0 + time * 1.5) * 0.08;
    float wave2 = sin(angle * 5.0 - time * 2.0) * 0.04;
    float wave3 = sin(radius * 8.0 + time) * 0.03;
    
    float elevation = wave1 + wave2 + wave3;
    vElevation = elevation;
    
    vec3 newPosition = position + normal * elevation;
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}