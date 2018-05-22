# Descrição

O desafio consiste em construir um ambiente, em algum serviço cloud,
contendo os seguintes recursos:

- Load Balancer
- Aplicação Web: 2 réplicas de algum serviço REST ou páginas estáticas
(servidos pelo Load Balancer a ser criado)
- Resolução de DNS para o Load Balancer
- Automatização do processo de build da Aplicação Web e implantação de
todos os recursos no serviço cloud utilizado

Recursos adicionais:
- Infraestrutura como código
- Suporte Multi AZ
- Conteinerização sem camadas subjacentes (Fargate)
- Auto Scaling

# Implementação

Para a resolução do desafio, foi escolhido o AWS como serviço de núvem.

As tecnologias escolhidas foram:
*   Docker: Modelo de conteinerização
*   Terraform: Infraestrutura como código
*   AWS ECS: Serviço de orquestração de contêiners
*   AWS Fargate: É um método de execução no ECS para gerenciamento de
contêineres sem camadas subjacentes
*   AWS Codebuild: Serviço de compilação
*   AWS Pipeline: Serviço de integração contínua
*   AWS S3: Serviço de Armazenamento

## A Aplicação
Um servidor web apresentando o nome identificador do container atual

## Terraform

O Terraform possibilita declarar recursos a serem provisionados
em diversas estruturas de nuvem. Nesta implementação utilizaremos a AWS
como serviço de núvem.

Para facilitar o entendimento e maximizar o reuso os recursos foram
divididos em módulos.

### Estrutura
    terraform
    ├── modules
    │ └── codepipeline    (Módulo 3)
    │ └── ecs             (Módulo 2)
    └── terraform.tf      (Principal)

### Principal
-  Declara os módulos 1, 2 e 3

### Módulo 1: VPC
Utilizando o módulo [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/1.31.0)
do registro oficial do terraform. É possível provisionar todos os recursos
de rede necessários para o teste atual de forma muito simples. Ele facilita
a criação Multi AZ, subredes privadas e públicas, Grupos de Redes, DHCP,
Tabela de roteamento, Rotas e outros.

### Módulo 2: ECS
Módulo local contendo todos os objetos e configurações necessárias para
executar a aplicação com balanceamento, conteinerizada e sem camadas
subjacentes.

-  Cria o repositório no ECR para guardar as imagens do docker
-  Cria um cluster ECS
-  Cria um serviço ECS do tipo Fargate, com suas políticas de segurança
-  Cria uma tarefa para inicialização da aplicação
-  Declara as características do container em um template JSON
-  Configura o Balanceador de carga na rede pública, ele irá direcionar
as requisições para o serviço ECS.
-  Configura os grupos de segurança, portas e permissões.
-  Configuração do Auto scaling com métricas e gatilhos via CloudWatch
-  Cria logs no cloudwatch

### Módulo 3: Code Pipeline
Módulo local contendo todos os objetos e configurações necessárias para
executar a integração e entrega contínua como serviço na AWS.

Após um novo push no repositório, o CodePipeline irá baixar o código e
chamar o CodeBuild que irá compilar o código. Após compilado a imagem
Docker será enviada para o Registro Docker do ECR e o deploy será feito.

É definido:

-  Configuração das permissões
-  Parâmetros do repositório do fonte
-  Configurações da compilação da imagem
-  Configurações do deploy

## Execução

    terraform init # Download do módulo terraform-aws-modules/vpc/aws e outros
    GITHUB_TOKEN=token terraform apply # Provisionamento e execução

[Criação de Token pessoal de acesso GitHub](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)

# Próximos passos

-  Criar um serviço no backend.


# Referências

-   https://www.udemy.com/learn-devops-infrastructure-automation-with-terraform/learn/v4/overview
-   https://www.udemy.com/aws-certified-solutions-architect-associate/learn/v4
-   https://thecode.pub/easy-deploy-your-docker-applications-to-aws-using-ecs-and-fargate-a988a1cc842f
