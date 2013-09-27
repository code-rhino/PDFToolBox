require "open3"
require "tmpdir"

module PDFToolBox
	class MissingLibrary < StandardError
		def initialize (libname)
			super("Could not find your library #{libname}")
		end
	end
	
	class Core 
		def initialize()
			raise MissingLibrary("My Lib")
		end
	end
	
end