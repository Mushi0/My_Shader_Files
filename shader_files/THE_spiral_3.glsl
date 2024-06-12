#define PI 3.1415926535
#define EULER 2.71828182845

vec3 palette( float t ) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263,0.416,0.557);
    return a + b*cos( 6.28318*(c*t+d) );
}


float sdSpiral(vec2 p){
    float targetR = length(p);
    float targetTheta = atan(p.y,p.x);
    float a = 1.0;
    float b = 0.5;
    float n = (log(targetR / a) / b - targetTheta) / (2.0 * PI);
    float r1 = a * pow(EULER, b * (targetTheta + floor(n) * (2.0 * PI)));
    float r2 = a * pow(EULER, b * (targetTheta + ceil(n) * (2.0 * PI)));
    return min(abs(r1-targetR),abs(r2-targetR));
}

mat2 rotation2D(float angle){
    float sine = sin(angle), cosine = cos(angle);
    return mat2( cosine, -sine, 
                 sine,    cosine );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord * 2. - iResolution.xy) / iResolution.y;
    vec2 uv2 = uv;
    //vec2  m = (iMouse.xy * 2. - iResolution.xy) / iResolution.y;
    
    uv *= rotation2D(iTime/5.0);
    float inv = 0.003;
    float reps = 20.0;
    vec3 col = vec3(0.0);
    for(float i; i<reps;i++){
        float r = inv/sdSpiral(uv*rotation2D((PI*2.0*i)/reps));
        col += palette(i/reps)*(r*exp(-r));
        col += palette(i/reps)*smoothstep(1.0,2.5,r);
    }
    

    fragColor = vec4(col,1.0);
}
