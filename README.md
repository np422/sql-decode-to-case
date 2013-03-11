##sql-convert-decode-to-case
==================

Convert oracle style deocde statements to "simple form" case statements

Useful for migrating from oracle to postgres.

Also if you use enterprisedb decode statement may work but case statements will give you better performance compared with decode. 

This is not thoroughly tested, but worked for me.

    Usage: convert_decode_to_case [options]
        -h, --help                       Display usage information
        -v, --[no-]verbose               Run verbosely
        -p, --parallel                   Process all input files in parallel
        -i, --input-dir=INPUT            Read from INPUT, may be - for STDIN (default), a single file or the path to a directory containing multiple *.sql files to be processsed
        -o, --output-destination=DEST    Write output to DEST, if omitted STDOUT will be used if input is STDIN or a single file, if input is a directory a directory must be used as output destination
        -f, --force                      Overwrite existing output files

