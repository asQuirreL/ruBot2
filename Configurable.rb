=begin

Configurable module

adds ability to load plugins
and read config files.

=end

module Configurable

=begin

Dependencies:

Instances extended by this module must have an @bot instance variable.

=end

	def load_plugin filename
		raise ArgumentError, "No Such Plugin" if !File.exists? filename
		
		if filename =~ /([a-zA-Z0-9_]+)\.rb$/i
			var_name = "$rbp_" + $1
		else
			raise ArgumentError, "Plugin name in incorrect format, \'#{ filename }\'"
		end
		
		require filename
		if eval( "defined? #{var_name}" ).nil?
			raise ArgumentError, "Plugin variable not defined in correct format: \'#{var_name}\'"
		end

		plugin = eval( var_name )
		
		if !(@bot.plugins.include? plugin)
			plugin.bot = @bot
			plugin.loaded
		end
		
		@bot.plugins = @bot.plugins | [plugin]
	end
	
	def load_config filename
	end
end
