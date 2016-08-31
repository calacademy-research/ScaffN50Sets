# ScaffSplitN50s

This is repository for a set of scripts to analyze the effect of different N cutoffs on contig N50 calculation

This tool includes two separate scripts:  
ScaffStruct.py  
ScaffSplitN50s.sh  

### Usage
\# First run "ScaffStruct.py" on a file in FASTA format in order to create a file with a summary of the contig sizes and intervening runs of N's  
$ python ScaffStruct.py -ALL \<scaffolds_file.fasta\> \>\<output_file.Nruns\>  
\# Next run "ScaffSplitN50s.sh" to calculate continuity statistics using your new summary file  
$ ./ScaffSplitN50s.sh \<output_file.Nruns\> \>\<output_file_N50stats.txt\>  

### ScaffStructEx.py options
$ python ScaffStructEx.py  
```
usage: ScaffStructEx.py [-n <num>] [-all] <filename.fasta> <scaffold_name> [scaffold_name2 ...]
       This version is extended (hence Ex) to work with FASTA format scaffold files
       Shows the length, N50 and base pair / N structure of the scaffold <scaffold_name>
          -n <num> sets number of longest runs of bases and of N's to show (default 10)
          -all shows all the numbers of bases and Ns in a scaffold (use to view only small scaffs)
          -ALL same as -all but for every scaffold (you'll want to redirect output to a file)
       E.g., ScaffStructEx.py *.fasta scaffold132
```

### ScaffSplitN50s.sh options
$ head -n 12 ScaffSplitN50s.sh  
```
#!/bin/bash
# script for awk to compute N50 for various contig split thresholds (ie number of consecutive N's)
# also will extend to do the same set of extensions for those records >= 1000 and >= 500

#input is file with each line referring to a scaffold with number of actg consec chars followed by number of N's etc.
# e.g. 1256 23N 4566 12N 233 100N 586
# above would have 2 contigs for C25N split, 3 for C20N split, 4 contigs for C10N split, and other N split arrays
# input file is created from an assembly fasta file by scaffstruct_ex.py -ALL <asm_fasta_file>

# arrays holding contigs are named C_1N, C_5N, C_10N, C_15N, C_20N, C_25N and C_ALL

# we will call this awk script for all scaffolds those scaffs >= 1000, >= 500, >= 300
```

### Authorship

code author: James B. Henderson, jhenderson@calacademy.org  
README.md authors: Zachary R. Hanna, James B. Henderson  
