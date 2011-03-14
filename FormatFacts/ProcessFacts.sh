rm csvout
rm csvout.processed

echo sorting facts
ruby GroupSortFacts.rb FactsMasterList.csv > /dev/null

echo removing bad characters
sed -f RemoveBadChars csvout > csvout.processed
