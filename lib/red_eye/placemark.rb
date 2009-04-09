module RedEye
  class Placemark
    
    attr_accessor :address, :point, :accuracy
    
    def initialize options = {}
      options.each_pair {|key, value| send("#{key}=", value)}      
    end
  end
end