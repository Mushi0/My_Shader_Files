const float PI = 3.1415926535384972;
const float TWOPI = PI*2.;
const float E = 2.71828182846;
const float a = 1.;
const float b = .5;

float getColor(float dis, float ang){
    float d1 = a*pow(E, b*(floor((log(dis/a)/b - ang)/TWOPI)*TWOPI + ang));
    float d2 = a*pow(E, b*(ceil((log(dis/a)/b - ang)/TWOPI)*TWOPI + ang));
    float dd;
    if(dis - d1 < d2 - dis){
        dd = dis - d1;
    }else{
        dd = d2 - dis;
    }
    dd = 0.01/dd;
    return dd;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{    
	vec2 uv = (2.0*fragCoord-iResolution.xy)/iResolution.y;
    vec2 m = (2.0*iMouse.xy-iResolution.xy)/iResolution.y;
    
    float d = length(uv);
	float ang = atan(uv.y, uv.x);
    ang += iTime;
    
    float dd1 = getColor(d, ang);
    float dd2 = getColor(d, ang + TWOPI/3.);
    float dd3 = getColor(d, ang + TWOPI/3.*2.);
    
    vec3 red = vec3(1.0,0.0,0.0);
    vec3 green = vec3(0.0,1.0,0.0);
    vec3 blue = vec3(0.0,0.0,1.0);
    
    fragColor = vec4((green*dd1 + red*dd2 + blue*dd3)*length(uv),1.0);
}
