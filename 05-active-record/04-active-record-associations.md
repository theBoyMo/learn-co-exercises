### Active Record Associations

Active record associations allows you to create the has-many/belong-to and the many-to-many or has-many-through relationships between your classes/models with very little code. Active record facilitates the creation of the following relationships between models:
 * belongs_to
 * has_one
 * has-many
 * has_many :through
 * has_one :through
 * has_and_belongs_to_many

Building these relationships, we need to:
 * write a migrations that create tables with associations, e.g. if a song belongs to an artist, add an artist_id column to the songs table, and
 * use ActiveRecord macros in the models to create the relationships.


### A Worked Example

Using the example of artists, songs and genres, we can enact the following relationships:
  * an artist has many songs and a song belongs to an artist.
  * a genre has many songs and a song belongs to a genre.
  * artists have many genres through songs.
  * a genre has many artists through songs.

#### Song Model

A song belongs to both an artist and a genre, and so will need an artist_id and genre_id columns. These foreign keys, in conjunction with ActiveRecord macros will enable the creation of the has_many, belongs_to and has_many :through relationships. This will allow us to retrieve an artist's songs or genres, a song's artist or genre, and a genre's songs and artists.

The songs table acts as a joins table, connecting the artists and genres tables through the foreign keys, artist_id and genre_id. The relationships we'll create through ActiveRecord macros. This means that a song can have many genres through songs and a genre can have many artists through songs - creating a many-to-many relationship. Migration for the songs table:

```ruby
  class CreateSongs < ActiveRecord::Migration
    def change
      create_table :songs do |t|
        t.string :name
        t.integer :artist_id
        t.integer :genre_id
      end
    end
  end
```

#### Artist Model

An artist will have many songs and it will have many genres through songs. These associations will be taken care of entirely through ActiveRecord macros. The Artist model requires only two column, id and name.

```ruby
  class CreateArtists < ActiveRecord::Migration
    def change
      create_table :artists do |t|
        t.string :name
      end
    end
  end
```

#### Genre Model

A genre will have many songs and it will have many artists through songs. These associations will be taken care of entirely through ActiveRecord macros. The Genre model requires only two columns, id and name.

```ruby
  class CreateGenres < ActiveRecord::Migration
    def change
      create_table :genres do |t|
        t.string :name
      end
    end
  end
```

Don't forget the run 'rake db:migrate' to create the database tables.


### Building Associations

The has_many, has_many :through, and belongs_to relationships are created using ActiveRecord macros - these are simply methods that can be used to implement these associations. These macros are added to our models, which need to inherit from ActiveRecord::Base. In order to create the 'song belongs to artist' relationship, add the belongs_to macro to the Song model(repeat for genre)

```ruby
  class Song < ActiveRecord::Base
    belongs_to :artist
    belongs_to :genre
  end
```

An artist has many songs, add the has_many macro to the Artist model to create the association. Because each song has an artist_id and the has_many macro, we can re-create the has_many relationship. An artist also has many genres, use the has_many through macro. Repeat the process for the Genre model.

```ruby
  class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs
  end

  class Genre < ActiveRecord::Base
    has_many :songs
    has_many :artists, through: :songs
  end
```

### Testing the Associations

Launch a Pry console by running 'rake console', and create a few songs & artists:

```ruby
hello = Song.new(name: "Hello")
#=> <Song:0x007fc75a8de3d8 id: nil, name: "Hello", artist_id: nil, genre_id: nil>
hotline_bling = Song.new(name: "Hotline Bling")
#=> <Song:0x007fc75b9f3a38 id: nil, name: "Hotline Bling", artist_id: nil, genre_id: nil>
someone_like_you = Song.new(name: "Someone Like You")
#=> <Song:0x007fc75b5cabc8 id: nil, name: "Someone Like You", artist_id: nil, genre_id: nil>

adele = Artist.new(name: "Adele")
#=> <Artist:0x007fc75b8d9490 id: nil, name: "Adele">
drake = Artist.new(name: "Drake")
#=> <Artist:0x007fc75b163c60 id: nil, name: "Drake">
```

To associate a song to an artist we could set 'hello.artist_id = adele.id', but ActiveRecord macros allow us to associate an artist object directly to a song, e.g.

