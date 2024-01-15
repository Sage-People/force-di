if [[ -f apexTestResults/test/test-result.txt ]]; then #1
    echo "Results found"
    # get list of failed tests | trim for class.test name only
    step1=$(grep -w 'Fail' apexTestResults/test/test-result.txt)
    echo "done step 1"
    echo "$step1"
    step2=$(grep -F -e 'fHCM2' apexTestResults/test/test-result.txt)
    echo "done step 2"
    echo "$step2"
    grep -v --line-buffered "Fail" apexTestResults/test/test-result.txt >> apexTestResults/test/step1.txt
    echo apexTestResults/test/step1.txt
    grep -v --line-buffered "fHCM2" apexTestResults/test/step1.txt >> apexTestResults/test/step2.txt
    echo apexTestResults/test/step2.txt
    failed=$(awk {'print $1'} -f apexTestResults/test/step2.txt)            
    echo "Parsed test results"
    echo "$failed"
    if [[ -z "$failed" ]]; then #2
        echo "Tests passed"
        exit 0
    else #2
        echo "One or more tests failed"
        exit 1
    fi #2
else #1
    echo "File apexTestResults/test/test-result.txt not found - tests did not run"
    exit 1		
fi #1
