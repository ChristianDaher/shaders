varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;
varying float vElevation;

uniform float time;

vec3 palette(float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.00, 0.33, 0.67);
    return a + b * cos(6.28318 * (c * t + d));
}

void main() {
    vec3 normal = normalize(vNormal);
    vec3 viewDir = vec3(0.0, 0.0, 1.0);
    
    vec3 lightDir1 = normalize(vec3(1.0, 1.0, 0.8));
    vec3 lightDir2 = normalize(vec3(-0.5, -0.3, 0.5));
    
    float diff1 = max(dot(normal, lightDir1), 0.0);
    float diff2 = max(dot(normal, lightDir2), 0.0) * 0.3;
    float lighting = 0.15 + diff1 * 0.6 + diff2;
    
    float angle = atan(vPosition.y, vPosition.x);
    float colorPhase = angle / 6.28318 + time * 0.1;
    
    vec3 baseColor = palette(colorPhase + vElevation * 2.0);
    
    vec3 color = baseColor * lighting;
    
    vec3 halfDir = normalize(lightDir1 + viewDir);
    float spec = pow(max(dot(normal, halfDir), 0.0), 32.0);
    color += spec * 0.3;
    
    gl_FragColor = vec4(color, 1.0);
}