require "open3"
require 'open-uri'
require "tmpdir"

module PDFToolBox
	class MissingLibrary < StandardError
		def initialize (args = {})
			super("#{args[:libraryname]} is not installed on your system.")
		end
	end
	
	class CommandError < StandardError 
		
		def initialize (args = {})
			super("#{args[:stderr]} #!# While execuing #=> `#{args[:cmd]}`")
		end
	end
	
	class Core 
		attr_reader :input_params
		def initialize(input_params = {})
			@input_params = input_params
			@input_params[:qpdf_path] ||= locate_qpdf || "qpdf"
			raise(MissingLibrary, {:libraryname => "QPDF"}) if qpdf_version.to_f == 0
			
			@input_params[:pdftk_path] ||= locate_pdftk || "pdftk"
			raise(MissingLibrary, {:libraryname => "pdftk"}) if pdftk_version.to_f == 0
		end
		
		
		def self.locate_qpdf
			@qpdf_location ||= begin
				auto_path = %x{locate qpdf | grep "/bin/qpdf"}.strip.split("\n").first
				(auto_path.nil? || auto_path.empty?) ? nil : auto_path
        	end			
		end
		
		def locate_qpdf
			self.class.locate_qpdf
		end
		
		def self.locate_pdftk
			@pdftk_version ||= begin
				auto_path = %x{locate pdftk | grep "/bin/pdftk"}.strip.split("\n").first
				(auto_path.nil? || auto_path.empty?) ? nil : auto_path
        	end		
		end
		
		def locate_pdftk
			self.class.locate_pdftk
		end
		
								
		def pdftk_version
			%x{#{@input_params[:pdftk_path]} --version}.gsub(/\r\n|\r/, "\n").scan(/pdftk (\S*) a Handy Tool/).join
		end 
				
		def qpdf_version
			%x{#{@input_params[:qpdf_path]} --version}.gsub(/\r\n|\r/, "\n").scan(/version (\S*)\n/).join
		end 
		
		def pdftk(input_params = {})
			@input = nil 
			@output = nil 
			@error = nil 
			@input_file_map = nil 
			input_params = @input_params.merge(input_params)
			cmd ="./public/outfile.pdf ./public/outfile22.pdf" #{@input_params[:operation]} output #{@input_params[:output]}"	
			run_cmd(cmd)	
		end
		
		def qpdf(input_params = {})
			@input = nil 
			@output = nil 
			@error = nil 
			@input_file_map = nil 
			input_params = @input_params.merge(input_params)
			cmd = "#{@input_params[:qpdf_path]} #{input_params[:in_file_path]} #{input_params[:operation]} #{input_params[:out_file_path]}"
			run_cmd(cmd)
		end
		
		def run_cmd(cmd)		
			Open3.popen3(cmd) do | stdin, stdout , stderr |
				if @input
					@input.rewind
					stdin.puts @input.read 
				end
				stdin.close 
				
				@output.puts stdout.read if @output && !@output.is_a?(String)
				raise(CommandError, {:stderr => @error, :cmd => cmd}) unless (@error = stderr.read).empty?
			end		
		end
	
	end
	
end