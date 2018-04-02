class Movie
  def initialize(params)
    puts params

    @link = params[:link]
    @title = params[:title]
    @year = params[:year]
    @country = params[:country]
    @premiere_date = params[:premiere_date]
    @genre = params[:genre].split(',')
    @durability = params[:durability]
    @rate = params[:rate]
    @producer = params[:producer]
    @actors = params[:actors].split(',')

    @premiere_date = format_date(@premiere_date) if @premiere_date.is_a?(String)
  end

  def has_genre?(genre_name)
    @genre.include?(genre_name)
  end
 
  def format_date(date)
    date_parts = date.split('-')
    add_parts = ['-01-01', '-01']
    
    date += add_parts.fetch(date_parts.size-1, '')
    Date.parse(date)
  end

  def to_s
    "#{@title}"
  end
  
  def inspect
    "#{@title}"
  end
end
