#!/bin/bash
core_counter=$((1))

ds="LED_a"
./synthethic_datasets.sh $ds "ConceptDriftStream -s (generators.LEDGeneratorDrift -d 1 -i JJ) -d (ConceptDriftStream -s (generators.LEDGeneratorDrift -d 3 -i JJ) -d (ConceptDriftStream -s (generators.LEDGeneratorDrift -d 5 -i JJ)  -d (generators.LEDGeneratorDrift -d 7 -i JJ) -w 50 -p 250000) -w 50 -p 250000) -w 50 -p 250000" ${core_counter} &
((core_counter=core_counter+1))

ds="LED_g"
./synthethic_datasets.sh $ds "ConceptDriftStream -s (generators.LEDGeneratorDrift -d 1 -i JJ) -d (ConceptDriftStream -s (generators.LEDGeneratorDrift -d 3 -i JJ) -d (ConceptDriftStream -s (generators.LEDGeneratorDrift -d 5 -i JJ)  -d (generators.LEDGeneratorDrift -d 7 -i JJ) -w 50000 -p 250000) -w 50000 -p 250000) -w 50000 -p 250000" ${core_counter} &
((core_counter=core_counter+1))

ds="LED"
./synthethic_datasets.sh $ds "generators.LEDGenerator -i JJ" ${core_counter} &
((core_counter=core_counter+1))

ds="AGR_a"
./synthethic_datasets.sh $ds "ConceptDriftStream -s (generators.AgrawalGenerator -f 1 -i JJ) -d (ConceptDriftStream -s (generators.AgrawalGenerator -f 2 -i JJ) -d (ConceptDriftStream -s (generators.AgrawalGenerator -f 3 -i JJ) -d (generators.AgrawalGenerator -f 4 -i JJ) -w 50 -p 250000) -w 50 -p 250000) -w 50 -p 250000" ${core_counter} &
((core_counter=core_counter+1))

ds="AGR_g"
./synthethic_datasets.sh $ds "ConceptDriftStream -s (generators.AgrawalGenerator -f 1 -i JJ) -d (ConceptDriftStream -s (generators.AgrawalGenerator -f 2 -i JJ) -d (ConceptDriftStream -s (generators.AgrawalGenerator -f 3 -i JJ) -d (generators.AgrawalGenerator -f 4 -i JJ) -w 50000 -p 250000) -w 50000 -p 250000) -w 50000 -p 250000" ${core_counter} &
((core_counter=core_counter+1))

ds="AGR"
./synthethic_datasets.sh $ds "generators.AgrawalGenerator -i JJ" ${core_counter} &
((core_counter=core_counter+1))

ds="RBF"
./synthethic_datasets.sh $ds "generators.RandomRBFGenerator -r JJ" ${core_counter} &
((core_counter=core_counter+1))

ds="RBF_s"
./synthethic_datasets.sh $ds "generators.RandomRBFGeneratorDrift -s .00001 -i JJ" ${core_counter} &
((core_counter=core_counter+1))

ds="RBF_m"
./synthethic_datasets.sh $ds "generators.RandomRBFGeneratorDrift -s .0001 -i JJ" ${core_counter} &
((core_counter=core_counter+1))

ds="RBF_f" 
./synthethic_datasets.sh $ds "generators.RandomRBFGeneratorDrift -s .001 -i JJ" ${core_counter} &
((core_counter=core_counter+1))

ds="HPlane"
./synthethic_datasets.sh $ds "generators.HyperplaneGenerator -i JJ -k 0" ${core_counter} &
((core_counter=core_counter+1))

ds="HPlane_s"
./synthethic_datasets.sh $ds "generators.HyperplaneGenerator -i JJ -t .00001" ${core_counter} &
((core_counter=core_counter+1))

ds="HPlane_m"
./synthethic_datasets.sh $ds "generators.HyperplaneGenerator -i JJ -t .0001" ${core_counter} &
((core_counter=core_counter+1))

ds="HPlane_f"
./synthethic_datasets.sh $ds "generators.HyperplaneGenerator -i JJ -t .001" ${core_counter} &
((core_counter=core_counter+1))

ds="Wave"
./synthethic_datasets.sh $ds "generators.WaveformGenerator -i JJ" ${core_counter} &
((core_counter=core_counter+1))

ds="Wform_d5n"
./synthethic_datasets.sh $ds "generators.WaveformGeneratorDrift -d 5 -i JJ -n" ${core_counter} &
((core_counter=core_counter+1))

ds="RTG"
./synthethic_datasets.sh $ds "generators.RandomTreeGenerator -i JJ" ${core_counter} &
((core_counter=core_counter+1))

for ds in $1/*.arff;
do
	dsfile=${ds#*/}
	dsname=${dsfile%.*}
	real_datasets.sh $ds $dsname $((core_counter*2)) &
	((core_counter=core_counter+1))
done