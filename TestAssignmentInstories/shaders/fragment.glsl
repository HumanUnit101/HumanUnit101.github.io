#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_texture_0;
uniform vec2 u_resolution;

uniform sampler2D u_buffer0;

#ifdef BUFFER_0
void main()
{
    vec2 inputResolution = vec2(1080.,1920.);
    vec2 screenResolution = u_resolution;
    vec2 ratio = screenResolution/inputResolution;
    vec2 uv = gl_FragCoord.xy;
    uv-= 0.5*inputResolution*max(vec2(ratio.x-ratio.y,ratio.y-ratio.x),0.);
    uv /= inputResolution*min(ratio.x,ratio.y );
    float mask = fract(uv)==uv?1.:0.;
    vec4 col= texture2D(u_texture_0,uv);
    col.a=mask;

    gl_FragColor = col;
}
#else 
void main()
{
    vec2 uv = gl_FragCoord.xy/u_resolution;
    gl_FragColor = texture2D(u_buffer0,uv);
}
#endif