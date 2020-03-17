# A PHP Filter for Haml. This simply wraps code inside <?php ?> tags. While this
# may seem like a strange idea, some people use Haml to generate mostly static
# HTML documents that then include small amounts of PHP.
#
# This code also serves as an example of how to implement a simple filter for
# Haml.
module Haml
   module Filters
      
      
      ##
      #  passing the input string (text str) through 'php -w' command via shell (here string) for minification
      #  wrap the output in <?php ?> tag
      # 
      module PHP
         include Base
       
         def render(text)

            # escape special chars in PHP code, probably better to use might need to use shellscape or similar
            text=text.gsub("\\", "\\\\\\").gsub("\"", "\\\"").gsub("$", "\\$").gsub("`", "\\\\`") 
                        
            `php -w <<< "<?php #{text} ?>"`
           
         end
      end
      
      
      ##
      #  - same as aboove but omits the closing tag ?>
      #  useful in PHP-only files
      # 
      module PHP_nocl
         include Base

         def render(text)

            text=text.gsub("\\", "\\\\\\").gsub("\"", "\\\"").gsub("$", "\\$").gsub("`", "\\\\`") 

            `php -w <<< "<?php #{text}"`
           
         end
      end
      
      
      ##
      #  no minifications, all PHP code passed as is, wrapped in <?php ?> tag
      #  useful in debugging :-)  
      #
      module PHP_nomin
         include Base

         # no minification
         def render(text)
            "<?php\n  %s\n?>" % text.rstrip.gsub("\n", "\n  ")
         end
      end
   end
end