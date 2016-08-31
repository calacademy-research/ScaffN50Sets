#!/usr/bin/env python

# show ranges of contig lengths from a FASTA format file (sequence entries separated by ">" header lines

# usage: ScaffStructEx.py <filename.scafSeq> <scaffold_name> [scaffold_name2 ...]
# usage: ScaffStructEx.py -ALL <filename.fasta> 

import sys, time, re
#from collections import Counter
from math import floor

def scaffstruct(fname, scaff):
    scaff = scaff.strip().lower()+" "
    slen = len(scaff)+1
    
    fh = open(fname)
    ln = fh.readline().replace('\t', ' ').replace('\n', ' ') # SOAP version 1 used slighlty different format than SOAP version 2
    
    # print filename, scaff, slen, ln,

    while ln:
        if ln[0] == '>' and (ln[1:slen].lower() == scaff or showEveryScaffold):
            ln = showstruct(fh, ln[1:])
            if not showEveryScaffold: break
            else: continue
        ln = fh.readline().replace('\t', ' ').replace('\n', ' ') # SOAP version 1 used slightly different format than SOAP version 2
            
    fh.close()

def showstruct(fh, hdr): # presumes we are at the first line on the scaffold (line after > header line)
    ln = fh.readline().strip()
    if not ln:
        return
        
    aryBasesRuns = []
    aryNruns = []
        
    actgRun = 0; Nrun = 0; NrunCount = 0; chTotal = 0; Ntotal = 0
    if ln[0] != 'N':
        actgRun = 0 # 22Mar16 JBH change from 1 to fix off by 1 error handle 0 N run to set first scaff ACTG chr to count of 1
    else:
        Nrun = 1
    
    while ln and ln[0] != '>':
        for ch in ln:
            chTotal += 1
            if actgRun > 0:
                if ch != "N":
                    actgRun += 1
                else: # end of this run report it
                    if showAll:
                        print str(actgRun), #+"b",
                    aryBasesRuns.append(actgRun)
                    actgRun = 0
                    Nrun = 1
                    NrunCount += 1
            else:
                if ch == "N":
                    Nrun += 1
                else: # end of this run of N's report it
                    if Nrun > 0: # this is necessary to handle first char of scaffold wjen actgRun is 0
                        if showAll:
                            print str(Nrun)+"N",
                        aryNruns.append(Nrun)
                        Ntotal += Nrun
                        Nrun = 0
                    actgRun = 1
            
        ln = fh.readline().strip()
    
    aryBasesRuns.append(actgRun)
    pct = Ntotal/ (chTotal*1.0)
    if showAll:
        print str(actgRun) #+"b"
        if showEveryScaffold: #22Mar2016 JBH 
            return ln
    print hdr.strip(),
    print "{:,}".format(chTotal), "length,", len(aryBasesRuns), "contigs", NrunCount, "N runs totaling", "{:,}".format(Ntotal), "Ns,", percentStr(pct), "of total,",
    
    aryBasesRuns.sort(reverse=True)
    
    N50, numContigs = contigN50(chTotal-Ntotal, aryBasesRuns)
    print "N50", N50, "in", numContigs, "contigs"
    
    maxRuns = min(numTopRuns, len(aryBasesRuns))
    if maxRuns > 0:
        print "Top", str(maxRuns), "longest contigs:",
        for i in xrange(maxRuns):
            print str(aryBasesRuns[i]),
        
    maxRuns = min(numTopRuns, len(aryNruns))
    if maxRuns > 0:
        aryNruns.sort(reverse=True)
        print "\nTop", str(numTopRuns), "longest N runs: ",
        for i in xrange(maxRuns):
            print str(aryNruns[i]),
    print
    return ln

def percentStr(val, digits=2):
    val *= 10 ** (digits + 2)
    return '{1:.{0}f}%'.format(digits, floor(val) / 10 ** digits) 

def contigN50(contigTotalLen, aryDescContigLens):
    midPoint = contigTotalLen / 2
    totSoFar = 0
    contigsSoFar = 0
    N50contig = 0
    for contig_len in aryDescContigLens:
        totSoFar += contig_len
        contigsSoFar +=  1
        if totSoFar >= midPoint:
            N50contig = contig_len
            break
            
    return N50contig, contigsSoFar

filename = ""
scaffold = ""
numTopRuns = 10 # number of longest runs for Ns and for bases to show, defaults to 5
showAll = False; showEveryScaffold = False
addtlScaffolds = []
    
def main(): 
    global filename, scaffold, numTopRuns, showAll, showEveryScaffold, addtlScaffolds
    if len(sys.argv) >= 3:
        ixarg = 1
        while ixarg < len(sys.argv):
            arg = sys.argv[ixarg]
            if arg == '-all': # show all the entries number of bases followed by number of N's (only for small scaffs)
                showAll = True
            elif arg == '-ALL':
                showAll = True
                showEveryScaffold = True
            elif arg == '-n': # number following this is number of top base runs and number of longest n runs to show
                ixarg += 1
                if ixarg < len(sys.argv):
                    numTopRuns = int(sys.argv[ixarg])
            elif filename == '': # first non-flag argument is filename
                filename = arg
            elif scaffold == '': # second non-flag argument is the scaffold name
                scaffold = arg
            elif arg[:5] == "scaff": # additional scaffolds to process
                addtlScaffolds.append(arg)
            else:
                sys.stderr.write("Invalid argument " + arg + " to " + sys.argv[0] + "\n")
                exit(0)
            ixarg += 1
    
        if filename != "" and (scaffold != "" or showEveryScaffold):
            scaffstruct(filename, scaffold)
            if len(addtlScaffolds) > 0:
                for scaffname in addtlScaffolds:
                    scaffstruct(filename, scaffname)
                    
            sys.exit(0)
                        
    print("usage: ScaffStructEx.py [-n <num>] [-all] <filename.fasta> <scaffold_name> [scaffold_name2 ...]\n"
          "       This version is extended (hence Ex) to work with FASTA format scaffold files\n"
          "       Shows the length, N50 and base pair / N structure of the scaffold <scaffold_name>\n"
          "          -n <num> sets number of longest runs of bases and of N's to show (default 10)\n"
          "          -all shows all the numbers of bases and Ns in a scaffold (use to view only small scaffs)\n"
          "          -ALL same as -all but for every scaffold (you'll want to redirect output to a file)\n"
          "       E.g., ScaffStructEx.py *.fasta scaffold132\n"
          )

main()