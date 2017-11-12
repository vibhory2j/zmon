#!/bin/bash

EXAMPLES=$(pwd)/../examples

echo -e "url: https://zmon-controller.stups-test.zalan.do/api/v1\ntoken:$(ztoken) \nverify: false" > .zmon-demo-config.yaml

for f in $EXAMPLES/check-definitions/*.yaml; do
    zmon -c .zmon-demo-config.yaml check-definitions update $f
done
for f in $EXAMPLES/entities/*.yaml; do
    zmon -c .zmon-demo-config.yaml entities push $f
done
for f in $EXAMPLES/alert-definitions/*.yaml; do
    zmon -c .zmon-demo-config.yaml alert-definitions create $f
done

for f in $EXAMPLES/dashboards/*.yaml; do
    # ZMON CLI updates the YAML file (sic!),
    # so use a temporary one
    temp=${f}.temp
    cp $f $temp
    zmon -c .zmon-demo-config.yaml dashboard update $temp
    rm $temp
done
