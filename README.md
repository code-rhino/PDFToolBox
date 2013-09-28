PDFToolBox
==========
PDFToolBox is a Rails Gem that Combines alot of common functions that can come across when manipulating PDF files

Installation
==========
QPDF binary needs to be installed 
http://qpdf.sourceforge.net/

gem 'PDFToolBox' , :git => 'git@github.com:code-rhino/PDFToolBox.git'


USAGE
==========
    pdfbox = PDFToolBox::QPDF.new
    pdftk.decrypt("/path/to/locked.pdf", "/path/for/unlocked.pdf" )