##sql-convert-decode-to-case
==================

Convert oracle style deocde statements to "simple form" case statements

Useful for migrating from oracle to postgres.

Also if you use enterprisedb decode statement may work but case statements will give you better performance compared with decode. 

This is not thoroughly tested, but worked for me.

### Usage
    Usage: convert_decode_to_case [options]
        -h, --help                       Display usage information
        -v, --[no-]verbose               Run verbosely
        -p, --parallel                   Process all input files in parallel
        -i, --input-dir=INPUT            Read from INPUT, may be - for STDIN (default), a single file or the path to a directory containing multiple *.sql files to be processsed
        -o, --output-destination=DEST    Write output to DEST, if omitted STDOUT will be used if input is STDIN or a single file, if input is a directory a directory must be used as output destination
        -f, --force                      Overwrite existing output files

### Example

    $ echo "SELECT DECODE(1 /* , () ' hello () ' */ , 1 , 'Return a string )' , 'else return something with ticks and a parenthesis '')''') FROM DUAL;"  > /tmp/input.sql
    $  ./convert_decode_to_case  -i /tmp/input.sql -f -o /tmp/output.sql
    $ cat /tmp/output.sql 
    SELECT  CASE 1 /* , () ' hello () ' */  WHEN  1  THEN  'Return a string )'  ELSE  'else return something with ticks and a parenthesis '')''' END  FROM DUAL;
