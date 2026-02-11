#!/bin/bash
#SBATCH --account=bphl-umbrella
#SBATCH --qos=bphl-umbrella
#SBATCH --job-name=nextstrain_orov
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=arnold.rodriguezhilario@flhealth.gov
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=100gb
#SBATCH --time=2:00:00
#SBATCH --output=nextstrain_orov.%j.out
#SBATCH --error=nextstrain_orov.%j.err

# Load conda module and activate nextstrain environment
module load conda
conda activate nextstrain

# Run the ingest workflow
cd ingest/
nextstrain build .
cd ..

# Import sequences from Juno output and run nextstrain's phylogenetic workflow
python scripts/add_user_sequences.py --assembly-dir /blue/bphl-florida/arnold.rodriguez/repositories/bphl-molecular/Juno/output_reference/ --metadata my_samples.csv --rebuild
