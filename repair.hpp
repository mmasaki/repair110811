/* 
 *  Copyright (c) 2011 Shirou Maruyama
 * 
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following conditions
 *   are met:
 * 
 *   1. Redistributions of source code must retain the above Copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above Copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   3. Neither the name of the authors nor the names of its contributors
 *      may be used to endorse or promote products derived from this
 *      software without specific prior written permission.
 */

#ifndef REPAIR_H
#define REPAIR_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "basics.hpp"

#include <atomic>

typedef struct Sequence {
  CODE code;
  ulong next;
  ulong prev;
} SEQ;

typedef struct Pair {
  CODE left;
  CODE right;
  uint freq;
  ulong f_pos;
  ulong b_pos;
  struct Pair *h_next;
  struct Pair *p_next;
  struct Pair *p_prev;
} PAIR;

typedef struct RePair_data_structures {
  size_t txt_len;
  SEQ *seq;
  uint num_pairs;
  uint h_num;
  PAIR **h_first;
  uint p_max;
  PAIR **p_que;
  uint p_i;
} RDS;

typedef struct Rule {
  CODE left;
  CODE right;
} RULE;

typedef struct Dictionary {
  size_t txt_len;
  uint num_rules;
  RULE *rule;
  uint seq_len;
  CODE *comp_seq;
  uint buff_size;
} DICT;

DICT *RunRepair(char *target_filename, int threads);
void DestructDict(DICT *dict);
void OutputGeneratedCFG(DICT *dict, FILE *output);

#endif