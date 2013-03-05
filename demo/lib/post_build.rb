module PostBuild
  class << self
    def registered(app)
      app.after_build do |builder|
        # TODO: not working for some reason. move these commands to dedicated .sh
        # builder.run "copy_to_public.sh" 
        `cp -R build/ ../public/demo`

      end
    end
    alias :included :registered
  end
end

::Middleman::Extensions.register(:post_build, PostBuild) 

