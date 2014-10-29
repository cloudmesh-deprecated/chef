#!/bin/bash
for i in `ls ../cookbooks`
do
	echo $i
	echo '{ "run_list": ["recipe['$i']"] }' > /tmp/run_list.json
	chef-solo -j /tmp/run_list.json &> $i.output
done
