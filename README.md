# ScaffSplitN50s

This is repository for a set of scripts to analyze the effect of different N cutoffs on contig N50 calculation

This tool includes two separate scripts:
ScaffSplitN50s.sh
scaffstruct_ex.py

### Usage
\# First run "scaffstruct_ex.py" on a file in FASTA format in order to create a file with a summary of the contig sizes and intervening runs of N's  
$ scaffstruct_ex.py -ALL <scaffolds_file.fasta> ><output_file.Nruns>  
\# Next run "ScaffSplitN50s.sh" to calculate continuity statistics using your new summary file  
$ ScaffSplitN50s.sh <output_file.Nruns> ><output_file_N50stats.txt>  

### Authorship

code author: James B. Henderson, jhenderson@calacademy.org  
README.md authors: Zachary R. Hanna, James B. Henderson  
