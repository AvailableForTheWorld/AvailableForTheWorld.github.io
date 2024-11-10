module Jekyll
  # This class is a Jekyll Generator plugin that creates individual pages for each tag
  class TagPageGenerator < Generator
    safe true  # Declares this generator as safe for GitHub Pages (though note: GitHub Pages doesn't actually run custom plugins)

    def generate(site)
      # Only generate tag pages if there's a 'tag' layout available
      if site.layouts.key? 'tag'
        # Iterate through each tag used in the site
        site.tags.each_key do |tag|
          # Create a new TagPage for each tag
          site.pages << TagPage.new(site, site.source, tag)
        end
      end
    end
  end

  # This class represents a single tag page
  class TagPage < Page
    def initialize(site, base, tag)
      @site = site          # Jekyll site object
      @base = base          # Site source directory
      @dir = File.join('tag', tag.downcase)  # Creates URL path like /tag/jekyll/
      @name = 'index.html'  # Creates index.html in that directory

      # Process the page
      self.process(@name)
      # Read the tag.html layout file
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      # Set page-specific data
      self.data['tag'] = tag
      self.data['title'] = "Posts tagged with \"#{tag}\""
    end
  end
end