#define TNumLights 32    
// It should be better
struct TLight {
    vec2 Pos;
    float Power;
};

extern TLight Lights[TNumLights];
extern int numLights;

extern vec2 Screen;

const float constant  = 1.0;
const float linear    = 0.09;
const float quadratic = 0.008; //0032

vec4 effect(vec4 color, Image image, vec2 uvs, vec2 screen_coords){
    vec4 pixel = Texel(image, uvs);
    vec2 normScreen = screen_coords / Screen;
    vec3 Diffuse = vec3(1,1,1);
    for (int i=0; i<numLights; i++) {
        TLight Light = Lights[i];
        vec2 normPos = Light.Pos / Screen;
        float Distance = length(normPos - normScreen) * Light.Power;
        float Attenuation = 1.0 / (constant + linear * Distance + quadratic * (Distance * Distance));
        Diffuse *= Attenuation;
    }
    Diffuse = clamp(Diffuse, 0.0, 1.0);


    return pixel * vec4(Diffuse,1.0);
}  