#!/usr/bin/env ruby
require 'rubygems'
require 'gollum/auth' # Don't forget to load the gem!
require 'gollum/app'

module Gollum
   class Macro
      class NiceTOC < Gollum::Macro
         def render
            return if @wiki.pages.size.zero?
            @nest_dir=[]
            @current_page_dir = ''
            if is_sidebar
               @current_page_dir = Pathname(@page.parent_page.path).dirname.to_s
               @current_page_dir += '/'
            end

            content_tag("ul") {
               wiki.map { |name, page|
                  @nest_dir.clear
                  list_item(name, page)
               }.compact.join
            }
         end

         private

         def is_sidebar()
            @page.path.start_with?('_Sidebar')
         end

         def add(subtree, filename_parts, gollum_page)
            head, *tail = filename_parts
            subtree[head] ||= {}

            if tail.empty?
               subtree[head] = gollum_page
            else
               add(subtree[head], tail, gollum_page)
            end

            subtree
         end

         def content_tag(html_tag_name, options = {}, &block)
            tag = [html_tag_name]

            [:class, :href].each do |option|
               tag << "#{option.to_s}=\"#{options[option]}\"" if options[option]
            end

            content = ""
            content += "<#{tag.compact.join(" ")}>"
            content += (yield block).to_s.gsub(/\n/, "")
            content += "</#{html_tag_name}>"
            content
         end

         def list_item(name, gollum_page)
            if gollum_page.is_a?(::Gollum::Page)
               return if @page.url_path == gollum_page.url_path

               _current_page_class = is_sidebar && @page.parent_page.url_path == gollum_page.url_path ? "current-page" : ""

               content_tag("li", class: _current_page_class ) {
                  content_tag("a", href:"/"+ gollum_page.url_path) {
                     gollum_page.metadata_title || gollum_page.name
                  }
               }
            else
               _dir_class = ''
               _side_bar_dir_title = ""
               if is_sidebar
                  @nest_dir << name
                  _nest_dir_str = @nest_dir.join('/') + "/"
                  _dir_class = "sidebar-dir "

                  _side_bar_dir_title = "sidebar-dir-title"
                  if !@current_page_dir.start_with?(_nest_dir_str)
                     _dir_class += " collapsed "
                  end
               end
			   
               content_tag("li", class: _dir_class) {
                  content_tag("span", class: _side_bar_dir_title) {
                     content_tag("span") { name }
                  } +
                  content_tag("ul") {
                     _temp = gollum_page.map { |nom, page| list_item(nom, page) }.join
					 if is_sidebar
					   @nest_dir.pop
					 end
					 _temp
                  }
               }
            end
         end

         def wiki
            @wiki.pages.reduce({}) { |tree, gollum_page|
               add(
               tree,
               Pathname(gollum_page.path).each_filename.to_a,
               gollum_page
               )
            }
         end
      end
   end
end

users = YAML.load %q{
---
- username: rick
  password: asdf754&1129-@lUZw
  name: Rick Sanchez
  email: rick@example.com
- username: morty
  password_digest: 5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5
  name: Morty Smith
  email: morty@example.com
- username: zzh
  password_digest: e1fb1ce32c7986123f2f37b20540105a3ad70df1557914a9eeb5aa6c0108fc3b
  name: zzh
  email: zzh@example.com
}

# Allow unauthenticated users to read the wiki (disabled by default).
options = { allow_unauthenticated_readonly: true }

# Allow only authenticated users to change the wiki.
# (NOTE: This must be loaded *before* Precious::App!)
use Gollum::Auth, users, options

wiki_options = {
   #  universal_toc: true,
   #  index_page: "Index",
   mathjax: true,
   css: true,
   js: true,
#   local_time: true,
   show_local_time: true,
   sidebar: :left,
#   static: true
}

#gollum_path = File.expand_path(File.join(File.dirname(__FILE__), 'wiki/.git')) # CHANGE THIS TO POINT TO YOUR OWN WIKI REPO

#Precious::App.set(:environment, ENV.fetch('RACK_ENV', :production).to_sym)
Precious::App.set(:environment, :production)
Precious::App.set(:gollum_path, '/wiki/.git')
Precious::App.set(:default_markup, :markdown) # set your favorite markup language
Precious::App.set(:wiki_options, wiki_options)
run Precious::App
