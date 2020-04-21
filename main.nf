#!/usr/bin/env nextflow

/*
 * Copyright (c) 2017-2018, Centre for Genomic Regulation (CRG) and the authors.
 *
 *   This file is part of 'XXXXXX'.
 *
 *   XXXXXX is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   XXXXXX is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with XXXXXX.  If not, see <http://www.gnu.org/licenses/>.
 */

/* 
 * Main XXX pipeline script
 *
 * @authors
 * Edgar Garriga

 */

/*
 * defaults parameter definitions
 */
params.input ="$baseDir/data/*.fa"

params.outdir="$baseDir/results/"

params.flags="-method famsa_msa"

dynamicDirectory="/tcoffee/t_coffee/src/"
//dynamicDirectory="$baseDir/bin/"


log.info """\
         D y n a m i c   T c o f f e e    P  i  p  e  l  i  n  e  ~  version 0.1"
         ======================================="
         Input files  (DIRECTORY)                       : ${params.input}
         Flags                                          : ${params.flags}
         Output directory (DIRECTORY)                   : ${params.outdir}
         """
         .stripIndent()


// Channels containing sequences
if ( params.input ) {
  Channel
  .fromPath(params.input)
  .map { item -> [ item.baseName, item] }
  .set { seqs }
}


process dynamicRun {
    tag "${id}"
    publishDir "${params.outdir}/", mode: 'copy', overwrite: true

    input:
      set val(id), file(seqs) from seqs

    output:
      file("*.aln") into dynamicOut

    script:
    """
    ${dynamicDirectory}dynamic.pl -seq ${seqs} -outfile ${id}.aln $params.flags
    """
}

workflow.onComplete {
  println "Execution status: ${ workflow.success ? 'OK' : 'failed' } runName: ${workflow.runName}"
}
