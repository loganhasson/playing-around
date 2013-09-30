play = fork { exec 'afplay', 'sufjan.stevens.too.much.mp3'}
sleep(3)
stop = fork { exec 'killall', 'afplay' }
puts "hi"
#exec('killall', 'afplay')
#system('killall afplay')