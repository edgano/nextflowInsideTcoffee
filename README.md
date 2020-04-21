# Run Nextflow inside TCoffee

This pipeline is proposed to run the methods of ```dynamic.pl``` from Tcoffee using Nextflow.

To define the input files it can be used the variable ```params.input```. The output files will be stored in ```params.outdir``` and to define the flags for the perl script we should use ```params.flags```.

Docker/Singularity is "needed" to reproduce an enviroment with all the software running without problem. It should be possible to run without it if tcoffee and 3rd party software is properly installed. A "internal" variabe ```dynamicDirectory``` is defined to decide which ```dynamic.pl``` script run (from the repository or the one from docker)



