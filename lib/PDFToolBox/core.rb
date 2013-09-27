require "open3"
require "tmpdir"

module PDFToolBox
	class MissingLibrary < StandardError
		def initialize ()
			super("Could not find your library")
		end
	end
	
	class Core 
	
		attr_reader :input_params
		def initialize(input_params = {})
			@input_params = input_params
			@input_params[:qpdf_path] ||= locate_qpdf || "qpdf"
			#raise MissingLibrary
		end
		
		def self.locate_qpdf
			@pdftk_location ||= begin
				auto_path = %x{locate qpdf | grep "/bin/qpdf"}.strip.split("\n").first
				(auto_path.nil? || auto_path.empty?) ? nil : auto_path
        	end			
		end
		
		def locate_qpdf
			self.class.locate_qpdf
		end
	end
	
end