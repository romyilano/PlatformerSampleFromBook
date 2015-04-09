//#define M_PI 3.141592653589793
//#define M_2PI 6.283185307179586
//
//vec3 c1a = vec3(0.0, 0.0, 0.0);
//vec3 c1b = vec3(0.9, 0.0, 0.4);
//vec3 c2a = vec3(0.0, 0.5, 0.9);
//vec3 c2b = vec3(0.0, 0.0, 0.0);
//
//void mainImage( out vec4 fragColor, in vec2 fragCoord )
//{
//    vec2 p = 2.0*(0.5 * iResolution.xy - fragCoord.xy) / iResolution.xx;
//    float angle = atan(p.y, p.x);
//    float turn = (angle + M_PI) / M_2PI;
//    float radius = sqrt(p.x*p.x + p.y*p.y);
//    
//    float sine_kf = 19.0;//9.0 * sin(0.1*iGlobalTime);
//    float ka_wave_rate = 0.94;
//    float ka_wave = sin(ka_wave_rate*iGlobalTime);
//    float sine_ka = 0.35 * ka_wave;
//    float sine2_ka = 0.47 * sin(0.87*iGlobalTime);
//    float turn_t = turn + -0.0*iGlobalTime + sine_ka*sin(sine_kf*radius) + sine2_ka*sin(8.0 * angle);
//    bool turn_bit = mod(10.0*turn_t, 2.0) < 1.0;
//    
//    float blend_k = pow((ka_wave + 1.0) * 0.5, 1.0);
//    vec3 c;
//    if(turn_bit) {
//        c = blend_k * c1a + (1.0 -blend_k) * c1b;
//    } else {
//        c = blend_k * c2a + (1.0 -blend_k) * c2b;
//    }
//    c *= 1.0 + 1.0*radius;
//    
//    fragColor = vec4(c, 1.0);
//}





//void main(void)
//{
//    vec4 sum = vec4(0.0);
//
//    int x ;
//    int y ;
//
//    vec4 color = texture2D(u_texture,v_tex_coord);
//
//
//
//    for (x = -2; x <= 2; x++) {
//        for (y = -2; y <= 2; y++) {
//            vec2 offset = vec2(x,y) * 0.005;
//        }
//    }
//
//    gl_FragColor = ( sum / 25.0 ) + color ;
//}



//float noise(vec3 p) //Thx to Las^Mercury
//{
//    vec3 i = floor(p);
//    vec4 a = dot(i, vec3(1., 57., 21.)) + vec4(0., 57., 21., 78.);
//    vec3 f = cos((p-i)*acos(-1.))*(-.5)+.5;
//    a = mix(sin(cos(a)*a),sin(cos(1.+a)*(1.+a)), f.x);
//    a.xy = mix(a.xz, a.yw, f.y);
//    return mix(a.x, a.y, f.z);
//}
//
//float sphere(vec3 p, vec4 spr)
//{
//    return length(spr.xyz-p) - spr.w;
//}
//
//float flame(vec3 p)
//{
//    float d = sphere(p*vec3(1.,.5,1.), vec4(.0,-1.,.0,1.));
//    return d + (noise(p+vec3(.0,iGlobalTime*2.,.0)) + noise(p*3.)*.5)*.25*(p.y) ;
//}
//
//float scene(vec3 p)
//{
//    return min(100.-length(p) , abs(flame(p)) );
//}
//
//vec4 raymarch(vec3 org, vec3 dir)
//{
//    float d = 0.0, glow = 0.0, eps = 0.02;
//    vec3  p = org;
//    bool glowed = false;
//
//    for(int i=0; i<64; i++)
//    {
//        d = scene(p) + eps;
//        p += d * dir;
//        if( d>eps )
//        {
//            if(flame(p) < .0)
//                glowed=true;
//            if(glowed)
//                glow = float(i)/64.;
//        }
//    }
//    return vec4(p,glow);
//}
//
//void mainImage( out vec4 fragColor, in vec2 fragCoord )
//{
//    vec2 v = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
//    v.x *= iResolution.x/iResolution.y;
//
//    vec3 org = vec3(0., -2., 4.);
//    vec3 dir = normalize(vec3(v.x*1.6, -v.y, -1.5));
//
//    vec4 p = raymarch(org, dir);
//    float glow = p.w;
//
//    vec4 col = mix(vec4(1.,.5,.1,1.), vec4(0.1,.5,1.,1.), p.y*.02+.4);
//
//    fragColor = mix(vec4(0.), col, pow(glow*2.,4.));
//    //fragColor = mix(vec4(1.), mix(vec4(1.,.5,.1,1.),vec4(0.1,.5,1.,1.),p.y*.02+.4), pow(glow*2.,4.));
//
//}






void main() {
#define iterations 256
    
    vec2 position = v_tex_coord; // gets the location of the current pixel in the intervals [0..1] [0..1]
    vec3 color = vec3(0.0,0.0,0.0); // initialize color to black
    
    vec2 z = position; // z.x is the real component z.y is the imaginary component
    
    
    // Rescale the position to the intervals [-2,1] [-1,1]
    z *= vec2(3.0,2.0);
    z -= vec2(2.0,1.0);
    
    //vec2 c = z;
    vec2 c = vec2(-0.7 + cos(u_time) / 3.0,0.4 + sin(u_time) / 3.0);
    
    float it = 0.0; // Keep track of what iteration we reached
    for (int i = 0;i < iterations; ++i) {
        // zn = zn-1 ^ 2 + c
        
        // (x + yi) ^ 2 = x ^ 2 - y ^ 2 + 2xyi
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y);
        z += c;
        
        if (dot(z,z) > 4.0) { // dot(z,z) == length(z) ^ 2 only faster to compute
            break;
        }
        
        it += 1.0;
    }
    
//    if (it < float(iterations)) {
//        color.x = 1.0;
//    }
    if (it < float(iterations)) {
        color.x = sin(it / 3.0);
        color.y = cos(it / 6.0);
        color.z = cos(it / 12.0 + 3.14 / 4.0);
    }
    
    gl_FragColor = vec4(color,1.0);
}
