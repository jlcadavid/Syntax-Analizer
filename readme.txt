##Execute the following commands in the given order:
apt-get install lex -y
apt-get install gcc -y
lex regex-l
cc lex.yy.c -ll
./a.out script.c
