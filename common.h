#pragma once

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "lexer.h"
#include "sql.tab.h"
#include <stdbool.h>
#include <unistd.h>
#include <time.h>
#include "assert.h"

#define PARSETREE_SIZE sizeof(struct ParseTree)
#define WHERE_SIZE sizeof(struct Where)
#define FIELD_SIZE sizeof(struct Field)
#define TUPLE_SIZE sizeof(struct Tuple)
#define FIELD_LIMIT 100 // max num of columns
#define NAME_LIMIT 30 // Max length for user-provided names
#define VALUE_LIMIT 50 // Max length for user-provided values
#define HEADER_SIZE FIELD_LIMIT*(NAME_LIMIT+4) // +4 (1 delimeter, 3 type chars)
#define RECORD_SIZE FIELD_LIMIT*(VALUE_LIMIT+1) // +1 for delimeter
#define PATH_SIZE 1000
#define DATABASE_DIR "out/databases"

// Defines what database we're currently working on
char* currentDatabase;

typedef enum {
  INTEGER_t='I',
  DATE_t='D',
  TEXT_t='T',
} FieldType;

struct Field {
  char* name;
  void* value;
  FieldType fieldType;
};

struct Tuple {
  struct Field* primaryKey;
  struct Field* fields;
  int updatedAt;
};

typedef enum {
  LESS_THAN,
  GREATHER_THAN,
  // ...
} whereCompare;

struct Where {
  struct Field* field;
  void* target;
  whereCompare compareType;
};

/*
 * The most important struct
 * in this whole program.
 * Please note, by conventions
 * Field pointers should be NULL
 * terminated
 */
struct ParseTree {
  enum {
    CREATE_DATABASE_t,
    CREATE_TABLE_t,
    DROP_DATABASE_t,
    DROP_TABLE_t,
    SAVE_t,
    LOAD_DATABASE_t,
    SELECT_t,
    wSELECT_t,
    INSERT_t,
    UPDATE_t,
    DELETE_t
  } commandType;
  char* table; // name of table
  struct Field* fields;
  struct Where* whereConstraints;
};

struct Table {
  struct Tuple* tuples;
  int count;
  char name[NAME_LIMIT];
};

struct ParseTree* parseGrammer(char* sql);

// Store/Retrieve
bool store(struct ParseTree* tuples);

struct Table* retrieve_table(struct ParseTree* tree); // Tuple list returned must be NULL terminated.

void createDatabase(struct ParseTree* createCommand);
void createTable(struct ParseTree* parseTree);
void setDatabase(char*);
void computePadding(char*, char*, int);
int getRecordCount(FILE* file);
int getFieldCount(char* buffer, int size);

struct Tuple* retrieve_tuple(struct ParseTree tree); // Tuple list returned must be NULL terminated.
