O arquivo .asoundrc deve ser criado no usuário Linux.

Para realizar a aquisição é necessário executar o comando a seguir no console.

arecord -D array3 -d 5 -c 3 -r 48000 -f S16_LE ./name.wav
