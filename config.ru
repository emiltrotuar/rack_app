require 'rack'

#\ -w -p 8765
use Rack::Reloader, 0
use Rack::ContentLength

class SingleSysInfo
	def call env
		@request = Rack::Request.new env
		@response = Rack::Response.new
		@response['Content-Type'] = 'text/plain'
		@response.status=200
		@response.body = case @request.path
		when "/"
			["please enter /help for commands reference"]
		when "/memory"
			[`free -m`]
		when "/disc"
			[`df -h`]
		when "/help"
			["/memory - amount of free and used memory in the system\n
				/disc - file system disk space usage\n
				/help - this page"]	
		else
			[Rack::Response.new("Not found", 404)]
		end
		@response.finish
	end
end
	
run SingleSysInfo.new