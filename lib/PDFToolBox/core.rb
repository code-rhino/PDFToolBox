require "open3"
require "tmpdir"

module PDFToolBox
	class MissingLibrary < StandardError
		def initialize ()
			super("QPDF is not installed on your system.")
		end
	end
	
	class Core 
	
		attr_reader :input_params
		def initialize(input_params = {})
			@input_params = input_params
			@input_params[:qpdf_path] ||= locate_qpdf || "qpdf"
			raise MissingLibrary if pdftk_version.to_f == 0
		end
		
		def self.locate_qpdf
			@pdftk_location ||= begin
				auto_path = %x{locate qpdf | grep "/bin/qpdf"}.strip.split("\n").first
				(auto_path.nil? || auto_path.empty?) ? nil : auto_path
        	end			
		end
		
		
		def qpdf_version
			%x{#{@input_params[:qpdf_path]} --version 2>&1}.scan(/version (\S*) Copyright/).join
		end 
		
		def locate_qpdf
			self.class.locate_qpdf
		end
	end
	
end