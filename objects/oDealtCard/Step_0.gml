/// @description 

percent += c
elastic = easeOutElastic(percent)

x = lerp(startX, finalX, elastic);
y = lerp(startY, finalY, elastic);

if percent >= 1 {instance_destroy()}
