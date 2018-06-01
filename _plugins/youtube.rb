# Jekyll plugin to embed youtube video from its ID using tag and filter
# original script https://gist.github.com/joelverhagen/1805814

module Jekyll
    class YouTube < Liquid::Tag
        Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

        def initialize(tagName, markup, tokens)
            super

            if markup =~ Syntax then
                @id = $1

                if $2.nil? then
                    @width = 560
                    @height = 420
                else
                    @width = $2.to_i
                    @height = $3.to_i
                end
            else
                raise "No YouTube ID provided in the \"youtube\" tag"
            end
        end

        def render(context)
            "<div class=\"youtube-container\"><iframe src=\"https://www.youtube.com/embed/#{@id}\" class=\"youtube-embed\" frameborder=\"0\" allowfullscreen></iframe></div>"
        end
    end
end
Liquid::Template.register_tag('youtube', Jekyll::YouTube)

module Jekyll
    module YoutubeRender
        def youtube(input)
            "<div class=\"youtube-container\"><iframe src=\"https://www.youtube.com/embed/#{input}\" class=\"youtube-embed\" frameborder=\"0\" allowfullscreen></iframe></div>"
        end
    end
end
Liquid::Template.register_filter(Jekyll::YoutubeRender)
