#!/bin/bash
#this scripts removes the useful data from the last iteration of a PSMC run
#pass a *.psmc file in on the command line and this prints a tab delimited
#table of the data from the psmc run
echo 'k	t_k	lambda_k	pi_k	\sum_{l\not=k}A_{kl}	A_{kk}'
numOfDataPoints=$(grep 'RS' $1 | tail -n 1 | cut -f2)
grep 'RS' $1 | tail -n "$numOfDataPoints" | cut -f2-

