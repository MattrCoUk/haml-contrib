# A PHP Filter for Haml. This simply wraps code inside <?php ?> tags. While this
# may seem like a strange idea, some people use Haml to generate mostly static
# HTML documents that then include small amounts of PHP.
#
# This code also serves as an example of how to implement a simple filter for
# Haml.
module Haml
  module Filters
    module PHP
      include Base

      def render(text)
         ##
         #  Remove comments and spacing from PHP code (minify PHP)
         #  - passing the input string (text) through 'php -w' command via shell (here string)
         #  - add <?php ?> tags as not present in haml code
         #         
         
         # escape special chars in PHP code, might need to use shellscape or similar
         text=text.gsub("\\", "\\\\\\").gsub("\"", "\\\"").gsub("$", "\\$").gsub("`", "\\\\`") 
         
         
         `php -w <<< "<?php #{text} ?>"`
        

        ##
        #   Original code (without minification)
        #   
        #   DODO: find the way to switch between them
        #
        #  "<?php\n  %s\n?>" % text.rstrip.gsub("\n", "\n  ")
        
      end
    end
  end
end