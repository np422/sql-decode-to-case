
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

SELECT
    id AS "DECODE(",
    decode ( decode ( status,
            'A',
            'A',
            'B',
            'B',
            'other' )
,
        'A',
        'Accepted',
        'D',
        'Denied',
        'Other' ) AS ")"
FROM
    contracts;
SELECT
    id AS "decode(",
    decode ( decode ( status,
            'A',
            'A',
            'B',
            'B',
            'other' )
,
        'A',
        'Accepted',
        'D',
        'Denied',
        'Other' ) AS ")"
FROM
    contracts;
SELECT
    id AS "decode",
    decode ( decode ( status,
            'A',
            'A',
            'B',
            'B',
            'other' )
,
        'A',
        'Accepted',
        'D',
        'Denied',
        'Other' ) AS ")"
FROM
    contracts;
SELECT
    id AS /* asdf1 */ -- asdf2
    decode,
    decode ( decode ( status,
            'A',
            'A',
            'B',
            'B',
            'other' )
,
        'A',
        'Accepted',
        'D',
        'Denied',
        'Other' ) AS change
FROM
    contracts;