weblogs = LOAD '/user/training/weblogs/web*' USING PigStorage('\t')
        AS (
client_ip:chararray,
full_request_date:chararray,
day:int,
month:chararray,
month_num:int,
year:int,
hour:int,
minute:int,
second:int,
timezone:chararray,
http_verb:chararray,
uri:chararray,
http_status_code:chararray,
bytes_returned:chararray,
referrer:chararray,
user_agent:chararray
);
groups_fields = GROUP weblogs BY http_verb;
count = FOREACH groups_fields GENERATE group,COUNT(weblogs);
DUMP count;
