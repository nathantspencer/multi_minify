# multi_minify

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nathantspencer/webknossos_toolkit/blob/master/LICENSE.md)

Created to minify batches which may contain many different file formats, multi_minify is an all-in-one minification tool written in Perl. Presently, multi_minify support minification of the following file formats:
 - JSON (`.json`)
 
## Setup

To use multi_minify, you'll first need to install the provided module, which contains subroutines used by many of the individual language minifiers. Intallation is simple: open a terminal in the `multi_minify/` directory and enter the following commands.
``` 
perl Makefile.PL
make
make install
```
 
## Usage

### Batch Mode

To minify a batch of files, simply run `multi_minify.pl` as follows, providing an input directory and an output directory.

``` 
$ perl multi_minify.pl "/path/to/input/files/" "/path/to/output/files"
```

Minified files will be written in the provided output directory with `min_` prepended to each of their names.

Files in the input directory which do not belong to a supported file format will be ignored.

### Single File

To minify a single file, just provide an input file path and output file path instead as follows.

```
$ perl multi_minify.pl "/path/to/inputfile.json" "path/to/outputfile.json"
```

Note that in this case, the output file will be created with the provided name.

A prefix such as `min_` will not be added to the output file's name.


## Minification Details

The minification technique for each supported file format is given below.

 - **JSON:** Newlines are removed. Spaces and tabs are removed unless they occur inside of double quotes.


## Contact

Still have questions? Contact me at ntspencer@mix.wvu.edu and I'll get back to you as quickly as possible!
