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
``
`**$ cat testcase.sql**`
`    `
`    SELECT DECODE(1 /* , () ' hello () ' */ , 1 , 'Return a string )' , 'else return something with ticks and a parenthesis '')''') FROM DUAL;`
`    `
`    SELECT`
`      -- THIS DECODE( statement should not be included`
`    DECODE( 1 , 1 , 'But this one should' )`
`    FROM DUAL;`
`    `
`    /* And here are a comment`
`    `
`       /* `
`          and a nested comment , lets try some DECODE( `
`       */ `
`    `
`    */`
`    `
`    SELECT DECODE( DECODE( 1 , 1 , 'y0 DaWg , I heard you like decodes') , `
`     -- Comment/newlines shoule be ignored`
`     '' , 'foo' , ' - so I put a decode in your decode)' ) FROM DUAL;`
`    `
`    SELECT DECODE( NVL(a,1) , 1 , 'foo', 2 , NVL(b,'bar') ) FROM DUAL;`
`    `
`    /* Trailing comment */`
`    `
`    **$ ./convert_decode_to_case -i testcase.sql**`
`    `
`    SELECT  CASE 1 /* , () ' hello () ' */  WHEN  1  THEN  'Return a string )'  ELSE  'else return something with ticks and a parenthesis '')''' END  FROM DUAL;`
`    `
`    SELECT`
`      -- THIS DECODE( statement should not be included`
`     CASE  1  WHEN  1  THEN  'But this one should'  END` 
`    FROM DUAL;`
`    `
`    /* And here are a comment`
`    `
`       /* `
`          and a nested comment , lets try some DECODE( `
`       */ `
`    `
`    */`
`    `
`    SELECT  CASE   CASE  1  WHEN  1  THEN  'y0 DaWg , I heard you like decodes' END   WHEN  `
`     -- Comment/newlines shoule be ignored`
`     ''  THEN  'foo'  ELSE  ' - so I put a decode in your decode)'  END  FROM DUAL;`
`    `
`    SELECT  CASE  NVL(a,1)  WHEN  1  THEN  'foo' WHEN  2  THEN  NVL(b,'bar')  END  FROM DUAL;`
`    `
`    /* Trailing comment */`
``
