void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord * 2. - iResolution.xy) / iResolution.y;

    uv = fract(uv*(abs(sin(iTime/2.)*10.)+2.));

    vec3 finalcol = vec3(0.5,0.5,0.5);
    
    float x = uv.x;
    float y = uv.y;
    
    x = step(0.5,x);
    y = step(0.5,y);
    float z = abs(x-y);
    finalcol += z;

    fragColor = vec4(finalcol,1.0);
}