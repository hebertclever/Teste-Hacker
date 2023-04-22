EARTH_R_KM = 6371 # Earth radius in km

def coordinates_distance(latitude1, longitude1, latitude2, longitude2)
  latitude1_radians  = to_radians(latitude1)
  longitude1_radians = to_radians(longitude1)
  latitude2_radians  = to_radians(latitude2)
  longitude2_radians = to_radians(longitude2)

  # Haversine Formula
  latitude_distance = latitude2_radians - latitude1_radians
  longitude_distance = longitude2_radians - longitude1_radians

  a = Math.sin(latitude_distance / 2) ** 2 + Math.cos(latitude1_radians) * Math.cos(latitude2_radians) * Math.sin(longitude_distance / 2) ** 2
  c = 2 * Math::asin(Math::sqrt(a))

  EARTH_R_KM * c
end

def to_radians(degrees)
  one_degree = (Math::PI) / 180;
  one_degree * degrees
end
