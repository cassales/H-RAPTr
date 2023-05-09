#!/bin/bash
ds=$1
stream=$2
core=$3
RESDIR=ECAI-results-synthethic
mkdir -p $RESDIR

function X {
	ds=$1
	stream=$2
	iteration=$3
	core=$4
	echo "$ds $stream $iteration $core"
	echo "============================== $ds =============================="
	for method in "MC" "NBAdaptive";
	do
		# echo $method
		echo " ++++++++++++ OZABAG $method ++++++++++++ "
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBag -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/OzaLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-OzaLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBag -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/OzaHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-OzaHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBag -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/OzaLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-OzaLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBag -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/OzaHT-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-OzaHT-${method}-binSp-${ds}-iter${iteration}

		echo " ++++++++++++ OBAdwin $method ++++++++++++ "
		# meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -b -u -l MC) -s 11) -s (ArffFileStream -f /Users/gwcassales/Desktop/data/covtypeNorm.arff) -e (BasicClassificationPerformanceEvaluator -o) -i 100000
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/OADLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-OADLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/OADHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-OADHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/OADLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-OADLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/OADHT-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-OADHT-${method}-binSp-${ds}-iter${iteration}

		echo " ++++++++++++ SRP $method ++++++++++++ "
		# EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -b -u -l MC) -s 30) -s (ArffFileStream -f /Users/gwcassales/Desktop/data/covtypeNorm.arff) -e (BasicClassificationPerformanceEvaluator -o) -i 100000
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/SRPLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-SRPLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/SRPHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-SRPHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/SRPLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-SRPLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/SRPHT-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-SRPHT-${method}-binSp-${ds}-iter${iteration}

		echo " ++++++++++++ LBAG $method ++++++++++++ "
		#EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -b -u)) -s (ArffFileStream -f /Users/gwcassales/Desktop/data/covtypeNorm.arff) -e (BasicClassificationPerformanceEvaluator -o) -i 100000
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LBLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LBLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LBHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LBHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LBLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LBLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LBHT-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LBHT-${method}-binSp-${ds}-iter${iteration}

		echo " ++++++++++++ ARF $method ++++++++++++ "
		# EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (ARFHoeffdingTree -b -u -l MC) -s 10 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s (ArffFileStream -f /Users/gwcassales/Desktop/data/covtypeNorm.arff) -i 100000
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/ARFLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-ARFLRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/ARFHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-ARFHT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/ARFLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-ARFLRUPrune-T600-${method}-binSp-${ds}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/ARFHT-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-ARFHT-${method}-binSp-${ds}-iter${iteration}

		echo " ++++++++++++ standalone tree $method ++++++++++++ "
		echo "WINDOW 500"
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 300 -W 500) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T300-W500-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-W500-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 300 -W 500) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T300-W500-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-W500-${method}-binSp-${ds}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600 -W 500) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T600-W500-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-W500-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600 -W 500) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T600-W500-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-W500-${method}-binSp-${ds}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 1200 -W 500) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T1200-W500-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-W500-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 1200 -W 500) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T1200-W500-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-W500-${method}-binSp-${ds}-iter${iteration}
		
		echo "WINDOW 2000"
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 300) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T300-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 300) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T300-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-${method}-binSp-${ds}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T600-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-${method}-binSp-${ds}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 1200) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T1200-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 1200) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T1200-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-${method}-binSp-${ds}-iter${iteration}
		
		echo "WINDOW 10000"	
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 300) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T300-W10000-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-W10000-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 300) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T300-W10000-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-W10000-${method}-binSp-${ds}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T600-W10000-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-W10000-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T600-W10000-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-W10000-${method}-binSp-${ds}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 1200) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T1200-W10000-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-W10000-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 1200) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/LRUPrune-T1200-W10000-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-W10000-${method}-binSp-${ds}-iter${iteration}
		
		echo " ++++++++++++ baselines $method ++++++++++++ "
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/HT-${method}-binSp-${ds}-iter${iteration}.csv" > $RESDIR/term-HT-${method}-binSp-${ds}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s ($stream) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 1000000 -f 100000 -d $RESDIR/HT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}.csv" > $RESDIR/term-HT-${method}-binSp-g50-c005-t01-${ds}-iter${iteration}
	done
}

aux="$stream"
for ((i=1; i<=10; ++i));
do
	echo $i
	X $ds "${aux//JJ/$i}" $i $core
done		