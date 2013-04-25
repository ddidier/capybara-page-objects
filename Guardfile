# ----------------------------------------------------------------------------------------------------------------------
# More info at https://github.com/guard/guard#readme
# ----------------------------------------------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------------------------------------------
# bundler
# ----------------------------------------------------------------------------------------------------------------------

guard 'bundler' do
  watch('Gemfile')
end


# ----------------------------------------------------------------------------------------------------------------------
# spork (must be before rspec and cucumber)
# ----------------------------------------------------------------------------------------------------------------------

rspec_port = rand(50_000) + 10_000

guard 'spork',
      :rspec_port => rspec_port,
      :wait => 60 do

  watch('Gemfile')
  watch('Gemfile.lock')

  # ----- spec directory
  watch('spec/spec_helper.rb')

  # ----- dummy app directory
  watch('spec/dummy/config/application.rb')
  watch('spec/dummy/config/environment.rb')
  watch('spec/dummy/config/environments/test.rb')
  watch(%r{^spec/dummy/config/initializers/.+\.rb$})

  # ----- spec directory
  watch('spec/spec_helper.rb')
end


# ----------------------------------------------------------------------------------------------------------------------
# rspec
# ----------------------------------------------------------------------------------------------------------------------

guard 'rspec',
      :all_after_pass => false,
      :all_on_start => false,
      :cli => "--colour --drb --format documentation --drb-port #{rspec_port} --tag focused" do

  # ----- lib directory
  watch(%r{^lib/(.+)\.rb$})                       { |m| %W(spec/#{m[1]}_spec.rb)  }
  watch(%r{^lib/capybara-page-objects/node.rb$})  {     %W(spec)                  }

  # ----- spec directory
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$})                                  {     %W(spec)                                        }
  watch(%r{^spec/capybara-page-objects/shared_examples_for_node.rb$}) {     %W(spec)                                        }
  watch(%r{^spec/dummy/app/views/pages/(.+)\.html\.erb$})             { |m| %W(spec/capybara-page-objects/#{m[1]}_spec.rb)  }



  ## ----- app directory
  #watch('spec/dummy/app/controllers/application_controller.rb')  {     %W(spec/controllers)                            }
  #watch(%r{^spec/dummy/app/controllers/(.+)_controller\.rb$})    { |m| %W(spec/controllers/#{m[1]}_controller_spec.rb
  #                                                                        spec/routing/#{m[1]}_routing_spec.rb)        }
  #watch(%r{^spec/dummy/app/helpers/(.+)_helper\.rb$})            { |m| %W(spec/helpers/#{m[1]}_helper_spec.rb)         }
  #watch(%r{^spec/dummy/app/mailers/(.+)_mailer\.rb$})            { |m| %W(spec/mailers/#{m[1]}_mailer_spec.rb)         }
  #watch(%r{^spec/dummy/app/models/(.+)\.rb$})                    { |m| %W(spec/models/#{m[1]}_spec.rb
  #                                                                        spec/decorators/#{m[1]}_decorator_spec.rb)   }
  #watch(%r{^spec/dummy/app/views/(.+)/.*\.erb$})                 { |m| %W(spec/views/#{m[1]}_spec.rb)                  }
  #
  ## ----- config directory
  #watch('spec/dummy/config/routes.rb')                           {     %W(spec/routing)                                }
  #
  ## ----- spec directory
  #watch(%r{^spec/.+_spec\.rb$})
end
