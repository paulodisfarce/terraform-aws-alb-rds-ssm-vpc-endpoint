![terraform](https://github.com/paulodisfarce/tier3-application/assets/83657152/737074a1-4f60-4c58-9414-37ee47558d56)

Procurando melhorar minhas boas práticas com Terraform, criei essa infra, baseada na foto acima. 
Utilizo ao todo 9 subnets de classe B, dividido em 3: ALB, ASG e RDS.
  . Subnet Publica para o ALB
  . Subnet privada para o ASG
  . Subnet privada para o RDS

No module network separei o security group pra ficar mais organizado, e usei locals para criar as regras de forma mais dinamica.

Nessa infra usei o Session Manager.  Fiz o atachamento da role entre SSM e EC2, assim evitando usar a porta 22/SSH, ou ip publicos, Bastion, etc. Após passar uma 'limpa' pretendo também adicionar o VPC Endpoint. 
Meu foco é criar um ppequeno artigo ensinando a conectar nas maquinas privadas usando SSM e VPC Endpoint, coisa simples mas bem feita.
