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
			#raise MissingLibrary if qpdf_version.to_f == 0
			@input_params[:qpdf_version] = qpdf_version
		end
		
		def self.locate_qpdf
			@qpdf_location ||= begin
				auto_path = %x{locate qpdf | grep "/bin/qpdf"}.strip.split("\n").first
				(auto_path.nil? || auto_path.empty?) ? nil : auto_path
        	end			
		end
		
		
		def qpdf_version
			%x{#{@input_params[:qpdf_path]} --version} #.scan(/version (\S*) Copyright (c)/).join
		end 
		
		def locate_qpdf
			self.class.locate_qpdf
		end
	end
	
end