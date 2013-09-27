require 'tempfile'

module PDFToolBox
	class QPDF
		attr_reader :core
		def initialize()
			@core = Core.new("QPDF")
		end
	end
end