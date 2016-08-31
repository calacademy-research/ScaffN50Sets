#!/bin/bash
# script for awk to compute N50 for various contig split thresholds (ie number of consecutive N's)
# also will extend to do the same set of extensions for those records >= 1000 and >= 500

#input is file with each line referring to a scaffold with number of actg consec chars followed by number of N's etc.
# e.g. 1256 23N 4566 12N 233 100N 586
# above would have 2 contigs for C25N split, 3 for C20N split, 4 contigs for C10N split, and other N split arrays
# input file is created from an assembly fasta file by ScaffStructEx.py -ALL <asm_fasta_file>

# arrays holding contigs are named C_1N, C_5N, C_10N, C_15N, C_20N, C_25N and C_ALL

# we will call this awk script for all scaffolds where those scaffolds are >= 1000, >= 500, >= 300
declare -a arr=(0 1000 500 300)

for Scaffold_Cutoff_Val in "${arr[@]}"
do
    awk  -v Scaffold_Cutoff="$Scaffold_Cutoff_Val" '
        BEGIN { FS = " "
                prefix = "   "
                if (Scaffold_Cutoff == 0)
                    print "All Scaffolds"
                else
                    print "Scaffolds " Scaffold_Cutoff " bp or greater "
        }
        {   # each line represents a scaffold and its runs of actg and Ns
            scaf_sz = 0; for(f=1;f<=NF;f++){ scaf_sz += int($f) }
            if (scaf_sz >= Scaffold_Cutoff) {
                tot_scaf_sz += scaf_sz
                C_ALL[0] = 0; C_25N[0] = 0; C_20N[0] = 0; C_15N[0] = 0; C_10N[0] = 0; C_5N[0] = 0; C_1N[0] = 0; # kludge so can pass array into function
                addContigs(C_ALL,  0)
                tot_25N_sz += addContigs(C_25N, 25)
                tot_20N_sz += addContigs(C_20N, 20)
                tot_15N_sz += addContigs(C_15N, 15)
                tot_10N_sz += addContigs(C_10N, 10)
                tot_5N_sz  += addContigs(C_5N,   5)
                tot_1N_sz  += addContigs(C_1N,   1)
            }
        }
        #NR >= 200000 { exit } # this is easy way to limit number of records for testing purposes
        END {
            delete C_ALL[0]; delete C_25N[0]; delete C_20N[0]; delete C_15N[0]; delete C_10N[0]; delete C_5N[0]; delete C_1N[0]; # remove kludge value put in to start things off
            asort(C_ALL); asort(C_25N); asort(C_20N); asort(C_15N); asort(C_10N); asort(C_5N); asort(C_1N)
    
            Calc_N50_set(tot_scaf_sz)
        }
        function addContigs(C_Ary, splitAt) {
            if (splitAt == 0) { # no splits
                C_Ary[length(C_Ary)] = scaf_sz # append size of entire scaffold
                return scaf_sz
            }
            scaffold_contig_len = 0
            cur_contig_len = 0 # length of current contig, acgt runs with N runs less than splitAt length
            for (f=1; f<=NF; f++) {
                cur_contig_len += int( $f ) # odd numbered fields always actg runs
                f++
                if (f < NF) { # if more fields, then there is an N run after this actg run
                    num_Ns = int( $f )
                    if (num_Ns >= splitAt) {
                        C_Ary[length(C_Ary)] = cur_contig_len
                        scaffold_contig_len += cur_contig_len
                        cur_contig_len = 0 # start on next contig
                    }
                    else # since Ns did not split it, consider them part of contig
                        cur_contig_len += num_Ns
                }
            }
            
            scaffold_contig_len += cur_contig_len
            C_Ary[length(C_Ary)] = cur_contig_len
    
            return scaffold_contig_len
        }
        function Calc_N50_set(total_sz) { # total_sz is different when excluding smaller scaffolds
            Calc_N50(C_ALL, length(C_ALL), total_sz) # N50 and L50 for scaffolds is in N50_L50_Values
            Prt_Inf("Scaffold N50 ", length(C_ALL), total_sz)
            
            Calc_N50(C_25N, length(C_25N), tot_25N_sz) # N50 and L50 for contigs split at 25Ns
            Prt_Contig_Inf("25Ns", length(C_25N), tot_25N_sz)
            
            Calc_N50(C_20N, length(C_20N), tot_20N_sz) # N50 and L50 for contigs split at 20Ns
            Prt_Contig_Inf("20Ns", length(C_20N), tot_20N_sz)
                    
            Calc_N50(C_15N, length(C_15N), tot_15N_sz) # N50 and L50 for contigs split at 15Ns
            Prt_Contig_Inf("15Ns", length(C_15N), tot_15N_sz)
                    
            Calc_N50(C_10N, length(C_10N), tot_10N_sz) # N50 and L50 for contigs split at 10Ns
            Prt_Contig_Inf("10Ns", length(C_10N), tot_10N_sz)
                    
            Calc_N50(C_5N, length(C_5N), tot_5N_sz) # N50 and L50 for contigs split at 5Ns
            Prt_Contig_Inf(" 5Ns", length(C_5N), tot_5N_sz)
                    
            Calc_N50(C_1N, length(C_1N), tot_1N_sz) # N50 and L50 for contigs split at a single N
            Prt_Contig_Inf("  1N", length(C_1N), tot_1N_sz)
        }   
        function Calc_N50(C_Ary, lngth, tot_size) {
            N50_cutoff = int( (tot_size+1) / 2 )
            # print "N50 cutoff " N50_cutoff
            contigs_lens_sofar = 0; num_contigs = 0; N50_contig = 0
            for (i=lngth; i >= 1; i--) { # loop thru biggest contigs to smallest and stop when we are at N50_cutoff
                contigs_lens_sofar += C_Ary[i]
                num_contigs++
                if (contigs_lens_sofar >= N50_cutoff) {
                    N50_contig = C_Ary[i]
                    break
                }
            }
            N50_L50_Values[1] = N50_contig; N50_L50_Values[2] = num_contigs
            return N50_L50_Values[1]
        }
        function Prt_Contig_Inf(splitAtStr, lngth, size) {
            typ = "Contigs Split at " splitAtStr
            print prefix typ ": N50 "N50_L50_Values[1] " L50 " N50_L50_Values[2] " out of " lngth " contigs in " size " bp"
       }
        function Prt_Inf(typ, lngth, size) {
            print prefix typ N50_L50_Values[1] " L50 " N50_L50_Values[2] " out of " lngth " scaffolds in " size " bp"
        }
    ' $1
done