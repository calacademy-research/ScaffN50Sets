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
     usage: ScaffStructEx.py [-n <num>] [-all] <filename.fasta> <scaffold_name> [scaffold_name2 ...]  
            This version is extended (hence Ex) to work with FASTA format scaffold files  
            Shows the length, N50 and base pair / N structure of the scaffold <scaffold_name>  
               -n <num> sets number of longest runs of bases and of N's to show (default 10)  
               -all shows all the numbers of bases and Ns in a scaffold (use to view only small scaffs)  
               -ALL same as -all but for every scaffold (you'll want to redirect output to a file)  
            E.g., ScaffStructEx.py *.fasta scaffold132  

### Authorship

code author: James B. Henderson, jhenderson@calacademy.org  
README.md authors: Zachary R. Hanna, James B. Henderson  
