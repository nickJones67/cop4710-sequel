# output directory
COMPILE_DIR := out
SRC_DIR := src
SRC_FIlES := src/assert.c src/store.c src/commandHelpers.c src/retrieve.c
OUT_FILES := $(COMPILE_DIR)/lex.yy.o $(COMPILE_DIR)/sql.tab.o $(COMPILE_DIR)/sql.o $(COMPILE_DIR)/commandHelpers.o $(COMPILE_DIR)/assert.o $(COMPILE_DIR)/store.o $(COMPILE_DIR)/retrieve.o $(COMPILE_DIR)/drop.o

.PHONY: test clean parse

# Run this with 'make test', then './out/test'
test: src/test.c
	mkdir -p $(COMPILE_DIR)
	cc src/test.c src/assert.c src/store.c src/commandHelpers.c src/retrieve.c  -pedantic -Wall -Wno-unused-parameter -Wno-missing-braces -Wextra -Wuninitialized -g -std=gnu99 -o $(COMPILE_DIR)/test

clean:
	rm $(COMPILE_DIR)/sql.tab.h $(COMPILE_DIR)/sql.tab.c $(COMPILE_DIR)/lexer.h $(COMPILE_DIR)/*.o  $(COMPILE_DIR)/lex.yy.c $(COMPILE_DIR)/wSQLx


all: lex.yy.o sql.tab.o sql.o commandHelpers.o assert.o store.o retrieve.o drop.o
	cc -g  -std=gnu99 $(OUT_FILES) -o $(COMPILE_DIR)/wSQLx

sql.o: sql.c 
	cc -g -c sql.c -o $(COMPILE_DIR)/sql.o

sql.tab.o: sql.tab.c
	cc -g -c $(COMPILE_DIR)/sql.tab.c -o $(COMPILE_DIR)/sql.tab.o 

sql.tab.c: sql.y
	bison -d sql.y -b $(COMPILE_DIR)/sql

lex.yy.o: lex.yy.c 
	cc -g -c $(COMPILE_DIR)/lex.yy.c -o $(COMPILE_DIR)/lex.yy.o

lex.yy.c: sql.l sql.tab.c
	flex --header-file=$(COMPILE_DIR)/lexer.h --outfile=out/lex.yy.c  sql.l

commandHelpers.o: $(SRC_DIR)/commandHelpers.c
	cc -g -c $(SRC_DIR)/commandHelpers.c -o $(COMPILE_DIR)/commandHelpers.o -std=gnu99 

assert.o: $(SRC_DIR)/assert.c
	cc -g -c $(SRC_DIR)/assert.c -o $(COMPILE_DIR)/assert.o -std=gnu99

store.o: $(SRC_DIR)/store.c
	cc -g -c $(SRC_DIR)/store.c -o $(COMPILE_DIR)/store.o -std=gnu99

retrieve.o: $(SRC_DIR)/retrieve.c
	cc -g -c $(SRC_DIR)/retrieve.c -o $(COMPILE_DIR)/retrieve.o -std=gnu99

drop.o: $(SRC_DIR)/drop.c 
	cc -g -c $(SRC_DIR)/drop.c -o $(COMPILE_DIR)/drop.o -std=gnu99
