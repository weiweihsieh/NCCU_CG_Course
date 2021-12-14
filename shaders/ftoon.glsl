#version 330

in vec4 color;
in vec4 normal;
in mat4 viewMatrix;
in vec3 posInView;

uniform vec3 u_lightDir;

out vec4 frag_color;

void main () {
	vec3 N = normalize(normal.xyz); //normal vector
	vec3 L = normalize(u_lightDir - posInView); //vector toward light source
	vec3 V = -normalize(posInView); //vector toward viewer(0, 0, 0)
	vec3 R = 2*dot(L, N)*N - L; //ideal reflector 

	float ka = 0.1;
	float kd = 1.0;
	float ks = 1.0;
	float alpha = 100.0; //shininess coefficient

	vec3 ambient = ka * color.xyz;
	vec3 diffuse = kd * color.xyz;
	
	float intensity = max(dot(L, N), 0.0);
	//set thresholds
	if(intensity < 0.21)
		diffuse = diffuse * intensity;	
	else if(intensity < 0.49)
		diffuse = diffuse * intensity * 0.2;	
	else if(intensity < 0.65)
		diffuse = diffuse * intensity * 0.4;
	else if(intensity < 0.81)
		diffuse = diffuse * intensity * 0.6;
	else
		diffuse = diffuse * intensity * 0.8;
	
	vec3 specular = ks*pow(max(dot(R, N), 0.0), alpha) * color.xyz;
	
	frag_color = vec4(ambient + diffuse + specular, 1.0);
}