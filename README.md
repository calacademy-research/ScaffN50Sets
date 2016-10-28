# ScaffSplitN50s

This is repository for a set of scripts to analyze the effect of different N cutoffs on contig N50 calculation
  
### Contents
This tool includes two separate scripts:  
ScaffStructEx.py  
ScaffSplitN50s.sh  

### Usage
$ git clone https://github.com/calacademy-research/ScaffSplitN50s.git  
$ cd ScaffSplitN50s  
\# Run "ScaffSplitN50s.sh" on a file in FASTA format to calculate continuity statistics  
$ ScaffSplitN50s.sh \<assembly_scaffolds_file.fasta\>  
\# The above will call ScaffStructEx.py to create a ".Nbreaks" file with a summary of the contig sizes and intervening runs of N's that is then used to calculate the reported assembly statistics

### Example output
$ ScaffSplitN50s.sh Seq_SOAP_33_GapClosed_ge300.fa
```
Creating Seq_SOAP_33_GapClosed_ge300.fa.Nbreaks
All Scaffolds
   Scaffold N50 3915799 L50 95 out of 48356 scaffolds in 1273290518 bp
   Contigs Split at 25Ns: N50 168721 L50 2109 out of 67949 contigs in 1259501544 bp
   Contigs Split at 20Ns: N50 164817 L50 2166 out of 68428 contigs in 1259490991 bp
   Contigs Split at 15Ns: N50 161269 L50 2220 out of 68909 contigs in 1259482799 bp
   Contigs Split at 10Ns: N50 156434 L50 2289 out of 69443 contigs in 1259476466 bp
   Contigs Split at  5Ns: N50 152072 L50 2344 out of 69967 contigs in 1259472826 bp
   Contigs Split at   1N: N50 50425 L50 7228 out of 106823 contigs in 1259435266 bp
Scaffolds 1000 bp or greater
   Scaffold N50 3983020 L50 92 out of 8113 scaffolds in 1255568683 bp
   Contigs Split at 25Ns: N50 171882 L50 2057 out of 27258 contigs in 1241846690 bp
   Contigs Split at 20Ns: N50 167327 L50 2112 out of 27729 contigs in 1241836309 bp
   Contigs Split at 15Ns: N50 163476 L50 2166 out of 28200 contigs in 1241828287 bp
   Contigs Split at 10Ns: N50 159062 L50 2233 out of 28719 contigs in 1241822133 bp
   Contigs Split at  5Ns: N50 155200 L50 2286 out of 29229 contigs in 1241818593 bp
   Contigs Split at   1N: N50 51301 L50 7054 out of 65092 contigs in 1241782051 bp
Scaffolds 500 bp or greater
   Scaffold N50 3937821 L50 93 out of 17952 scaffolds in 1262291236 bp
   Contigs Split at 25Ns: N50 170589 L50 2076 out of 37544 contigs in 1248502317 bp
   Contigs Split at 20Ns: N50 166062 L50 2132 out of 38023 contigs in 1248491764 bp
   Contigs Split at 15Ns: N50 162595 L50 2186 out of 38504 contigs in 1248483572 bp
   Contigs Split at 10Ns: N50 158193 L50 2254 out of 39038 contigs in 1248477239 bp
   Contigs Split at  5Ns: N50 153747 L50 2308 out of 39562 contigs in 1248473599 bp
   Contigs Split at   1N: N50 50930 L50 7119 out of 76379 contigs in 1248436081 bp
Scaffolds 300 bp or greater
   Scaffold N50 3915799 L50 95 out of 48356 scaffolds in 1273290518 bp
   Contigs Split at 25Ns: N50 168721 L50 2109 out of 67949 contigs in 1259501544 bp
   Contigs Split at 20Ns: N50 164817 L50 2166 out of 68428 contigs in 1259490991 bp
   Contigs Split at 15Ns: N50 161269 L50 2220 out of 68909 contigs in 1259482799 bp
   Contigs Split at 10Ns: N50 156434 L50 2289 out of 69443 contigs in 1259476466 bp
   Contigs Split at  5Ns: N50 152072 L50 2344 out of 69967 contigs in 1259472826 bp
   Contigs Split at   1N: N50 50425 L50 7228 out of 106823 contigs in 1259435266 bp
```

### Example output with NG50 and LG50 when supplying estimated genome size
estimated genome size = 1,400,000,000 base pairs (bp)  

