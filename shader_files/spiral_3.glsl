#define PI 3.1415926535
#define EULER 2.71828182845


float sdSpiral(vec2 p){
    float targetR = length(p);
    float targetTheta = atan(p.y,p.x);
    float a = 1.0;
    float b = 0.1;
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
    //vec2  m = (iMouse.xy * 2. - iResolution.xy) / iResolution.y;
    
    uv *= rotation2D(iTime);
    
    float inv = 0.01;
    float r = inv/sdSpiral(uv);
    float g = inv/sdSpiral(uv*rotation2D(2.0*PI/3.0));
    float b = inv/sdSpiral(uv*rotation2D(2.0*PI/3.0*2.0));
    vec3 col = vec3(r,g,b);
    float d = length(uv);
    col +=  col * d * exp(-d) * 0.06;

    fragColor = vec4(col,1.0);
}
