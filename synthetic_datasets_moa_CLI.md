
LED_a "ConceptDriftStream -s (generators.LEDGeneratorDrift -d 1 -i 1) -d (ConceptDriftStream -s (generators.LEDGeneratorDrift -d 3 -i 1) -d (ConceptDriftStream -s (generators.LEDGeneratorDrift -d 5 -i 1)  -d (generators.LEDGeneratorDrift -d 7 -i 1) -w 50 -p 250000) -w 50 -p 250000) -w 50 -p 250000"

LED_g "ConceptDriftStream -s (generators.LEDGeneratorDrift -d 1 -i 1) -d (ConceptDriftStream -s (generators.LEDGeneratorDrift -d 3 -i 1) -d (ConceptDriftStream -s (generators.LEDGeneratorDrift -d 5 -i 1)  -d (generators.LEDGeneratorDrift -d 7 -i 1) -w 50000 -p 250000) -w 50000 -p 250000) -w 50000 -p 250000"

LED "generators.LEDGenerator -i 1"

AGR_a "ConceptDriftStream -s (generators.AgrawalGenerator -f 1 -i 1) -d (ConceptDriftStream -s (generators.AgrawalGenerator -f 2 -i 1) -d (ConceptDriftStream -s (generators.AgrawalGenerator -f 3 -i 1) -d (generators.AgrawalGenerator -f 4 -i 1) -w 50 -p 250000) -w 50 -p 250000) -w 50 -p 250000"

AGR_g "ConceptDriftStream -s (generators.AgrawalGenerator -f 1 -i 1) -d (ConceptDriftStream -s (generators.AgrawalGenerator -f 2 -i 1) -d (ConceptDriftStream -s (generators.AgrawalGenerator -f 3 -i 1) -d (generators.AgrawalGenerator -f 4 -i 1) -w 50000 -p 250000) -w 50000 -p 250000) -w 50000 -p 250000"


AGR "generators.AgrawalGenerator -i 1"


RBF "generators.RandomRBFGenerator -r 1"


RBF_s "generators.RandomRBFGeneratorDrift -s .00001 -i 1"


RBF_m "generators.RandomRBFGeneratorDrift -s .0001 -i 1"


RBF_f "generators.RandomRBFGeneratorDrift -s .001 -i 1"


HPlane "generators.HyperplaneGenerator -i 1 -k 0"


HPlane_s "generators.HyperplaneGenerator -i 1 -t .00001"


HPlane_m "generators.HyperplaneGenerator -i 1 -t .0001"


HPlane_f "generators.HyperplaneGenerator -i 1 -t .001"


Wave "generators.WaveformGenerator -i 1"


Wform_d5n "generators.WaveformGeneratorDrift -d 5 -i 1 -n"


RTG "generators.RandomTreeGenerator -i 1"