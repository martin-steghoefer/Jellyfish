#! /bin/sh

nCPUs=$(grep -c '^processor' /proc/cpuinfo)
pref=$(basename $0 .sh)
echo "Counting 19-mers, fastq format, on ${nCPUs} CPU"
../jellyfish/jellyfish count --fastq --matrix seq10m_matrix_19 -m 19 -t $nCPUs -o $pref -s 10000000 \
    --timing ${pref}.timing seq10m.fq
echo "c448e173e5e18264ed00fad0008d5340  -" > ${pref}.md5sum
../jellyfish/jellyfish qhisto -h 3 -i 0.01 -l 0 ${pref}_0 | md5sum -c ${pref}.md5sum
RET=$?

rm ${pref}.md5sum ${pref}_0

if [ -f ${pref}.timing ]; then
    cat ${pref}.timing
    rm ${pref}.timing
fi

exit $RET