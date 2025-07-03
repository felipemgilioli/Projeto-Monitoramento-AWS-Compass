"# Projeto-Monitoramento-AWS" 



# Projeto - Monitoramento de Site na AWS com Nginx e Alertas via Discord


## Objetivo
Desenvolver e testar habilidades em Linux, AWS e automação de processos através da configuração de um ambiente de servidor web monitorado.

## Estrutura de Pastas

- html/: Página HTML simples.
- scripts/: Script de monitoramento Bash.
- imagens/: Prints de tela.

## Etapas:

a. Como Configurar o Ambiente (AWS)
A primeira etapa consiste em preparar a infraestrutura na nuvem da AWS para hospedar nossa aplicação.

1. Lançamento da Instância EC2
Uma máquina virtual (instância EC2) foi criada com as seguintes especificações:

Nome: ServidorWeb-Projeto

AMI (Amazon Machine Image): Ubuntu Server 22.04 LTS

Tipo de Instância: t2.micro (Elegível para o nível gratuito)

Par de Chaves (Key Pair): Um novo par de chaves .pem foi criado e baixado para permitir o acesso seguro via SSH.


2. Configuração de Rede e Segurança (Security Group)
Para permitir o acesso externo, a instância foi configurada com:

IP Público: Habilitado para ser acessível pela internet.

Security Group: Um firewall virtual com as seguintes regras de entrada (Inbound Rules):

Tipo SSH: Porta 22, Origem My IP (para acesso restrito ao desenvolvedor).

Tipo HTTP: Porta 80, Origem Anywhere (0.0.0.0/0) (para permitir que qualquer usuário acesse o site).


3. Conexão via SSH
O acesso ao terminal do servidor é feito através do SSH, utilizando a chave privada baixada.

Permissão da Chave (no computador local):

![image](https://github.com/user-attachments/assets/b90c184a-cc3e-4f1f-ba70-0a6f331f48c8)

Comando de Conexão:

![image](https://github.com/user-attachments/assets/bd92cb56-b9a5-481a-8e0b-dd9f2238955b)



b. Como Instalar e Configurar o Servidor Web
Com o ambiente pronto, o próximo passo é instalar e configurar o servidor web Nginx.

1. Instalação do Nginx
Os seguintes comandos foram executados no servidor para instalar e habilitar o Nginx:

![image](https://github.com/user-attachments/assets/b6efcae0-e313-459c-9089-8e367104a1e6)
![image](https://github.com/user-attachments/assets/21d8ac4d-e152-4bd9-8602-2899718fb6dd)
![image](https://github.com/user-attachments/assets/b5d6c54b-6930-489d-bdfc-6daaae132c72)


3. Criação de uma Página Personalizada
Uma página HTML simples foi criada para ser exibida como a página inicial do site.

Comando para criar o arquivo:

![image](https://github.com/user-attachments/assets/2be5a685-0c39-4194-97a6-26db3927c89c)

Conteúdo do index.html:

https://github.com/felipemgilioli/Projeto-Monitoramento-AWS-Compass/blob/36bcc94504a8ef21bc3d565877b94c96d8d3497c/html/index.html 

c. Como Funciona o Script de Monitoramento
Para garantir a disponibilidade do site, um script em Bash foi desenvolvido para verificar o status do servidor e enviar alertas.

1. Lógica do Script
O script monitor.sh realiza as seguintes ações:

Verifica o Site: Usa o comando curl para fazer uma requisição HTTP para o servidor local (http://Seu_IP).

Analisa a Resposta: Captura o código de status HTTP da resposta. Um código 200 significa sucesso.

Gera Logs: Registra a data, hora e o resultado (sucesso ou falha) em um arquivo de log em /var/log/monitoramento/monitoramento.log.

Envia Alerta: Se o código de status for diferente de 200, o script envia uma mensagem de alerta para um canal do Discord através de um Webhook.

2. Código do Script (monitor.sh)

https://github.com/felipemgilioli/Projeto-Monitoramento-AWS-Compass/blob/30218298f731ad5d3677a4bd0cfbd23e77afed4f/script/monitor.sh

3. Automação com Cron
Para que o script rode automaticamente a cada minuto, uma tarefa cron foi configurada.

Comando para editar as tarefas cron:

![image](https://github.com/user-attachments/assets/bab1a707-8357-490d-aaad-8d6d1d2968e1)

Linha adicionada ao crontab:

![image](https://github.com/user-attachments/assets/4495a441-77b8-46bc-bfb6-b5ee70d1ec96)


d. Como Testar e Validar a Solução
A validação final garante que todos os componentes estão funcionando em conjunto.

1. Teste de Sucesso
Ação: Acessar o IP Público da instância EC2 em um navegador.

Resultado Esperado: A página HTML personalizada é exibida corretamente.

Verificação: O arquivo de log /var/log/monitoramento/monitoramento.log deve conter entradas de "SUCESSO".

2. Teste de Falha
Ação: Parar o serviço do Nginx intencionalmente.

![image](https://github.com/user-attachments/assets/1da694fc-a001-48aa-90b7-d2f2e7d3f129)

Resultado Esperado:

Após um minuto, uma notificação de "ALERTA!" deve chegar no canal configurado do Discord.

O arquivo de log deve registrar uma nova entrada de "FALHA".

Ao tentar acessar o site pelo navegador, a conexão deve falhar.

3. Ajuste Final: Fuso Horário
Por padrão, o servidor utiliza o fuso horário UTC. Para que os logs registrassem o horário local do Brasil, o fuso foi ajustado.

Comando para alterar o fuso horário:

![image](https://github.com/user-attachments/assets/b89cd9d9-37e8-4b38-b261-8ee537dd0e92)
