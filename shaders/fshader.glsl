#version 330

in vec4 color;
in vec4 normal;
in vec3 vertexPos;
in mat4 viewMatrix;

uniform vec3 u_lightDir;
uniform float u_ka;
uniform float u_kd;
uniform float u_ks;
uniform float u_shininess; //shininess coefficient

out vec4 frag_color;

void main () {
	vec3 N = normalize(normal.xyz); //normal vector
	vec3 L = normalize(u_lightDir - vertexPos); //vector toward light source
	vec3 V = -normalize(vertexPos); //vector toward viewer(0, 0, 0)
	vec3 R = 2*dot(L, N)*N - L; //ideal reflector 
	//can use function: R = reflect(-L, N);
	//vec3 H = normalize(L + V);  //halfway vector (Blinn-Phong)

	vec3 ambient = u_ka * color.xyz;
	vec3 diffuse = u_kd * max(dot(L, N), 0.0) * color.xyz;
	vec3 specular = u_ks * pow(max(dot(R, N), 0.0), u_shininess) * color.xyz;
	
	frag_color = vec4(ambient + diffuse + specular, 1.0);
}