$ ScaffSplitN50s.sh Seq_SOAP_33_GapClosed_ge300.fa 1400000000
```
Using Seq_SOAP_33_GapClosed_ge300.fa.Nbreaks All Scaffolds. Genome size 1400000000 bp
   Scaffold N50 3915799 L50 95 out of 48356 scaffolds in 1273290518 bp (NG50 3293697 LG50 112)
   Contigs Split at 25Ns: N50 168721 L50 2109 out of 67949 contigs in 1259501544 bp (NG50 146649 LG50 2554)
   Contigs Split at 20Ns: N50 164817 L50 2166 out of 68428 contigs in 1259490991 bp (NG50 143847 LG50 2622)
   Contigs Split at 15Ns: N50 161269 L50 2220 out of 68909 contigs in 1259482799 bp (NG50 140031 LG50 2688)
   Contigs Split at 10Ns: N50 156434 L50 2289 out of 69443 contigs in 1259476466 bp (NG50 136423 LG50 2772)
   Contigs Split at  5Ns: N50 152072 L50 2344 out of 69967 contigs in 1259472826 bp (NG50 133796 LG50 2837)
   Contigs Split at   1N: N50 50425 L50 7228 out of 106823 contigs in 1259435266 bp (NG50 44021 LG50 8721)
Scaffolds 1000 bp or greater
   Scaffold N50 3983020 L50 92 out of 8113 scaffolds in 1255568683 bp
   Contigs Split at 25Ns: N50 171882 L50 2057 out of 27258 contigs in 1241846690 bp
   Contigs Split at 20Ns: N50 167327 L50 2112 out of 27729 contigs in 1241836309 bp
   Contigs Split at 15Ns: N50 163476 L50 2166 out of 28200 contigs in 1241828287 bp
   Contigs Split at 10Ns: N50 159062 L50 2233 out of 28719 contigs in 1241822133 bp
   Contigs Split at 5Ns: N50 155200 L50 2286 out of 29229 contigs in 1241818593 bp
   Contigs Split at 1N: N50 51301 L50 7054 out of 65092 contigs in 1241782051 bp
Scaffolds 500 bp or greater
   Scaffold N50 3937821 L50 93 out of 17952 scaffolds in 1262291236 bp
   Contigs Split at 25Ns: N50 170589 L50 2076 out of 37544 contigs in 1248502317 bp
   Contigs Split at 20Ns: N50 166062 L50 2132 out of 38023 contigs in 1248491764 bp
   Contigs Split at 15Ns: N50 162595 L50 2186 out of 38504 contigs in 1248483572 bp
   Contigs Split at 10Ns: N50 158193 L50 2254 out of 39038 contigs in 1248477239 bp
   Contigs Split at  5Ns: N50 153747 L50 2308 out of 39562 contigs in 1248473599 bp
   Contigs Split at   1N: N50 50930 L50 7119 out of 76379 contigs in 1248436081 bp
Scaffolds 300 bp or greater
   Scaffold N50 3915799 L50 95 out of 48356 scaffolds in 1273290518 bp
   Contigs Split at 25Ns: N50 168721 L50 2109 out of 67949 contigs in 1259501544 bp
   Contigs Split at 20Ns: N50 164817 L50 2166 out of 68428 contigs in 1259490991 bp
   Contigs Split at 15Ns: N50 161269 L50 2220 out of 68909 contigs in 1259482799 bp
   Contigs Split at 10Ns: N50 156434 L50 2289 out of 69443 contigs in 1259476466 bp
   Contigs Split at  5Ns: N50 152072 L50 2344 out of 69967 contigs in 1259472826 bp
   Contigs Split at   1N: N50 50425 L50 7228 out of 106823 contigs in 1259435266 bp


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

### ScaffSplitN50s.sh description
$ head -n 21 ScaffSplitN50s.sh  
```
#!/bin/bash
# script for awk to compute N50 for various contig split thresholds (ie number of consecutive N's)
# also will extend to do the same set of extensions for those records >= 1000 and >= 500

# 03Sep2016 changed to check if input file is a fasta file (by checking if first character is a ">")
# and if it is then calls ScaffStructEx.py -ALL to create a file with Nbreaks extension
# that then is the input file. If input <fname> is fasta and <fname>.Nbreaks exists use this
# without creating it again

# 24Sep2016 start adding a feature to pass an genome size in so can calculate NG50
# along with regular N50
#

#input is file with each line referring to a scaffold with number of actg consec chars followed by number of N's etc.
# e.g. 1256 23N 4566 12N 233 100N 586
# above would have 2 contigs for C25N split, 3 for C20N split, 4 contigs for C10N split, and other N split arrays
# input file is created from an assembly fasta file by ScaffStructEx.py -ALL <asm_fasta_file>

# arrays holding contigs are named C_1N, C_5N, C_10N, C_15N, C_20N, C_25N and C_ALL

# we will call this awk script for all scaffolds where those scaffolds are >= 1000, >= 500, >= 300
```

### Citing
#### Authorship

Code author: James B. Henderson, jhenderson@calacademy.org  
README.md authors: Zachary R. Hanna, James B. Henderson  
