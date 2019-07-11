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
careers_visitors = FILTER weblogs BY uri == '/careers';
select_fields = FOREACH careers_visitors GENERATE client_ip;
DUMP select_fields;

