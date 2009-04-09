module RedEye
  class Bias
    attr_accessor :center, :span
  
    def initialize options = {}
      self.center = LatLng.new
      self.span = []
    
      options.each_pair {|key, value| send("#{key}=", value)}    
    end
  end
end