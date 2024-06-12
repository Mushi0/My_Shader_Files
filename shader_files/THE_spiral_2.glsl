const float PI = 3.1415926535384972;
const float TWOPI = PI*2.;
const float E = 2.71828182846;
const float a = 1.;
const float b = .5;
const float nb_loop = 7.;

vec3 palette( float t ) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263,0.416,0.557);
    return a + b*cos( 6.28318*(c*t+d) );
}

float getColor(float dis, float ang){
    float d1 = a*pow(E, b*(floor((log(dis/a)/b - ang)/TWOPI)*TWOPI + ang));
    float d2 = a*pow(E, b*(ceil((log(dis/a)/b - ang)/TWOPI)*TWOPI + ang));
    float dd = min(dis - d1, d2 - dis);
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
    
    vec3 col = vec3(0.0);
    for(float i = 0.0; i < nb_loop;i++){
        float dd = getColor(d, ang + TWOPI/nb_loop*i);
        col += palette(i/nb_loop)*dd;
    }
    
    fragColor = vec4(col*length(uv),1.0);
}
