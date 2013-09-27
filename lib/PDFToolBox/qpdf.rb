require 'tempfile'

module PDFToolBox
	class QPDF
		attr_reader :core
		
		def initialize(input_params = {})
			@core = Core.new(input_params)
		end
		
		def input_params 
			@core = Core.input_params
		end
		
		def decrypt(infile="", outfile="")
			operation = {:in_file_path => infile , :out_file_path => outfile , :operation ="--decrypt"}
			@core.qpdf(operation)
		end 
	end
end