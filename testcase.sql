
SELECT DECODE(1 /* , () ' hello () ' */ , 1 , 'Return a string )' , 'else return something with ticks and a parenthesis '')''') FROM DUAL;

SELECT
  -- THIS DECODE( statement should not be included
DECODE( 1 , 1 , 'But this one should' )
FROM DUAL;

/* And here are a comment

   /* 
      and a nested comment , lets try some DECODE( 
   */ 

*/

SELECT DECODE( DECODE( 1 , 1 , 'y0 DaWg , I heard you like decodes') , 
 -- Comment/newlines shoule be ignored
 '' , 'foo' , ' - so I put a decode in your decode)' ) FROM DUAL;

SELECT DECODE( NVL(a,1) , 1 , 'foo', 2 , NVL(b,'bar') ) FROM DUAL;

/* Trailing comment */

