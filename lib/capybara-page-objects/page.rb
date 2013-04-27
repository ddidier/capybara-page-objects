# -*- encoding : utf-8 -*-
require 'facets/array/extract_options'
require 'capybara-page-objects/node'

module CapybaraPageObjects

  # An HTML page.
  #
  # Each subclass must define a parameterized path using the <tt>#path</tt>
  # class method. These parameters are then specified on instance creation.
  class Page < Node

    # ------------------------------------------------------------------------------------------------- attributes -----

    attr_reader :path,
                :path_ids,
                :path_parameters,
                :query_parameters

    # ------------------------------------------------------------------------------------------- instance methods -----

    # -------------------- public
    public

    def_delegators :session,
                   :current_path, :current_url

    # Creates a new page instance with the specified path parameters and query parameters.
    #
    # If the raw path has not been set with <tt>#path</tt>, a <tt>MissingPathError</tt> is raised.
    # The raw path must not contains query parameters.
    #
    # If any path parameter is missing, a <tt>MissingPathSegmentError</tt> is raised.
    #
    # If there is a path parameter and no query parameter, eg. path is '/some/:p1/path':
    #   MyPage.new(p1: 'v1')
    #   MyPage.new(path_parameters: {p1: 'v1'})
    # will give '/some/v1/path'
    #
    # If there is no path parameter and a query parameter, eg. path is '/some/path:
    #   MyPage.new(q2: 'v2')
    #   MyPage.new(query_parameters: {q2: 'v2'})
    # will give '/some/path?q2=v2'
    #
    # If there is a path parameter and a query parameter, eg. path is '/some/:p1/path:
    #   MyPage.new(p1: 'v1', q2: 'v2')
    #   MyPage.new(path_parameters: {p1: 'v1'}, query_parameters: {q2: 'v2'})
    # will give '/some/v1/path?q2=v2'
    #
    def initialize(*args)
      super(Capybara.current_session)
      options = args.extract_options!

      check_path_ids
      @path_ids = raw_path.scan(/:(\w+)/).flatten.map(&:to_sym)

      @path_parameters = options.delete(:path_parameters) || extract_path_parameters(options)
      @query_parameters = options.delete(:query_parameters) || extract_query_parameters(options)
      check_path_parameters

      @path = interpolate_path
    end

    # Visits the page with the interpolated path.
    def visit
      source.visit path
    end

    # Returns true if the actual current path is equal to the interpolated one.
    # Any trailing slash is not taken into account.
    def displayed?
      normalize_path(path) == normalize_path(source.current_path)
    end

    # Returns the page title.
    def title
      source.title
    end

    alias_method :session, :source

    # -------------------- protected
    protected

    # -------------------- private
    private

    # Checks that the raw path has been set.
    def check_path_ids
      raise MissingPathError, "Undefined raw path: use 'Page#path'" unless defined? raw_path
    end

    # Checks that all path parameters are specified.
    def check_path_parameters
      specified_segment_ids = path_parameters.keys
      missing_segment_ids = path_ids - specified_segment_ids
      raise MissingPathSegmentError, "Undefined path segment(s): #{missing_segment_ids.join(', ')}" unless missing_segment_ids.empty?
    end

    # An option whose key is a path ID is a path parameter.
    def extract_path_parameters(options)
      options.clone.keep_if { |k, v| path_ids.include?(k) }
    end

    # An option whose key is not a path ID is a query parameter.
    def extract_query_parameters(options)
      options.clone.delete_if { |k, v| path_ids.include?(k) }
    end

    # Returns the interpolated path appended with the query parameters.
    def interpolate_path
      # interpolate the path with the specified segment IDs
      interpolated_path = raw_path.gsub(/:(\w+)/) { path_parameters[$1.to_sym] }
      target = interpolated_path

      # append query parameters for the remaining entries
      parameter_pairs = query_parameters.map { |k, v| "#{k}=#{v}" }
      target += '?' + parameter_pairs.join('&') if parameter_pairs.any?

      target
    end

    # Removes the trailing slash except for the root path.
    def normalize_path(path)
      (path == '/') ? path : path.sub(%r{/$}, '')
    end

    # ---------------------------------------------------------------------------------------------- class methods -----

    # -------------------- public
    public

    # Defines the raw path on the class.
    # The raw path will be interpolated on instance creation.
    def self.path(p)
      define_method(:raw_path) { p }
    end

    # Creates then visits a new page instance with the specified path parameters
    # and query parameters.See #initialize and #visit.
    def self.visit(*args)
      new(*args).tap { |page| page.visit }
    end

    # -------------------- protected
    protected

    # -------------------- private
    private

    # ----------------------------------------------------------------------------------------------------- errors -----

    class MissingPathError < RuntimeError
    end

    class MissingPathSegmentError < RuntimeError
    end

  end

end
