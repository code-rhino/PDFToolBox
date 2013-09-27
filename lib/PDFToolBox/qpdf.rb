require 'tempfile'

module PDFToolBox
	class QPDF
		attr_reader :core
		def initialize()
			@core = Core.new()
			"Hello World"
		end
	end
end