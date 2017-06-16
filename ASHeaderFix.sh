#
#  ASHeaderFix.sh
#  AnobiScript
#
#  Created by Stanislav Pletnev on 2017-03-15
#  Copyright © 2017 Anobisoft. All rights reserved.
#

tmp=$(mktemp)
for fn in $(find . -name '*.[hm]' -o -name '*.swift')
do
{
created=$(git log --format=%at $fn | tail -1)
author=$(git log --format=%an $fn | tail -1 | sed 's/User\|Anobisoft/Stanislav Pletnev/')

echo '//
//  '${fn##*/}'
//  '${PWD##*/}'
//
//  Created by '$author' on '$(date -d@$created +%Y-%m-%d)'
//  Copyright © '$(date -d@$created +%Y)' Anobisoft. All rights reserved.
//
'
} > $tmp
tail -n$(($(wc -l $fn | awk '{ print $1; }')-$(wc -l $tmp | awk '{ print $1; }'))) $fn >> $tmp
cat $tmp > $fn
done

rm $tmp

