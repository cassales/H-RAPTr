#!/bin/bash
RESDIR=ECAI-results-realds
mkdir -p $RESDIR
ds=$1
dsname=$2
core=$3

function X {
	ds=$1
	dsname=$2
	iteration=$3
	core=$4
	echo "$ds $dsname $iteration $core"
	for method in "MC" "NBAdaptive";
	do
		echo " ++++++++++++ OZABAG $method ++++++++++++ "
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBag -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/OzaLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-OzaLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBag -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/OzaHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-OzaHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBag -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/OzaLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-OzaLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBag -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/OzaHT-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-OzaHT-${method}-binSp-${dsname}-iter${iteration}

		echo " ++++++++++++ OBAdwin $method ++++++++++++ "
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/OADLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-OADLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/OADHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-OADHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/OADLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-OADLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.OzaBagAdwin -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/OADHT-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-OADHT-${method}-binSp-${dsname}-iter${iteration}

		echo " ++++++++++++ SRP $method ++++++++++++ "
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/SRPLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-SRPLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/SRPHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-SRPHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/SRPLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-SRPLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.StreamingRandomPatches -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/SRPHT-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-SRPHT-${method}-binSp-${dsname}-iter${iteration}

		echo " ++++++++++++ LBAG $method ++++++++++++ "
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LBLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LBLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LBHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LBHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LBLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LBLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.LeveragingBag -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LBHT-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LBHT-${method}-binSp-${dsname}-iter${iteration}

		echo " ++++++++++++ ARF $method ++++++++++++ "
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s 30 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/ARFLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-ARFLRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s 30 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/ARFHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-ARFHT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s 30 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/ARFLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-ARFLRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (meta.AdaptiveRandomForest -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s 30 -x (ADWINChangeDetector -a 0.001) -p (ADWINChangeDetector -a 0.01)) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/ARFHT-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-ARFHT-${method}-binSp-${dsname}-iter${iteration}

		echo " ++++++++++++ standalone tree $method ++++++++++++ "
		echo "WINDOW 500"
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 300 -W 500) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T300-W500-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-W500-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 300 -W 500) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T300-W500-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-W500-${method}-binSp-${dsname}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600 -W 500) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T600-W500-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-W500-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600 -W 500) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T600-W500-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-W500-${method}-binSp-${dsname}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 1200 -W 500) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T1200-W500-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-W500-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 1200 -W 500) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T1200-W500-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-W500-${method}-binSp-${dsname}-iter${iteration}

		echo "WINDOW 2000"
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 300) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T300-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 300) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T300-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-${method}-binSp-${dsname}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-${method}-binSp-${dsname}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 1200) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T1200-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 1200) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T1200-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-${method}-binSp-${dsname}-iter${iteration}
		
		echo "WINDOW 10000"
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 300 -W 10000) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T300-W10000-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-W10000-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 300 -W 10000) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T300-W10000-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T300-W10000-${method}-binSp-${dsname}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 600 -W 10000) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T600-W10000-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-W10000-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 600 -W 10000) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T600-W10000-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T600-W10000-${method}-binSp-${dsname}-iter${iteration}
		echo "--- LRU gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method} -u -T 1200 -W 10000) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T1200-W10000-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-W10000-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- LRU std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method} -u -T 1200 -W 10000) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/LRUPrune-T1200-W10000-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-LRUPrune-T1200-W10000-${method}-binSp-${dsname}-iter${iteration}
		
		echo " ++++++++++++ baselines $method ++++++++++++ "
		echo "--- HT gct ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -g 50 -c 0.05 -t 0.1 -b -l ${method}) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/HT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}.csv" > $RESDIR/term-HT-${method}-binSp-g50-c005-t01-${dsname}-iter${iteration}
		echo "--- HT std ---"
		numactl -C $core java -Xmx24G -cp lib/moa.jar:lib -javaagent:lib/sizeofag-1.0.4.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l (trees.LRUPruneHoeffdingTree -b -l ${method}) -s (ArffFileStream -f $ds) -e (BasicClassificationPerformanceEvaluator -o -p -r) -i 10000000 -f 100000 -d $RESDIR/HT-${method}-binSp-${dsname}-iter${iteration}.csv" > $RESDIR/term-HT-${method}-binSp-${dsname}-iter${iteration}
	done
}

for ((i=1; i<=10; ++i));
do
	X $ds $dsname $i $core
done