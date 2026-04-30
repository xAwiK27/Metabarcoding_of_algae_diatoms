## Creation of all directories needed to store raw and analyzed data

mkdir code/
mkdir plots/
mkdir -p data/results
mkdir -p data/fastqs
mkdir -p data/poly-G-trimmed
mkdir -p data/html
mkdir -p data/metadata

#if NOT already present in the data/metadata/ directory
cp /tmp/GEN711-811_data/MassDEP/metadata/rename-2025.tsv data/metadata/
cp /tmp/GEN711-811_data/MassDEP/metadata/MA_2022-2023-2024-metadata.tsv data/metadata/