```ruby
  hello.artist = adele
  hello.artist #=> <Artist:0x007fc75b8d9490 id: nil, name: "Adele">
  hello.artist.name #=> 'Adele'
  hello
  #=> <Song:0x007fc75a8de3d8 id: nil, name: "Hello", artist_id: nil, genre_id: nil>
  # the song.artist_id is unchanged in this case because the artist has not been saved and so has no id. When the song/artist is saved, e.g 'song.save' => song.artist_id is updated with the artist's id.
  song.save #=> returns true if the object was saved, the object was valid
  song
  #=> <Song:0x007fc75a8de3d8 id: nil, name: "Hello", artist_id: nil, genre_id: 1>
```

However, when we interrogate the artist object for their songs, the collection is empty

```ruby
  adele.songs #=> []
```


### Has_many & belongs_to methods

The model that has the 'has_many' relationship is considered the parent, the model with the 'belongs_to', the child. If you tell the child that it belongs to the parent, the parent won't know about that relationship, e.g. 'hello.artist = adele'. If you tell the parent that a certain child object has been added to its collection, both the parent and the child will know about the association. Thus:

```ruby
  # creates 'has_many' and reciprocal 'belongs_to' relationships
  # 'has_many' stores those objects in an array
  adele.songs << someone_like_you
  adele.songs << Song.new(name: 'Some One Like You') # creates song and adds it to the songs  collection

  adele.songs
  #=> [#<Song:0x007fc75b5cabc8 id: nil, name: "Someone Like You", artist_id: nil, genre_id: nil>]
  someone_like_you.artist
  #=> <Artist:0x007fc75b8d9490 id: nil, name: "Adele">
  someone_like_you.artist.name
  #=> 'Adele'
```

The 'adele.songs << song' method is an inefficient way of adding songs to the artist's songs collection, the method returns the entire collection. A better technique is to use the '#build' or '#create' methods to create a song event though they're called on the artist instance.

```ruby
  adele.songs.build(name: 'Some One Like You')
  #=> #<Song id:nil, name: 'Some One Like You', artist_id: 1, genre_id: nil>
  adele.save #  inserts the song into the songs table
```

The method will create the song, add it to the 'songs' collection and automatically associates it with the artist_id(if the artist has been previously saved), but does not have it's own id because it is yet to be saved. To save the song to the 'songs' table, 'adele.save' - until that point it exists in memory. To create and save the song, use 'create'.

```ruby
  adele.songs.create(name: 'Some One Like You')
  #<Song id:4, name: 'Some One Like You', artist_id: 1, genre_id: nil>
```

Note: 'adele.songs.build' and 'adele.songs.create' are 'has_many' methods - an artist has many songs. There are also 'belongs_to' methods, the song belongs to the artist, e.g.

```ruby
  song = Song.new(name: 'Song Remains the Same') # creates song => can't be saved until associated with an artist
  song.build_artist(name: 'Led Zeppelin') # creates artist
  song.save # saves both artist and song to their respective tables (two inserts are executed) - and adds song to artist.songs collection

  song.create_artist(name: 'Led Zeppelin') # creates and saves artist, but not song, requires artist_id
  song.save # inserts into songs table
```

Note: Methods to be aware of:

 * belongs_to => artist, artist=, build_artist, create_artist, create_artist!
 * has_many => songs, songs<<, create, build (generally use build and not create in a request cycle)
 * song.persisted? => check if the instance has been saved to the database



#### Validate objects

 Validations only run when you try to save the object or validate it, e.g. song.valid?.

 * song.valid? => check if the object is valid, only valid objects can be saved. The 'save' method will return true/false depending on whether the object was saved.
 * song.errors => returns an error object which will include any errors(messages attribute) the object has, e.g. not valid.
 * song.errors.full_messages => returns an array of all the error messages
 * song.errors.any? => returns a boolean



### Active Record Life Cycle Events

Don't override, #initialize method in your model classes. ActiveRecord provides life-cycle methods (callbacks) that you can hook into to control the objects' life-cycle. There a re a number of life-cycle events you can hook into, e.g.
 * before_save
 * after_save
 * before_create
 * after_create
 * before_update
 * after_update
 * before_destroy
 * after_destroy

To 'hook' into a particular event, have it call a method, e.g.

```ruby
class Artist < ApplicationRecord
  has_many :songs

  validates :name, :presence => true
  validates :name, :length => {:minimum => 5}

  after_create :email_people # execute after every artist instantiation
  after_save :notify_admin

  def email_people
    # Do some thing
  end

  def notify_admin
    # do some thing
  end

end

```
