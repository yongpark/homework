def album_tracks
  albums = self.albums.select("albums.*, COUNT(*) AS tracks_count").joins(:tracks).group("albums.id")

    album_counts = {}
    albums.each do |album|
      album_counts[album.name] = album.tracks_count
    end

    album_counts
end



def seeds
  plants = self.plants.includes?(:seeds)
  seeds = []

  plants.each do plant
    seeds << plant.seeds
  end

  seeds
end


def drivers
  buses = self.buses.include?(:drivers)
  drivers = {}
  buses.each do |bus|
    drivers = []
    bus.drivers.each do |driver|
      drivers << drivers
    end
    drivers[bus.id] = drivers
  end
  drivers
end
