#extension GL_OES_standard_derivatives : enable
precision mediump float;

uniform vec3                iResolution;
uniform vec3                iChannelResolution;
uniform float               iGlobalTime;
uniform sampler2D           iChannel0;
varying vec2                texCoord;


const float amount = 80.0;
const vec2 start_pos = vec2(-0.25, -0.25); // -1.0 to 1.0 for x, y


vec4 blackwhite(in vec4 col){

    vec3 c_r = vec3(0.3, 0.6, 0.1);
	vec3 c_g = vec3(0.3, 0.6, 0.1);
	vec3 c_b = vec3(0.3, 0.6, 0.1);

	vec3 rgb = vec3( dot(col.rgb,c_r), dot(col.rgb,c_g), dot(col.rgb,c_b) );
    return vec4(rgb, 1.);
}

vec3 deform( in vec2 p )
{
    vec2 uv;
    uv.x = sin( 0.0 + 1.0 ) + p.x;
    uv.y = sin( 0.0 + 1.0 ) + p.y;
    return texture2D( iChannel0, uv * 0.5 ).xyz;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 position = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
    vec2 current_step = position;

    vec2 direction = ( start_pos - position ) / amount;

    vec3 total = vec3( 0.0 );
    for( int i = 0; i < int( amount ); i++ )
    {
        vec3 result = deform( current_step );
        result = smoothstep( 0.0, 1.0, result );
        total += result;
        current_step += direction;
    }

    total /= amount;
	vec4 color = vec4( total, 1.0 );

    fragColor = blackwhite(color);
}

void main() {
    mainImage(gl_FragColor, texCoord.xy*iResolution.xy);
}
