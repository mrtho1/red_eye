require 'net/http'
require 'uri'
require 'json'

module RedEye
  class GeoCoder
    attr_accessor :url_base, :key
    
    def initialize options = {}
      self.url_base = "http://maps.google.com/maps/geo?"
      self.key = GOOGLE_APP_ID
      options.each_pair {|key, value| send("#{key}=", value)}      
    end
    
    def to_url query, options = {}
      
      url_params = generate_query_params query, options
      
      params = ''
      url_params.each do |key, val|
        params << "&" unless params.empty?
        params << "#{key}=#{val}"
      end
    
      self.url_base + URI.encode(params)
    end
        
    def geocode query, options = {}
      
      #TODO MUCHO BETTERO Error Handling      
      response = Net::HTTP.get_response URI.parse(to_url(query, options))
      json_result = JSON.parse(response.body)

      result = Result.new :name => json_result["name"], 
                          :code => json_result["Status"]["code"], 
                          :raw => response.body

      if result.success?                    
        
        json_result["Placemark"].each do |json_placemark|
        
          #These are reverse for some reason
          point = LatLng.new :lng => json_placemark["Point"]["coordinates"][0],
                             :lat => json_placemark["Point"]["coordinates"][1]
                           
          placemark = Placemark.new :address => json_placemark["address"], 
                                    :point => point,
                                    :accuracy => json_placemark["AddressDetails"]["Accuracy"]
          result.placemarks << placemark
        end
      end
      
      result
    end
    
    private
    
      def generate_query_params query, options
        
        #Start off the merged_params with some defaults
        merged_params = {
          :q => query.to_s,
          :key => self.key,
          :sensor => false,
          :output => 'json',
          :oe => 'utf8'          
        }
        
        #pull in the user options one by one, substituting 
        #some of the less user friendly names
        options.each do |key, val|    
          case key
          when :key, :sensor, :gl
            merged_params[key] = val
          when :country
            merged_params[:gl] = val
          when :bias
            merged_params[:ll] = "#{val.center.to_s}"
            merged_params[:spn] = "#{val.span.join ','}"
          else
            # Not sure, raise error or ignore, ignore for now
          end
        end
        
        merged_params        
      end      
  end
end