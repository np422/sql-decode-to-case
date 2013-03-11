##sql-convert-decode-to-case
==================

Convert oracle style deocde statements to "simple form" case statements

Useful for migrating from oracle to postgres.

If you use enterprisedb decode statement may work but case statements will give you better performance compared with decode. 

This is not thoroughly tested, but worked for me.

### Usage

    Usage: convert_decode_to_case [options]
        -h, --help                       Display usage information
        -v, --[no-]verbose               Run verbosely
        -p, --parallel                   Process all input files in parallel
        -i, --input-dir=INPUT            Read from INPUT, may be - for STDIN (default), a single file or the path to a directory containing multiple *.sql files to be processsed
        -o, --output-destination=DEST    Write output to DEST, if omitted STDOUT will be used if input is STDIN or a single file, if input is a directory a directory must be used as output destination
        -f, --force                      Overwrite existing output files

If run without any options it will read sql from STDIN and write converted sql to STDOUT.

### Example

testcase.sql have been used to test that decodes get converted in a reliable manner.
<pre>
$ <b>cat testcase.sql</b> 

SELECT DECODE(1 /* , () ' hello () ' */ , 1 , 'Return a string )' , 'else return something with ticks and a parenthesis '')''') FROM DUAL;

select decode /*(*/ (1 , 1 , 'what') from dual;

SELECT
  -- THIS DECODE( statement should not be included
DECODE( 1 , 1 , 'But this one should' )
FROM DUAL;

/* 

   /* 
      and a nested comment , lets try some DECODE( 
   */ 
  And another decode( 'with unbalanced parenthesis' , 'inside a comment' , 'should not be converted'
*/

SELECT 
DECODE( 

       DECODE( 1 , 1 , '( phony retval' ) , 

 -- Comment/newlines shoule be ignored

       '' , '' , 'y0 dAwG - I heard you liked decoeds - so I put a decode in your decode' 
       ) 
FROM DUAL;

SELECT DECODE( NVL(1,1) , 1 , 'foo', 2 , NVL('','bar') ) FROM DUAL;

/* Trailing comment */

$ <b>./convert_decode_to_case -i testcase.sql </b>

SELECT  CASE 1 /* , () ' hello () ' */  WHEN  1  THEN  'Return a string )'  ELSE  'else return something with ticks and a parenthesis '')''' END  FROM DUAL;

select  CASE 1  WHEN  1  THEN  'what' END  from dual;

SELECT
  -- THIS DECODE( statement should not be included
 CASE  1  WHEN  1  THEN  'But this one should'  END 
FROM DUAL;

/* 

   /* 
      and a nested comment , lets try some DECODE( 
   */ 
  And another decode( 'with unbalanced parenthesis' , 'inside a comment' , 'should not be converted'
*/

SELECT 
 CASE  

        CASE  1  WHEN  1  THEN  '( phony retval'  END   WHEN  

 -- Comment/newlines shoule be ignored

       ''  THEN  ''  ELSE  'y0 dAwG - I heard you liked decoeds - so I put a decode in your decode' 
        END  
FROM DUAL;

SELECT  CASE  NVL(1,1)  WHEN  1  THEN  'foo' WHEN  2  THEN  NVL('','bar')  END  FROM DUAL;

/* Trailing comment */

</pre>
