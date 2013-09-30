songs = [
  "Phoenix - 1901",
  "Tokyo Police Club - Wait Up",
  "Sufjan Stevens - Too Much",
  "The Naked and the Famous - Young Blood",
  "(Far From) Home - Tiga",
  "The Cults - Abducted",
  "Phoenix - Consolation Prizes"
]

def rock_out(song_to_play, song_list)
  normalized = []
  song_list.each do |song|
    stripped = song.delete('-').gsub(/[^\w\s]/, '').split(' ')
    words = stripped.join('.').downcase
    normalized << "#{words}.mp3"
  end
  play = fork { exec 'afplay', "#{normalized[song_to_play]}"}
  puts "Playing #{song_list[song_to_play]}..."
  puts "(Press Enter to stop.)"
  input = gets.downcase.strip
  stop = fork { exec 'killall', 'afplay' }
end

def interpret(input, song_list)
  artists = []
  tracks = []
  song_to_play = nil
  song_list.each do |song|
    artists << song.split(' - ')[0].downcase
    tracks << song.split(' - ')[1].downcase
  end

  if input.respond_to?(:to_i) && input.length < 2
    song_to_play = input.to_i - 1
  else
    artists.each_with_index do |artist, index|
      if artist.gsub(/[^\w\s]/, '') == input || artist == input
        if artist == "phoenix"
          puts "Which Phoenix song would you like to hear?"
          puts "Type 1 for '1901' or 2 for 'Consolation Prizes'"
          phoenix_input = gets.downcase.chomp.to_i
          if phoenix_input == 1
            song_to_play = 0
            break
          elsif phoenix_input == 2
            song_to_play = 6
            break
          else
            break
          end
        else
          song_to_play = index
        end
      end
    end

    tracks.each_with_index do |track, index|
      if track == input
        song_to_play = index
      end
    end
  end

  if song_to_play == nil
    puts "I don't understand, sorry."
    input = gets.downcase.strip
  else
    rock_out(song_to_play, song_list)
  end
end

def play(songs)
  system('clear')
  puts "Available Songs"
  puts ""
  songs.each_with_index do |song, index|
    puts "#{index + 1}. " + song
  end
  puts ""
  print "What would you like to hear? "
  input = gets.strip.downcase
  interpret(input, songs)
end

def jukebox(songs)

  input = ''
  while input
    system('clear')
    print "What would you like to do? Press 'play' to play a song, or 'exit' to leave: "
    input = gets.downcase.strip
    case input
    when 'play'
      play(songs)
    when 'exit'
      puts "Goodbye!"
      break
    end
  end

end

jukebox(songs)