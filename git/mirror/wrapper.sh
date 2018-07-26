#!/bin/sh

repos="vim_cf3 cfbot nustuff delta_reporting evolve_cfengine_freelib terraform-modules www.watson-wilson.ca thewaves"

for next_repo in $repos
do
   echo ./gitmirror.py -g2b neilhwatson/$next_repo neilhwatson/$next_repo
   ./gitmirror.py -g2b neilhwatson/$next_repo neilhwatson/$next_repo
done
