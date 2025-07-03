"# Projeto-Monitoramento-AWS-Compass"

Projeto - Monitoramento de Site na AWS com Nginx e Alertas via Discord
Objetivo
Desenvolver e testar habilidades em Linux, AWS e automação de processos através da configuração de um ambiente de servidor web monitorado.

Estrutura de Pastas
html/: Página HTML simples.
scripts/: Script de monitoramento Bash.
imagens/: Prints de tela.

Etapas:
a. Como Configurar o Ambiente (AWS) A primeira etapa consiste em preparar a infraestrutura na nuvem da AWS para hospedar nossa aplicação.

1.Lançamento da Instância EC2 Uma máquina virtual (instância EC2) foi criada com as seguintes especificações:
Nome: ServidorWeb-Projeto

AMI (Amazon Machine Image): Ubuntu Server 22.04 LTS

Tipo de Instância: t2.micro (Elegível para o nível gratuito)

Par de Chaves (Key Pair): Um novo par de chaves .pem foi criado e baixado para permitir o acesso seguro via SSH.

2.Configuração de Rede e Segurança (Security Group) Para permitir o acesso externo, a instância foi configurada com:
IP Público: Habilitado para ser acessível pela internet.

Security Group: Um firewall virtual com as seguintes regras de entrada (Inbound Rules):

Tipo SSH: Porta 22, Origem My IP (para acesso restrito ao desenvolvedor).

Tipo HTTP: Porta 80, Origem Anywhere (0.0.0.0/0) (para permitir que qualquer usuário acesse o site).

3.Conexão via SSH O acesso ao terminal do servidor é feito através do SSH, utilizando a chave privada baixada.
Permissão da Chave (no computador local):

![image](https://github.com/user-attachments/assets/6333aaef-3f91-4e03-8551-db3cd88a2126)


Comando de Conexão:

![image](https://github.com/user-attachments/assets/e1d73c40-cfb2-4d08-95db-75eeaee80c2a)


b. Como Instalar e Configurar o Servidor Web Com o ambiente pronto, o próximo passo é instalar e configurar o servidor web Nginx.

1.Instalação do Nginx Os seguintes comandos foram executados no servidor para instalar e habilitar o Nginx:

![image](https://github.com/user-attachments/assets/857f3576-9d13-4272-a624-f3ea74edf774)
![image](https://github.com/user-attachments/assets/7ec026d0-272e-4ce1-aa3f-8d7166e4a97b)
![image](https://github.com/user-attachments/assets/70017f77-aa89-4c14-979e-f97825c0b34a)


3.Criação de uma Página Personalizada Uma página HTML simples foi criada para ser exibida como a página inicial do site.
Comando para criar o arquivo:

![image](https://github.com/user-attachments/assets/55b0d047-3a5d-4531-93d4-fdf48264b44f)


Conteúdo do index.html:

https://github.com/felipemgilioli/Projeto-Monitoramento-AWS/tree/92dc7ebaf6555bc127c1e0d49d0aa3250e367a10/html

c. Como Funciona o Script de Monitoramento Para garantir a disponibilidade do site, um script em Bash foi desenvolvido para verificar o status do servidor e enviar alertas.

1.Lógica do Script O script monitor.sh realiza as seguintes ações:
Verifica o Site: Usa o comando curl para fazer uma requisição HTTP para o servidor local (http://Seu_IP).

Analisa a Resposta: Captura o código de status HTTP da resposta. Um código 200 significa sucesso.

Gera Logs: Registra a data, hora e o resultado (sucesso ou falha) em um arquivo de log em /var/log/monitoramento/monitoramento.log.

Envia Alerta: Se o código de status for diferente de 200, o script envia uma mensagem de alerta para um canal do Discord através de um Webhook.

2.Código do Script (monitor.sh)
https://github.com/felipemgilioli/Projeto-Monitoramento-AWS/blob/d802138402a7d02c0590b01ceaba465891df2929/script/monitor.sh

3.Automação com Cron Para que o script rode automaticamente a cada minuto, uma tarefa cron foi configurada.
Comando para editar as tarefas cron:

![image](https://github.com/user-attachments/assets/70fb94a5-8fbc-4c6d-9f58-555fb7caa9d0)


Linha adicionada ao crontab:

![image](https://github.com/user-attachments/assets/c376e045-14e1-48b7-b5df-52b137ca32ef)


d. Como Testar e Validar a Solução A validação final garante que todos os componentes estão funcionando em conjunto.

1.Teste de Sucesso Ação: Acessar o IP Público da instância EC2 em um navegador.
Resultado Esperado: A página HTML personalizada é exibida corretamente.

Verificação: O arquivo de log /var/log/monitoramento/monitoramento.log deve conter entradas de "SUCESSO".

2.Teste de Falha Ação: Parar o serviço do Nginx intencionalmente.

![image](https://github.com/user-attachments/assets/750ac6ab-f9a4-4877-9626-99969f2cde17)


Resultado Esperado:

Após um minuto, uma notificação de "ALERTA!" deve chegar no canal configurado do Discord.

O arquivo de log deve registrar uma nova entrada de "FALHA".

Ao tentar acessar o site pelo navegador, a conexão deve falhar.

3.Ajuste Final: Fuso Horário Por padrão, o servidor utiliza o fuso horário UTC. Para que os logs registrassem o horário local do Brasil, o fuso foi ajustado.
Comando para alterar o fuso horário:

![image](https://github.com/user-attachments/assets/3bfb9565-e435-4dcf-acc6-8dcc9782323b)
