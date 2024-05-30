# Brick-Breaker-Assembly

Este projeto é um clássico jogo de Brick Breaker desenvolvido em linguagem Assembly. Ele roda no DOSBox, um emulador x86 com DOS.

## Tabela de Conteúdos

- [Introdução](#introdução)
- [Recursos](#recursos)
- [Instalação](#instalação)
- [Uso](#uso)
- [Arquitetura do Projeto](#arquitetura-do-projeto)
- [To-Do](#to-do)
- [Contribuição](#contribuição)
- [Licença](#licença)

## Introdução

Brick Breaker é um jogo onde o jogador controla uma raquete para bater uma bola em direção a uma parede de blocos. O objetivo é destruir todos os blocos fazendo a bola ricochetear na raquete e nos blocos. O jogo termina quando todos os blocos são destruídos ou a bola cai abaixo da raquete.

Este projeto é escrito em linguagem Assembly, o que proporciona um desafio e uma experiência de aprendizado única. Ele roda no DOSBox, um emulador x86 com DOS, tornando-o acessível em sistemas operacionais modernos.

## Recursos

- Movimento da raquete usando controles de teclado.
- Movimento da bola e colisão com paredes e raquete.
- Gráficos simples renderizados em um ambiente DOS.
- Jogo pausável e reiniciável.
- Detecção de colisão com blocos e remoção dos mesmos.

## Instalação

Para rodar este jogo, você precisa do DOSBox instalado no seu computador. Siga estes passos para configurá-lo:

1. **Baixar e Instalar o DOSBox:**
   - [Download do DOSBox](https://www.dosbox.com/download.php?main=1)

2. **Clonar o Repositório:**
    ```
    git clone https://github.com/seuusuario/Brick-Breaker-Assembly.git
    cd Brick-Breaker-Assembly
    ```

3. **Compilar o Código Assembly:**
   - Você precisa de um assembler como NASM ou MASM para compilar o código.
   - Para NASM:
     ```
     nasm -f bin brick_breaker.asm -o brick_breaker.com
     ```

4. **Rodar o Jogo no DOSBox:**
   - Abra o DOSBox.
   - Monte o diretório do jogo:
     ```
     mount c /path/to/Brick-Breaker-Assembly
     c:
     ```
   - Rode o jogo:
     ```
     brick_breaker.com
     ```

## Uso

- **Controles:**
  - Use as teclas `a` e `d` ou as setas para mover a raquete para a esquerda e direita.
  - Pressione `P` para pausar e retomar o jogo.
  - Pressione `Q` para sair do jogo.
  - Pressione `Enter` para iniciar o jogo.
  - Após o fim do jogo, pressione `Y` para reiniciar ou `N` para sair.

- **Objetivo:**
  - O objetivo do jogo é destruir todos os blocos fazendo a bola ricochetear na raquete e nos blocos.
  - O jogo termina quando todos os blocos são destruídos ou a bola cai abaixo da raquete.

## To-Do

- Detecção de colisão com blocos.
- Remoção de blocos ao serem atingidos.
- Implementação da lógica de vitória do jogo.
- Melhor organização do código, dividindo funções.

## Contribuição

Contribuições são bem-vindas! Se você deseja contribuir, siga estes passos:

1. Faça um fork do repositório.
2. Crie uma nova branch (`git checkout -b feature-branch`).
3. Commit suas mudanças (`git commit -am 'Add new feature'`).
4. Push para a branch (`git push origin feature-branch`).
5. Crie um novo Pull Request.

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.
