require "open3"
require "tmpdir"

module PDFToolBox
	class MissingLibrary < StandardError
		def initialize 
			super("Could not find your library sucker")
		end
	end
	
	class Core 
		def initialize()
			raise MissingLibrary
		end
	end
	
end