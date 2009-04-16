require File.dirname(__FILE__) + '/test_helper.rb'

class TestRedEye < Test::Unit::TestCase

  def setup
    @geocoder = RedEye::GeoCoder.new
  end
  
  def test_simple_geocode
    query = "1600 Amphitheatre Parkway, Mountain View, CA"
    result = @geocoder.geocode query
    
    assert result.success?
    
    assert_equal query, result.name
    assert_equal 1, result.placemarks.size
    assert_equal RedEye::Constants::Accuracy::ADDRESS, result.placemarks.first.accuracy
    assert_equal "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA", result.placemarks.first.address
    assert_equal RedEye::LatLng.new(:lat => 37.421972, :lng => -122.084143), result.placemarks.first.point
  end
  
  def test_reverse_geocode
    query = RedEye::LatLng.new :lat => 40.714224, :lng => -73.961452
    result = @geocoder.geocode query
    
    assert result.success?
    
    assert_equal query.to_s, result.name
    assert_equal 8, result.placemarks.size
    assert_equal RedEye::Constants::Accuracy::ADDRESS, result.placemarks.first.accuracy
    assert_equal RedEye::LatLng.new(:lat => 40.7142298, :lng => -73.9614669), result.placemarks.first.point
    
    assert_equal "275-291 Bedford Ave, Brooklyn, NY 11211, USA", result.placemarks[0].address
    assert_equal "Williamsburg, NY, USA", result.placemarks[1].address
    assert_equal "New York 11211, USA", result.placemarks[2].address
    assert_equal "Kings, New York, USA", result.placemarks[3].address
    assert_equal "Brooklyn, NY, USA", result.placemarks[4].address
    assert_equal "New York, NY, USA", result.placemarks[5].address
    assert_equal "New York, USA", result.placemarks[6].address
    assert_equal "United States", result.placemarks[7].address
  end
  
  def test_bias
    query = "Winnetka"
    bias = RedEye::Bias.new :center => RedEye::LatLng.new(:lat => 34.197605, :lng => -118.546944),
                            :span => [0.247048, 0.294914]                        
    result = @geocoder.geocode query, :bias => bias
    
    assert result.success?
    
    assert_equal query, result.name
    assert_equal 1, result.placemarks.size
    assert_equal RedEye::Constants::Accuracy::TOWN, result.placemarks.first.accuracy
    assert_equal "Winnetka, California, USA", result.placemarks.first.address
    assert_equal RedEye::LatLng.new(:lat => 34.2131710, :lng => -118.5710220), result.placemarks.first.point  
  end
  
  def test_country_bias
    query = "Toledo"
    result = @geocoder.geocode query, :country => "es"
    
    assert result.success?

    assert_equal query, result.name
    assert_equal 1, result.placemarks.size
    assert_equal RedEye::Constants::Accuracy::TOWN, result.placemarks.first.accuracy
    assert_equal "Toledo, Spain", result.placemarks.first.address
    assert_equal RedEye::LatLng.new(:lat => 39.8567775, :lng => -4.0244759), result.placemarks.first.point  
  end
end
