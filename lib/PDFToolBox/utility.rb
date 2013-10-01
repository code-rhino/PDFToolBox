require 'tempfile'

module PDFToolBox
	class Utility
		attr_reader :core
		
		def initialize(input_params = {})
			@Core = Core.new(input_params)
		end
		
		def input_params 
			@Core = Core.input_params
		end
		
		# Sometimes PDF files are encrypted, when this is the case you can not maniputlate the PDF before it is unlocked
		# This function well create a unlocked version of the file
		def decrypt(infile="", outfile="")
			operation = {:in_file_path => infile , :out_file_path => outfile , :operation =>"--decrypt"}
			@Core.qpdf(operation)
		end
		
		def combinePDFscat(ranges = [], outfile="")
			inrange = ""		
			ranges.each do |range|
				inrange << range['pdf']+" "
			end
			operation = {:input_range => inrange , :output => outfile , :operation => "cat"}
			@Core.pdftk(operation)
		end
		
	end
end