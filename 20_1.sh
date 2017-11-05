#!/bin/sh

PROGRAM_LIST=$(awk -F\" '
$4 != "-" && $6 != "-" {
  split($6, program, "/")
  sum[program[1]]+=1  
  }
END{
for(i in sum){
  print i, sum[i]
  }
}
' log.txt| sort -k 2,2nr| head -10)

TOTAL_COUNT=$(echo "$PROGRAM_LIST"| awk '{total = total + $2} END {print total}')

echo "$PROGRAM_LIST" | awk -v total=$TOTAL_COUNT '
{

  printf("%d. %s - %d - %.2f%%\n",NR, $1, $2, $2/total*100)
}
'
