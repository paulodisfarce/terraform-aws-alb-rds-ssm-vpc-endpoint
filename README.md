![terraform](https://github.com/paulodisfarce/tier3-application/assets/83657152/737074a1-4f60-4c58-9414-37ee47558d56)

Procurando melhorar minhas boas práticas com Terraform, criei essa infra, baseada na foto acima. 
Utilizo 3 subnets:
  . Subnet Publica para o ALB
  . Subnet privada para o ASG
  . Subnet pprivada para o RDS

No module network separei o security group pra ficar mais organizado, e usei locals para criar as regras de forma mais dinamica.

Nessa infra utilizo um Session Manager para fazer conexão remota direto pela AWS, assim evitando usar a porta 22/SSH, após passar uma 'limpa' pretendo também adicionar o VPC Endpoint. 
Meu foco é criar um ppequeno artigo ensinando a conectar nas maquinas privadas usando SSM e VPC Endpoint, coisa simples mas bem feita. 

